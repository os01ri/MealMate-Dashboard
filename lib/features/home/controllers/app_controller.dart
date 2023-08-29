import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:mealmate_dashboard/features/auth/data/models/user_model.dart';
import 'package:mealmate_dashboard/features/home/views/main/sidemenu/sections_enum.dart';

class AppController extends ChangeNotifier {

  Sections selectedSection = Sections.dashboard;

  UserModel? userModel;

  changeUser({required UserModel? user}){
    userModel = user;
    notifyListeners();
  }


  changeSelectedSection({required Sections newSection}){
    selectedSection = newSection;
    notifyListeners();
  }

  clear(){
    selectedSection = Sections.dashboard;
    userModel = null;
    notifyListeners();
  }


  reset(){
    selectedSection = Sections.dashboard;
    notifyListeners();
  }

  void controlMenu(_scaffoldKey) {
    if (!_scaffoldKey.currentState!.isDrawerOpen) {
      _scaffoldKey.currentState!.openDrawer();
    }
  }
}


