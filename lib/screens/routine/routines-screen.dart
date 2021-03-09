import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class RoutinesScreen extends StatelessWidget {
  static const routeName = "/----";

  const RoutinesScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext rootContext) {
    return Material(
        child: Navigator(
      onGenerateRoute: (_) => MaterialPageRoute(
        builder: (context2) => Builder(
          builder: (context) => Scaffold(
            appBar: AppBar(title: Text('Modal Page')),
            body: SafeArea(
              bottom: false,
              child: ListView(
                shrinkWrap: true,
                controller: ModalScrollController.of(context),
                children: ListTile.divideTiles(
                  context: context,
                  tiles: List.generate(
                      100,
                      (index) => ListTile(
                            title: Text('Item'),
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => Scaffold(
                                    appBar: AppBar(
                                      title: Text('New Page'),
                                    ),
                                    body: Stack(
                                      fit: StackFit.expand,
                                      children: <Widget>[
                                        MaterialButton(
                                          onPressed: () =>
                                              Navigator.of(rootContext).pop(),
                                          child: Text('touch here'),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          )),
                ).toList(),
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
