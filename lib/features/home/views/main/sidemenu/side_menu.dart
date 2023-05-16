import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mealmate_dashboard/features/home/controllers/MenuAppController.dart';
import 'package:mealmate_dashboard/features/home/views/main/sidemenu/sections_enum.dart';
import 'package:provider/provider.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Image.asset("assets/images/logo.png"),
          ),
          DrawerListTile(
            title: "Dashboard",
            sectionName: Sections.dashboard,
            svgSrc: "assets/icons/menu_dashboard.svg",
            press: () {

            },
          ),
          DrawerListTile(
            title: "Categories",
            sectionName: Sections.categories,
            svgSrc: "assets/icons/menu_tran.svg",
            press: () {},
          ),
          DrawerListTile(
            title: "Types",
            sectionName: Sections.types,
            svgSrc: "assets/icons/menu_task.svg",
            press: () {},
          ),
          DrawerListTile(
            title: "Users",
            sectionName: Sections.users,
            svgSrc: "assets/icons/menu_profile.svg",
            press: () {},
          ),
          DrawerListTile(
            title: "Settings",
            sectionName: Sections.settings,
            svgSrc: "assets/icons/menu_setting.svg",
            press: () {},
          ),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    required this.title,
    required this.svgSrc,
    required this.press,
    required this.sectionName,
  }) : super(key: key);

  final String title, svgSrc;
  final Sections sectionName;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    MenuAppController menuAppController = Provider.of<MenuAppController>(context);

    return ListTile(
      onTap: (){
        press();
        menuAppController.changeSelectedSection(newSection: sectionName);
      },
      horizontalTitleGap: 0.0,
      tileColor:menuAppController.selectedSection == sectionName ? Colors.white.withOpacity(0.2): Colors.transparent,
      leading: SvgPicture.asset(
        svgSrc,
        colorFilter: ColorFilter.mode(Colors.white54, BlendMode.srcIn),
        height: 16,
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.white54),
      ),
    );
  }
}
