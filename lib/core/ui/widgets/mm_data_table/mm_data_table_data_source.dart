
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mealmate_dashboard/core/extensions/widget_extensions.dart';

class DataSource extends DataTableSource {
  final List<Map<String, dynamic>> data;
  final Function? onEdit;
  final Function? onDelete;
  final Function? onAccept;

  DataSource({required this.data, this.onEdit, this.onDelete,this.onAccept});


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
    else if (key.contains("acceptRecipe"))
    {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if(!item.status)
          Row(
            children: [
              Text("Not Active".tr()),
              SizedBox(width: 8,),

              Text("|"),
              SizedBox(width: 8,),

              IconButton(icon:Icon(Icons.check_circle,color: Colors.green,),onPressed: (){
                onAccept!(item);
              }),
            ],
          ),
          if(item.status)
            Row(
              children: [
                Text("Active".tr()),
                SizedBox(width: 8,),

                Text("|"),
                SizedBox(width: 8,),
                IconButton(icon:Icon(Icons.disabled_by_default,color: Colors.red,),onPressed: (){
                onAccept!(item);
          }),
              ],
            )
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
