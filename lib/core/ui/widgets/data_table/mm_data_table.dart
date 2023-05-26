import 'dart:math';

import 'package:flutter/material.dart';




class MMDataTable extends StatefulWidget {
  final List<Map<String, dynamic>> data;
  final List<MMDataTableColumn> dataTableColumns;
  final String dataTableTitle;


  MMDataTable({Key? key,required this.data,required this.dataTableColumns,required this.dataTableTitle}) : super(key: key);

  @override
  _MMDataTableState createState() => _MMDataTableState();
}

class _MMDataTableState extends State<MMDataTable> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int? _sortColumnIndex;
  bool _sortAscending = true;
  late List<Map<String, dynamic>> _data;

  @override
  void initState() {
    super.initState();
    _data = widget.data;
  }


  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: SingleChildScrollView(
        child: PaginatedDataTable(
          header: SelectableText(widget.dataTableTitle),
          rowsPerPage: _rowsPerPage,
          onRowsPerPageChanged: (rowCount) {
            setState(() {
              _rowsPerPage = rowCount!;
            });
          },
          sortColumnIndex: _sortColumnIndex,
          sortAscending: _sortAscending,
          columns: [
            for(var item in widget.dataTableColumns)
            _dataColumnBuilder(item)
          ],
          source: _DataSource(_data),
        ),
      ),
    );
  }

  DataColumn _dataColumnBuilder(MMDataTableColumn mmDataTableColumn){
    DataColumnSortCallback? onSort;
    if(mmDataTableColumn.dataType == MMDataTableColumnType.num)
      {
        onSort = (columnIndex, ascending) => _sort<num>((d) => d[mmDataTableColumn.dataKey], columnIndex, ascending);
      }
    else if(mmDataTableColumn.dataType == MMDataTableColumnType.bool)
    {
      onSort = (columnIndex, ascending) => _sort<bool>((d) => d[mmDataTableColumn.dataKey], columnIndex, ascending);
    }
    else if(mmDataTableColumn.dataType == MMDataTableColumnType.datetime)
    {
      onSort = (columnIndex, ascending) => _sort<DateTime>((d) => d[mmDataTableColumn.dataKey], columnIndex, ascending);
    }
    else if(mmDataTableColumn.dataType == MMDataTableColumnType.string)
    {
      onSort = (columnIndex, ascending) => _sort<String>((d) => d[mmDataTableColumn.dataKey], columnIndex, ascending);
    }

    return DataColumn(
      label: SelectableText(mmDataTableColumn.columnTitle,
        textAlign: TextAlign.start,
      ),
      onSort: mmDataTableColumn.isSortEnabled? onSort : null,
    );
  }

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
        for(var item in _data[index].keys)
          DataCell(SelectableText(record[item].toString(),textDirection: TextDirection.rtl,)),
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

class MMDataTableColumn {
  final String dataKey;
  final MMDataTableColumnType dataType;
  final String columnTitle;
  final bool isSortEnabled;

  MMDataTableColumn({required this.dataKey, required this.dataType, required this.columnTitle,required this.isSortEnabled});

}

enum MMDataTableColumnType {
  num, datetime, string, bool
}

