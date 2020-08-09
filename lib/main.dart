import 'package:flutter/material.dart';
import 'package:healthpadi/page_views/home_page.dart';
import 'package:healthpadi/providers/home_model.dart';
import 'package:healthpadi/providers/news_list_model.dart';
import 'package:healthpadi/utilities/locator.dart';
import 'package:provider/provider.dart';

void main() {
   WidgetsFlutterBinding.ensureInitialized();
   setUpLocator();
  runApp(MultiProvider(
    providers: [
       ChangeNotifierProvider<HomeModel>(create: (_) => HomeModel()),
       ChangeNotifierProvider<NewsListModel>(create: (_) => NewsListModel())
    ],
    child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Health Padi',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

