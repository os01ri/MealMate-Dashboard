import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mealmate_dashboard/core/constants/constants.dart';
import 'package:mealmate_dashboard/core/helper/responsive.dart';
import 'package:mealmate_dashboard/features/home/controllers/MenuAppController.dart';
import 'package:mealmate_dashboard/features/home/views/dashboard/components/header.dart';
import 'package:mealmate_dashboard/features/home/views/dashboard/dashboard_screen.dart';
import 'package:mealmate_dashboard/features/home/views/main/sidemenu/sections_enum.dart';
import 'package:mealmate_dashboard/features/home/views/main/sidemenu/side_menu.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late MenuAppController menuAppController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: menuAppController.scaffoldKey,
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
                    const Header(),
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
  Sections.categories => DataTableWidget(),
  Sections.types =>  DataTableWidget(),
  Sections.users =>  DataTableWidget(),
  Sections.settings =>  DataTableWidget(),
  _ =>  DataTableWidget(),
  };

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    menuAppController = Provider.of<MenuAppController>(context, listen: true);
  }
}



class DataTableWidget extends StatefulWidget {
  @override
  _DataTableWidgetState createState() => _DataTableWidgetState();
}

class _DataTableWidgetState extends State<DataTableWidget> {
  int? _sortColumnIndex = null;
  bool _sortAscending = false;

  List<Map<String, dynamic>> _data = List.generate(
    20,
        (index) => {
      "id": Random().nextInt(200) + 1,
      "name": "Name ${Random().nextInt(200) + 1}",
      "date": DateTime.now().subtract(Duration(days: Random().nextInt(200))),
      "note": "Note ${Random().nextInt(200) + 1}"
    },
  );


  @override
  Widget build(BuildContext context) {


    return SizedBox.expand(
      child: SingleChildScrollView(
        child: DataTable(
          sortColumnIndex: _sortColumnIndex,
          sortAscending: _sortAscending,

          columns: [
            DataColumn(
              label: Text("ID",textAlign: TextAlign.start,),
              onSort: (index, ascending) {
                setState(() {
                  _sortColumnIndex = index;
                  _sortAscending = ascending;
                  _data.sort((a, b) => a['id'].compareTo(b['id']) * (_sortAscending ? 1 : -1));
                });
              },
            ),
            DataColumn(
              label: Text("Name",textAlign: TextAlign.start),
              onSort: (index, ascending) {
                setState(() {
                  _sortColumnIndex = index;
                  _sortAscending = ascending;
                  _data.sort((a, b) => a['name'].compareTo(b['name']) * (_sortAscending ? 1 : -1));
                });
              },
            ),
            DataColumn(
              label: Text("Date"),
              onSort: (index, ascending) {
                setState(() {
                  _sortColumnIndex = index;
                  _sortAscending = ascending;
                  _data.sort((a, b) => a['date'].compareTo(b['date']) * (_sortAscending ? 1 : -1));
                });
              },
            ),
            DataColumn(
              label: Text("Note"),
              onSort: (index, ascending) {
                setState(() {
                  _sortColumnIndex = index;
                  _sortAscending = ascending;
                  _data.sort((a, b) => a['note'].compareTo(b['note']) * (_sortAscending ? 1 : -1));
                });
              },
            ),
          ],
          rows: _data
              .map(
                (data) => DataRow(
              cells: [
                DataCell(Text(data['id'].toString())),
                DataCell(Text(data['name'])),
                DataCell(Text(data['date'].toString())),
                DataCell(Text(data['note'])),
              ],
            ),
          )
              .toList(),
        ),
      ),
    );
  }
}