import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

AppBar buildAppBar({String title, List<Widget> actions, BuildContext context}) {
  return AppBar(
    title: Text(
      title,
      // style: TextStyle(color: Colors.black54),
    ),
    centerTitle: true,
    elevation: 0,
    leading: IconButton(
        icon: SvgPicture.asset(
          'assets/icons/back-arrow.svg',
          color: Theme.of(context).appBarTheme.iconTheme.color,
        ),
        onPressed: () {
          Navigator.of(context).pop();
        }),
    actions: actions,
  );
}
