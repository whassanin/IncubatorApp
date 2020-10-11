import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';

class WebPageModel extends Model{
  int _currentPage = 0;

  int get currentPage => _currentPage;

  Widget currentWidget = Container();

  void setCurrentPage(Widget v){
    currentWidget = v;
    notifyListeners();
  }
}