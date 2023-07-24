import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:mealmate_dashboard/features/home/views/main/sidemenu/sections_enum.dart';

class MenuAppController extends ChangeNotifier {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  Sections selectedSection = Sections.dashboard;


  changeSelectedSection({required Sections newSection}){
    selectedSection = newSection;
    notifyListeners();
  }


  void controlMenu() {
    if (!_scaffoldKey.currentState!.isDrawerOpen) {
      _scaffoldKey.currentState!.openDrawer();
    }
  }
}


