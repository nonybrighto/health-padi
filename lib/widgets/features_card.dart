import 'package:flutter/material.dart';

class FeaturesCard extends StatelessWidget {
  final String title;
  final String iconName;
  final Function onPressed;
  FeaturesCard({this.title, this.iconName, this.onPressed});

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width / 4;
    return InkWell(
      child: Card(
        elevation: 2,
        shape:RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10))
          ),
          constraints: BoxConstraints(minWidth: 80, minHeight: 80, maxHeight: 120, maxWidth: 120),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // SvgPicture.asset(
              //   assetIconPath,
              //   color: Colors.black54,
              //   width: 35,
              // ),
              Image.asset('assets/images/feature/$iconName.png', width: 50, height: 50,),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w500),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              )
            ],
          ),
        ),
      ),
      onTap: onPressed,
    );
  }
}
