import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mealmate_dashboard/core/constants/constants.dart';
import 'package:mealmate_dashboard/features/auth/presentation/pages/auth_page.dart';
import 'package:mealmate_dashboard/features/auth/presentation/pages/login_page.dart';
import 'package:mealmate_dashboard/features/home/controllers/app_controller.dart';
import 'package:mealmate_dashboard/features/home/views/main/main_screen.dart';
import 'package:provider/provider.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
        supportedLocales: [Locale('en'), Locale('ar')],
        path: 'assets/translations',
        fallbackLocale: Locale('en',),
        startLocale:  Locale('en',),
        child: MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (context) => AppController(),
              ),
            ],
            child: MyApp()
        )
    ),
  );}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meal Mate Dashboard',
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: bgColor,
        canvasColor: secondaryColor,
      ),
      home: AuthPage(),
    );
  }
}

