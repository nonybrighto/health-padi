import 'package:flutter/material.dart';

class MenuDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text('One'),
          ),
          ListTile(
            title: Text('Two'),
          ),
          ListTile(
            title: Text('Three'),
          ),
          ListTile(
            title: Text('Four'),
          ),
          ListTile(
            title: Text('Five'),
          )
        ],
      ),
    );
  }
}
