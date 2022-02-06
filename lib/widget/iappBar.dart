import 'package:flutter/material.dart';

class IAppBar extends StatelessWidget {
  @required final BuildContext context;
  @required final String text;
  final TextStyle? textStyle;
  final Color color;
  IAppBar({required this.context, required this.text, required this.color, this.textStyle});

  @override
  Widget build(BuildContext context) {

    return Container(
        height: 60,
        child: Row(
          children: <Widget>[
            Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                    margin: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                    height: 30,
                    child: IconButton(
                        icon: Icon(Icons.arrow_back, color: color),
                        onPressed: () {
                          Navigator.pop(context);
                        }))),

            Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                    margin: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                    child: Text(text,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      style: textStyle,
                    ))),

          ],
        )
    );
  }
}