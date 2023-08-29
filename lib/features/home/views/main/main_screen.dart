import 'dart:math';

import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:mealmate_dashboard/core/constants/constants.dart';
import 'package:mealmate_dashboard/core/helper/responsive.dart';
import 'package:mealmate_dashboard/features/home/controllers/app_controller.dart';
import 'package:mealmate_dashboard/features/home/views/dashboard/components/header.dart';
import 'package:mealmate_dashboard/features/home/views/dashboard/dashboard_screen.dart';
import 'package:mealmate_dashboard/features/home/views/main/sidemenu/sections_enum.dart';
import 'package:mealmate_dashboard/features/home/views/main/sidemenu/side_menu.dart';
import 'package:mealmate_dashboard/features/store/presentation/pages/categories_page.dart';
import 'package:mealmate_dashboard/features/store/presentation/pages/ingredients_categories_page.dart';
import 'package:mealmate_dashboard/features/store/presentation/pages/notifcation_page.dart';
import 'package:mealmate_dashboard/features/store/presentation/pages/nutritional_page.dart';
import 'package:mealmate_dashboard/features/store/presentation/pages/ingredients_page.dart';
import 'package:mealmate_dashboard/features/store/presentation/pages/recipes_page.dart';
import 'package:mealmate_dashboard/features/store/presentation/pages/types_page.dart';
import 'package:mealmate_dashboard/features/store/presentation/pages/unit_types_page.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late AppController menuAppController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const SideMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // We want this side menu only for large screen
            if (Responsive.isDesktop(context))
              const Expanded(
                flex: 1,
                child: SideMenu(),
              ),
            Expanded(
                flex: 5,
                child: Flex(
                  direction: Axis.vertical,
                  children: [
                    Header(
                      scaffoldKey: _scaffoldKey,
                    ),
              const SizedBox(height: defaultPadding),
                    Flexible(
                      child: getSection()
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }

  Widget getSection () => switch (menuAppController.selectedSection) {
  Sections.dashboard => DashboardScreen(),
  Sections.recipes => RecipesPage(),
  Sections.ingredients => IngredientsPage(),
  Sections.nutritional =>  NutritionalPage(),
  Sections.units =>  UnitTypesPage(),
  Sections.categoriesIngredients =>  IngredientsCategoriesPage(),
  Sections.categories =>  CategoriesPage(),
  Sections.types =>  TypesPage(),
  Sections.notifications =>  NotificationsPage(),
  _ =>  Center(),
  };

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    menuAppController = Provider.of<AppController>(context, listen: true);
  }
}


