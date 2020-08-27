import 'package:flutter/material.dart';

class AppRaisedButton extends StatelessWidget {
  final Function onPressed;
  final String title;
  AppRaisedButton({this.onPressed, this.title});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      textColor: Colors.white,
      color: Theme.of(context).primaryColor,
      shape: StadiumBorder(),
      onPressed: onPressed,
      child: Text(title.toUpperCase()),
    );
  }
}
