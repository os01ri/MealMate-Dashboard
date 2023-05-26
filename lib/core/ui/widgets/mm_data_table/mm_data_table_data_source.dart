
import 'package:flutter/material.dart';

class DataSource extends DataTableSource {
  final List<Map<String, dynamic>> _data;

  DataSource(this._data);

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
