import 'package:flutter/material.dart';
import 'package:healthpadi/widgets/app_raised_button.dart';

class ErrorIndicator extends StatelessWidget {
  final String errorMessage;
  final String title;
  final Function onRetry;
  final bool isEmpty; // indicates that the error signifies empty items

  ErrorIndicator(
      {this.errorMessage, this.title, this.onRetry, this.isEmpty = false});
  @override
  Widget build(BuildContext context) {
    String type = isEmpty ? 'empty' : 'error';
    return Center(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Image.asset(
          'assets/images/state/$type.png',
          height: 180,
        ),
        SizedBox(height: 15),
        Text(
          title ?? isEmpty ? 'No Results' : 'Error',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        Container(
          constraints: BoxConstraints(maxWidth: 500),
          width: MediaQuery.of(context).size.width /2,
          child: Text(
            errorMessage ?? 'An error occured',
            style: TextStyle(color: Colors.black54,),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 15),
        if (onRetry != null) AppRaisedButton(
            title: 'Retry',
            onPressed: onRetry,
          )
      ],
    ));
  }
}
