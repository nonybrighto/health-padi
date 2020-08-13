import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:healthpadi/models/news.dart';
import 'package:healthpadi/widgets/app_bar.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDisplayPage extends StatefulWidget {
  final News news;
  
  NewsDisplayPage({this.news});

  @override
  _NewsDisplayPageState createState() => _NewsDisplayPageState();
}

class _NewsDisplayPageState extends State<NewsDisplayPage> {

   WebViewController _controller;
  bool pageLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(title:widget.news.host, actions: [
        pageLoading
            ? SpinKitDoubleBounce(color: Theme.of(context).primaryColor,)
            : IconButton(
                icon: Icon(Icons.refresh),
                onPressed: () {
                  _controller?.reload();
                }),
        IconButton(
            icon: Icon(Icons.web),
            onPressed: () {
              launch(widget.news.sourceUrl);
            })
      ]),
      body: WebView(
        initialUrl: widget.news.sourceUrl,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _controller = webViewController;
        },
        onPageStarted: (String url) {
          setState(() {
            pageLoading = true;
          });
        },
        onPageFinished: (String url) {
          setState(() {
            pageLoading = false;
          });
        },
      ),
    );
  }
}
