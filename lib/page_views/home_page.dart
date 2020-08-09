import 'package:flutter/material.dart';
import 'package:healthpadi/page_views/news_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('hello'),
        centerTitle: true,
      ),
      body: Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            children: <Widget>[
              Text('content'),
              RaisedButton(
                  child: Text('Hello'),
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => NewsPage()));
                  }),
            ],
          )),
    );
  }
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text(Provider.of<HomeViewModel>(context, listen: false).name),
  //       centerTitle: true,
  //     ),
  //     body: Scaffold(
  //       backgroundColor: Colors.white,
  //       body: Column(
  //         children: <Widget>[
  //           Text(Provider.of<HomeViewModel>(context).name),
  //           RaisedButton(onPressed: () {
  //             Provider.of<HomeViewModel>(context, listen: false).changeName('new name');
  //           }),
  //           Row(
  //             children: <Widget>[
  //               RaisedButton(
  //                   child: Text('one'),
  //                   onPressed: () {
  //                     Provider.of<HomeViewModel>(context, listen: false).changeHomeIndex(1);
  //                   }),
  //               RaisedButton(
  //                   child: Text('two'),
  //                   onPressed: () {
  //                     Provider.of<HomeViewModel>(context, listen: false).changeHomeIndex(2);
  //                   }),
  //               RaisedButton(
  //                   child: Text('three'),
  //                   onPressed: () {
  //                     Provider.of<HomeViewModel>(context, listen: false).changeHomeIndex(3);
  //                   })
  //             ],
  //           ),
  //           Consumer<HomeViewModel>(
  //             builder: (context, homeViewModel, child) {
  //               return Text("current page is ${Provider.of<HomeViewModel>(context, listen: false).homeIndex}");
  //             },
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }

  @override
  void dispose() {
    super.dispose();
  }
}
