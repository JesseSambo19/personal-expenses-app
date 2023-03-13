import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AdaptiveFlatButton extends StatelessWidget {
  // const AdaptiveFlatButton({ Key? key }) : super(key: key);

  final String
      text; // by getting input we can use this widget anywhere in our code and specify a different title
  final Function handler;

  AdaptiveFlatButton(this.text, this.handler);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS // checks if platform is IOS
        ? CupertinoButton(
            child: Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: handler,
          )
        : FlatButton(
            textColor: Theme.of(context).primaryColor,
            child: Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: handler,
          );
  }
}
