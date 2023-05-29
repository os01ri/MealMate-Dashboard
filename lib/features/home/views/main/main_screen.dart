import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mealmate_dashboard/core/constants/constants.dart';
import 'package:mealmate_dashboard/core/helper/responsive.dart';
import 'package:mealmate_dashboard/features/home/controllers/MenuAppController.dart';
import 'package:mealmate_dashboard/features/home/views/dashboard/components/header.dart';
import 'package:mealmate_dashboard/features/home/views/dashboard/dashboard_screen.dart';
import 'package:mealmate_dashboard/features/home/views/main/sidemenu/sections_enum.dart';
import 'package:mealmate_dashboard/features/home/views/main/sidemenu/side_menu.dart';
import 'package:mealmate_dashboard/features/store/presentation/pages/nutritional_page.dart';
import 'package:mealmate_dashboard/features/store/presentation/pages/store_page.dart';
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
  Sections.ingredients => StorePage(),
  Sections.nutritional =>  NutritionalPage(),
  Sections.users =>  MyDataTable(),
  Sections.settings =>  MyDataTable(),
  _ =>  MyDataTable(),
  };

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    menuAppController = Provider.of<MenuAppController>(context, listen: true);
  }
}




class MyDataTable extends StatefulWidget {
  MyDataTable({Key? key}) : super(key: key);

  @override
  _MyDataTableState createState() => _MyDataTableState();
}

class _MyDataTableState extends State<MyDataTable> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int _sortColumnIndex = 0;
  bool _sortAscending = true;
  List<Map<String, dynamic>> _data = List.generate(
    20,
        (index) => {
      "id": Random().nextInt(200) + 1,
      "name": "Name ${Random().nextInt(200) + 1}",
      "date": DateTime.now().subtract(Duration(days: Random().nextInt(200))),
      "note": "Note ${Random().nextInt(200) + 1}"
    },
  );


  void _sort<T>(Comparable<T> Function(Map<String, dynamic> d) getField, int columnIndex, bool ascending) {
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;
      _data.sort((a, b) {
        final aValue = getField(a);
        final bValue = getField(b);
        return ascending ? Comparable.compare(aValue, bValue) : Comparable.compare(bValue, aValue);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: SingleChildScrollView(
        child: PaginatedDataTable(
          header: Text('My DataTable'),
          rowsPerPage: _rowsPerPage,
          onRowsPerPageChanged: (rowCount) {
            setState(() {
              _rowsPerPage = rowCount!;
            });
          },
          sortColumnIndex: _sortColumnIndex,
          sortAscending: _sortAscending,
          columns: [
            DataColumn(
              label: Text("ID",textAlign: TextAlign.start,),
              onSort: (columnIndex, ascending) => _sort<num>((d) => d['id'], columnIndex, ascending),
            ),
            DataColumn(
              label: Text("Name",textAlign: TextAlign.start),
              onSort: (columnIndex, ascending) => _sort<String>((d) => d['name'], columnIndex, ascending),

            ),
            DataColumn(
              label: Text("Date"),
              onSort: (columnIndex, ascending) => _sort<DateTime>((d) => d['date'], columnIndex, ascending),

            ),
            DataColumn(
              label: Text("Note"),
              onSort: (columnIndex, ascending) => _sort<String>((d) => d['note'], columnIndex, ascending),

            ),
          ],
          source: _DataSource(_data),
        ),
      ),
    );
  }
}

class _DataSource extends DataTableSource {
  final List<Map<String, dynamic>> _data;

  _DataSource(this._data);

  @override
  DataRow getRow(int index) {
    final record = _data[index];
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text(record['id'].toString())),
        DataCell(Text(record['name'])),
        DataCell(Text(record['date'].toString())),
        DataCell(Text(record['note'])),
      ],
    );
  }

  @override
  int get rowCount => _data.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}