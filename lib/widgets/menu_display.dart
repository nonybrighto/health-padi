import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:launch_review/launch_review.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healthpadi/page_views/about_page.dart';
import 'package:healthpadi/providers/home_model.dart';
import 'package:healthpadi/utilities/constants.dart';
import 'package:provider/provider.dart';

class MenuDisplay extends StatelessWidget {
  final GlobalKey<InnerDrawerState> drawerKey;

  MenuDisplay(this.drawerKey);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(color: Colors.blueGrey),
        child: Column(
          children: <Widget>[
            SizedBox(height: 30),
            _buildAppNameHeader(),
            _buildMenuItem('assets/icons/menu.svg', 'Home', () {
              drawerKey.currentState.close();
              Provider.of<HomeModel>(context, listen: false).changeHomeIndex(2);
            }),
            _buildMenuItem('assets/icons/menu.svg', 'About', () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => AboutPage()));
            }),
            _buildMenuItem('assets/icons/menu.svg', 'Share', () async {
              final ByteData bytes =
                  await rootBundle.load('assets/images/app_logo.png');
              await Share.file(kAppName, '$kAppName.png',
                  bytes.buffer.asUint8List(), 'image/png',
                  text:
                      '''Download $kAppName - $kAppVersion\n---- \n Medical Chatbot \n Health News \n Health Facts & Tips \n Locate Health Centers Easily''');
            }),
            _buildMenuItem('assets/icons/menu.svg', 'Rate', () {
              LaunchReview.launch();
            }),
          ],
        ),
      ),
    );
  }

  _buildAppNameHeader() {
    return Text(kAppName);
  }

  _buildMenuItem(String iconPath, String title, Function onTap) {
    return ListTile(
        leading: SvgPicture.asset(
          iconPath,
          color: Colors.white,
          width: 35,
        ),
        title: Text(
          title,
          style: TextStyle(color: Colors.white54),
        ),
        onTap: onTap);
  }
}
