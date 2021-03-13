import 'package:flutter/material.dart';
import 'package:tracktion/models/app/index.dart';
import 'package:tracktion/widgets/inputs/input.dart';

Future<Rep?> noteRepModal(
    {required BuildContext context, required Rep rep}) async {
  var note = rep.notes;

  await showDialog(
    context: context,
    useSafeArea: true,
    builder: (context) => SimpleDialog(
      titlePadding: EdgeInsets.all(0),
      title: Container(
          padding: EdgeInsets.all(6),
          decoration: BoxDecoration(color: Colors.black),
          child: Text(
            "Notes",
            style: TextStyle(color: Colors.white, fontSize: 16),
          )),
      contentPadding: EdgeInsets.all(0),
      children: [
        NoteModalContent(
          note: rep.notes,
          onFinish: (val) {
            note = val;
          },
        )
      ],
    ),
  );

  if (note == '') return null;

  return Rep(
      id: rep.id,
      reps: rep.reps,
      weight: rep.weight,
      notes: note,
      rpe: rep.rpe,
      setId: rep.setId);
}

class NoteModalContent extends StatefulWidget {
  final String note;
  final Function(String value) onFinish;

  NoteModalContent({required this.note, required this.onFinish});

  @override
  _NoteModalContentState createState() => _NoteModalContentState();
}

class _NoteModalContentState extends State<NoteModalContent> {
  bool hasContent = false;
  bool isEditMode = false;
  bool isNew = false;
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    hasContent = widget.note == "";
    isNew = hasContent;
    controller.text = widget.note;
    super.initState();
  }

  @override
  void dispose() {
    widget.onFinish(controller.text);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
          padding: EdgeInsets.all(8),
          child: (isEditMode || isNew)
              ? TracktionInput(
                  maxLength: 50,
                  maxlines: 2,
                  controller: controller,
                  change: (val) {
                    if (!isNew && val != null) widget.onFinish(val);
                    setState(() {
                      hasContent = val != '';
                    });
                  },
                )
              : Container(
                  height: 50,
                  width: double.infinity,
                  child: Text(
                    controller.text,
                    textAlign: TextAlign.start,
                  ),
                )),
      Divider(
        color: Colors.black45,
        thickness: 0.5,
      ),
      IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              color: (controller.text == "" && isNew)
                  ? Colors.black45
                  : Colors.black,
              icon: Icon(isNew
                  ? (Icons.save)
                  : (isEditMode ? Icons.clear : Icons.edit)),
              onPressed: () {
                if (!isNew) {
                  widget.onFinish(controller.text);

                  return setState(() {
                    isEditMode = !isEditMode;
                  });
                }
                if (hasContent) {
                  widget.onFinish(controller.text);
                }
                Navigator.of(context).pop();
              },
              visualDensity: VisualDensity.compact,
            ),
            VerticalDivider(
              thickness: 0.5,
              color: Colors.black45,
              indent: 1,
              endIndent: 4,
            ),
            IconButton(
                icon: Icon(isNew ? Icons.clear : Icons.delete),
                onPressed: () {
                  if (!isNew) widget.onFinish("");
                  Navigator.of(context).pop();
                },
                visualDensity: VisualDensity.compact),
          ],
        ),
      )
    ]);
  }
}
