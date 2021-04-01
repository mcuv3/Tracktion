import 'package:flutter/material.dart';
import 'package:tracktion/colors/custom_colors.dart';

class SaveFormActions extends StatelessWidget {
  final Function onCancel;
  final Function onSave;

  const SaveFormActions({
    Key key,
    @required this.onCancel,
    @required this.onSave,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border(
              top: BorderSide(
                  color: Colors.black.withOpacity(0.2), width: 0.5))),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
                child: TextButton(
              child: Text("Cancel"),
              onPressed: onCancel,
            )),
            VerticalDivider(
              width: 1,
              color: Colors.black,
            ),
            Expanded(
                child: TextButton(
                    style: ButtonStyle(
                        overlayColor: MaterialStateProperty.all(
                            Theme.of(context)
                                .colorScheme
                                .analysis
                                .withOpacity(0.2))),
                    onPressed: onSave,
                    child: Text("Save",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.analysis)))),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ),
    );
  }
}
