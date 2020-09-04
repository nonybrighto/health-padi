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
import 'package:url_launcher/url_launcher.dart';

class MenuDisplay extends StatelessWidget {
  final GlobalKey<InnerDrawerState> drawerKey;

  MenuDisplay(this.drawerKey);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [
            Theme.of(context).primaryColor,
            Theme.of(context).primaryColor.withOpacity(0.8),
            // Color(0XFF5475fe).withOpacity(0.8),
            // Color(0XFF4a96fb)
          ],
        )),
        child: ListView(
          children: <Widget>[
            SizedBox(height: 20),
            _buildAppNameHeader(),
            SizedBox(height: 70),
            _buildMenuItem('assets/icons/home.svg', 'Home', () {
              drawerKey.currentState.close();
              Provider.of<HomeModel>(context, listen: false).changeHomeIndex(2);
            }),
            _buildMenuItem('assets/icons/about.svg', 'About', () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => AboutPage()));
            }),
            _buildMenuItem('assets/icons/contact.svg', 'Contact', () {
              launch(
                  'mailto:$kContactEmail?subject=Hello&body=$kAppName - $kAppVersion \n Hi.');
            }),
            _buildMenuItem('assets/icons/share.svg', 'Share', () async {
              final ByteData bytes =
                  await rootBundle.load('assets/images/app_icon.png');
              await Share.file(kAppName, '$kAppName.png',
                  bytes.buffer.asUint8List(), 'image/png',
                  text:
                      '''Download $kAppName - $kAppVersion\n---- \n Medical Chatbot \n Health News \n Health Facts & Tips \n Locate Health Centers Easily\n Download now - $kAppStoreLink''');
            }),
            _buildMenuItem('assets/icons/rate.svg', 'Rate', () {
              LaunchReview.launch();
            }),
          ],
        ),
      ),
    );
  }

  _buildAppNameHeader() {
    return Image.asset(
      'assets/images/app_logo_alt.png',
      height: 40,
    );
  }

  _buildMenuItem(String iconPath, String title, Function onTap) {
    Color itemColor = Colors.white.withOpacity(0.8);
    return ListTile(
        leading: SvgPicture.asset(
          iconPath,
          color: itemColor,
          width: 27,
        ),
        title: Text(
          title,
          style: TextStyle(
              color: itemColor, fontSize: 17, fontWeight: FontWeight.w300),
        ),
        onTap: onTap);
  }
}
