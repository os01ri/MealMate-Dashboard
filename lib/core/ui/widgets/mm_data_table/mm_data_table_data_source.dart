
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
          DataCell(
              getCellWidget(item.toString(),record[item].toString())
              ),
      ],
    );
  }

  Widget getCellWidget(String key,String value){
    if(key.contains("image"))
      {
        return Image.network(value,
          height: 36,
        );
      }
    else if (key.contains("editAndDelete"))
      {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(icon:Icon(Icons.edit,color: Colors.green,),onPressed: (){

            }),

            SizedBox(width: 12,),
            IconButton(icon:Icon(Icons.delete,color: Colors.red,),onPressed: (){
              
            }),

          ],
        );
      }
    else
      {
        return SelectableText(value,textDirection: TextDirection.rtl,);
      }

  }

  @override
  int get rowCount => _data.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}
