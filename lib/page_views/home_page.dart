import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:healthpadi/providers/home_model.dart';
import 'package:healthpadi/widgets/menu_display.dart';
import 'package:healthpadi/widgets/views/chat_conversation_view.dart';
import 'package:healthpadi/widgets/views/home_view.dart';
import 'package:healthpadi/widgets/views/news_view.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  Map<int, Widget> _pageContents = {};
  final GlobalKey<InnerDrawerState> _innerDrawerKey =
      GlobalKey<InnerDrawerState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InnerDrawer(
        key: _innerDrawerKey,
        onTapClose: true,
        swipe: true,
        colorTransitionScaffold: Colors.black38,
        offset: IDOffset.only(bottom: 0.05, right: 0.0, left: 0.0),
        scale: IDOffset.horizontal(0.8),
        proportionalChildArea: true, // default true
        borderRadius: 25,
        leftAnimationType: InnerDrawerAnimation.static,
        rightAnimationType: InnerDrawerAnimation.quadratic,
        backgroundDecoration: BoxDecoration(color: Colors.grey[300]),
        leftChild: MenuDisplay(),
        scaffold: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              // icon: Icon(Icons.toc, color: Colors.blue),
              icon: SvgPicture.asset("assets/icons/menu.svg", color: Colors.black54, width: 35,),
              iconSize: 50,
              onPressed: _toggle,
            ),
            title: Text(
              'hello',
              style: TextStyle(color: Colors.black54),
            ),
            backgroundColor: Colors.white,
            elevation: 0,
            centerTitle: true,
          ),
          body: Scaffold(
            backgroundColor: Colors.white,
            body: Consumer<HomeModel>(
              builder: (context, homeViewModel, child) {
                return _buildPageContent(homeViewModel.homeIndex);
                // return Text("${homeViewModel.homeIndex}");
              },
            ),
            bottomNavigationBar: ConvexAppBar(
              items: [
                TabItem(icon: Icons.home, title: 'Chat'),
                TabItem(icon: Icons.map, title: 'Locator'),
                TabItem(icon: Icons.add, title: 'Home'),
                TabItem(icon: Icons.message, title: 'Survey'),
                TabItem(icon: Icons.people, title: 'News'),
              ],
              initialActiveIndex: 2,
              onTap: (int i) => Provider.of<HomeModel>(context, listen: false)
                  .changeHomeIndex(i),
            ),
          ),
        ));
  }

  _buildPageContent(int index) {
    if (_pageContents.containsKey(index)) {
      return _pageContents[index];
    } else {
      Widget pageContent;

      switch (index) {
        case 0:
          pageContent = ChatConversationView();
          break;
        case 1:
          pageContent = Text('Locator');
          break;
        case 2:
          pageContent = HomeView();
          break;
        case 3:
          pageContent = Text('Survey');
          break;
        case 4:
          pageContent = NewsView();
          break;
      }
      _pageContents[index] = pageContent;
      return pageContent;
    }
  }

  void _toggle() {
    _innerDrawerKey.currentState.toggle();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
