
import 'package:flutter/material.dart';

class DataSource extends DataTableSource {
  final List<Map<String, dynamic>> data;
  final Function? onEdit;
  final Function? onDelete;

  DataSource({required this.data, this.onEdit, this.onDelete});


  @override
  DataRow getRow(int index) {
    final record = data[index];
    return DataRow.byIndex(
      index: index,
      cells: [
        for(var item in data[index].keys)
          DataCell(
              getCellWidget(item.toString(),record[item].toString(),item: record['editAndDelete'])
              ),
      ],
    );
  }

  Widget getCellWidget(String key,String value,{dynamic item}){
    if(key.contains("image"))
      {
        return Image.network(value,
          height: 70,
        );
      }
    else if (key.contains("editAndDelete"))
      {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(icon:Icon(Icons.edit,color: Colors.green,),onPressed: (){
              onEdit!(item);
            }),

            SizedBox(width: 12,),
            IconButton(icon:Icon(Icons.delete,color: Colors.red,),onPressed: (){
              onDelete!(item.id);
            }),

          ],
        );
      }
    else
      {
        return Container(
            constraints: BoxConstraints(
              minWidth: 0,
              maxWidth: 250
            ),
            child: SelectableText(value,));
      }

  }

  @override
  int get rowCount => data.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}
