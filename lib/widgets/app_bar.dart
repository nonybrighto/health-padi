import 'package:flutter/material.dart';

AppBar buildAppBar({String title, List<Widget> actions}){
    return AppBar(
      title: Text(title, style: TextStyle(color: Colors.black54),),
      centerTitle: true,
      elevation: 0,
      actions: actions,
    );
}