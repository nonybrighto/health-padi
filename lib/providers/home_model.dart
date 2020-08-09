import 'package:flutter/material.dart';

class HomeModel extends ChangeNotifier{
 
  String _name = 'Initial';
  int _homeIndex = 0;
  String get name => _name;
  int get homeIndex => _homeIndex;

  changeName(String name){
    _name = name;
    notifyListeners();
  }

  changeHomeIndex(int index){
    _homeIndex = index;
    notifyListeners();
  }
  

}
