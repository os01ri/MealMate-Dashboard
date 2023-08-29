
import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mealmate_dashboard/core/constants/constants.dart';
import 'package:mealmate_dashboard/core/helper/helper_functions.dart';
import 'package:mealmate_dashboard/core/helper/responsive.dart';
import 'package:mealmate_dashboard/features/home/controllers/app_controller.dart';
import 'package:provider/provider.dart';


class Header extends StatelessWidget {
  final dynamic scaffoldKey;
  const Header({
    Key? key,
    required this.scaffoldKey
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppController menuAppController = Provider.of<AppController>(context);

    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: Row(
        children: [
          if (!Responsive.isMobile(context))
            Text(
              "${menuAppController.selectedSection.name.tr().toUpperCase()}",
              style: Theme.of(context).textTheme.titleLarge,
            ),

          if (!Responsive.isDesktop(context))
            IconButton(
              icon: Icon(Icons.menu),
              onPressed: (){
                context.read<AppController>().controlMenu(scaffoldKey);
              },
            ),

           
          if (!Responsive.isMobile(context))
            Expanded(child: LanguageField()),

          if (Responsive.isMobile(context))
            Expanded(child: SizedBox()),


          ProfileCard()
        ],
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<AppController>(context,listen: false).userModel;
    return Container(
      margin: EdgeInsets.only(left: defaultPadding),
      padding: EdgeInsets.symmetric(
        horizontal: defaultPadding,
        vertical: defaultPadding / 2,
      ),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children: [
          Image.asset(
            "assets/images/profile_pic.png",
            height: 38,
          ),
          if (!Responsive.isMobile(context))
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
              child: Text(user?.username??""),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GestureDetector(
                onTap: (){
                  HelperFunctions.logout();
                },
                child: Icon(Icons.logout)),
          ),
        ],
      ),
    );
  }
}

class LanguageField extends StatefulWidget {
  const LanguageField({
    Key? key,
  }) : super(key: key);

  @override
  State<LanguageField> createState() => _LanguageFieldState();
}

class _LanguageFieldState extends State<LanguageField> {
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          SizedBox(
            width: 300,
            child: AnimatedToggleSwitch<String>.size(
              current: context.locale.languageCode=="ar"?"Arabic":"English",
              values: ["English","Arabic",],
              borderColor: Colors.transparent,
              colorBuilder: (i) {
                return  bgColor;
              },

              innerColor: Color(0xFFF0F0F0),
              height: 42,
              borderWidth: 5,
              indicatorSize: Size.fromWidth(double.infinity),
              iconBuilder: (value, size) {

                return Center(child: Text(value,
                  style: Theme.of(context).textTheme.headline5!.apply(
                      fontSizeDelta: -2,
                      color: ((value == "Arabic" && context.locale.languageCode=='ar') || (value != "Arabic" && context.locale.languageCode!='ar'))? Colors.white :bgColor
                  ),
                ));
              },
              onChanged: (i){
                if(i!="Arabic")
                {
                //  AppSettings.language = 'en';
                  context.locale = Locale('en');
                }
                else
                {
                //  AppSettings.language = 'ar';
                  context.locale = Locale('ar');
                }
                setState(() {});
                Navigator.of(context).popUntil((route) => false);

                Provider.of<AppController>(context,listen: false).reset();
                Future.delayed(Duration(milliseconds: 400)).then((value) {
                  HelperFunctions.restart();
                });

              },
            ),
          ),


        ],
      ),
    );

  }
}
