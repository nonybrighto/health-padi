import 'package:flutter/material.dart';
import 'package:healthpadi/widgets/app_bar.dart';

class AboutPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(title: 'About', ),
      body: SingleChildScrollView(
      child: Column(
          children: <Widget>[
            Text('This is about the app')
          ],
      ),
    )
    );
  }
}