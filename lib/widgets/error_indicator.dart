import 'package:flutter/material.dart';

class ErrorIndicator extends StatelessWidget {
  final String errorMessage;
  final Function onReload;

  ErrorIndicator({this.errorMessage, this.onReload});
  @override
  Widget build(BuildContext context) {
    return Center(
        child: InkWell(
      child: Text(errorMessage ?? 'An error occured'),
      onTap: onReload != null
          ? () {
              onReload();
            }
          : null,
    ));
  }
}
