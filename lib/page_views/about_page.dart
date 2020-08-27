import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:healthpadi/utilities/constants.dart';
import 'package:healthpadi/widgets/app_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double itemSpace = 8;
    return Scaffold(
        appBar: buildAppBar(
          context: context,
          title: 'About',
        ),
        body: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height - 100),
            child: Center(
              child: Column(
                children: <Widget>[
                  Image.asset(
                    'assets/images/app_logo.png',
                    height: 50,
                  ),
                  SizedBox(
                    height: itemSpace,
                  ),
                  ConstrainedBox(
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 3 / 4),
                      child: Text(
                        '$kAppName is an application designed to provide easy health diagnostics and information to its users.',
                        textAlign: TextAlign.center,
                      )),
                  SizedBox(
                    height: itemSpace,
                  ),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        style: TextStyle(color: Colors.grey),
                        text: 'Click ',
                        children: [
                          TextSpan(
                              text: 'here',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  launch(
                                      'mailto:$kContactEmail?subject=Hello&body=$kAppName - $kAppVersion \n Hi.');
                                }),
                          TextSpan(
                            text: ' to contact us',
                          ),
                        ]),
                  ),
                   SizedBox(
                    height: itemSpace - 2,
                  ),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        style: TextStyle(color: Colors.grey),
                        text: 'Developed by ',
                        children: [
                          TextSpan(
                              text: 'nonybrighto',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  launch('http://www.nonybrighto.com');
                                }),
                        ]),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    '© 2020',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
