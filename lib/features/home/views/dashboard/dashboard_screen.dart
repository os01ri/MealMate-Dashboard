import 'package:flutter/material.dart';
import 'package:mealmate_dashboard/core/constants/constants.dart';
import 'package:mealmate_dashboard/core/helper/responsive.dart';
import 'components/header.dart';


class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(child: Image.asset('assets/images/intro3.png',
        alignment: Alignment.center,
        fit: BoxFit.contain,
      )),
    );
  }
}
