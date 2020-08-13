import 'package:flutter/material.dart';

class FeaturesCard extends StatelessWidget {
  final String title;
  final Function onPressed;
  FeaturesCard({this.title, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(
        child: Column(
          children: <Widget>[Text(title)],
        ),
      ),
      onTap: onPressed,
    );
  }
}
