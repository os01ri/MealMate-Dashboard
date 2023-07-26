import 'package:flutter/material.dart';
import 'package:mealmate_dashboard/core/helper/helper_functions.dart';
import 'package:mealmate_dashboard/core/ui/widgets/loading_widget.dart';
import 'package:mealmate_dashboard/features/auth/presentation/pages/login_page.dart';
import 'package:mealmate_dashboard/features/home/controllers/app_controller.dart';
import 'package:mealmate_dashboard/features/home/views/dashboard/dashboard_screen.dart';
import 'package:mealmate_dashboard/features/home/views/main/main_screen.dart';
import 'package:provider/provider.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  
  
  
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: LoadingWidget())
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      checkIfUser();
    });
  }
  
  checkIfUser(){
    HelperFunctions.getToken().then((value) async {
      if(value!=null)
        {
          var user = await HelperFunctions.getUser();
          Provider.of<AppController>(context,listen: false).changeUser(user: user);
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
            return MainScreen();
          },));
        }
      else
        {
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
            return const LoginPage();
          },));
        }
    });
  }
}
