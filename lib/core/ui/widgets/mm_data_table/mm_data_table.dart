import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mealmate_dashboard/core/ui/widgets/main_button.dart';
import 'package:mealmate_dashboard/core/ui/widgets/mm_data_table/mm_data_table_column_type.dart';
import 'package:mealmate_dashboard/core/ui/widgets/mm_data_table/mm_data_table_data_source.dart';
import 'package:mealmate_dashboard/core/ui/widgets/mm_data_table/mm_data_teble_enums.dart';

class MMDataTable extends StatefulWidget {
  final List<Map<String, dynamic>> data;
  final List<MMDataTableColumn> dataTableColumns;
  final String dataTableTitle;
  final Function? onAdd;
  final Function? onRefresh;
  final Function? onEdit;
  final Function? onDelete;

  MMDataTable({Key? key,required this.data,this.onDelete,this.onEdit,this.onAdd,this.onRefresh,required this.dataTableColumns,required this.dataTableTitle}) : super(key: key);

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
          header: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.dataTableTitle),
              Row(
                children: [

                  MainButton(
                      text: "Refresh".tr(),
                      icon: const Icon(Icons.refresh,
                        color: Colors.white,
                      ),
                      color: Colors.cyan, onPressed: (){
                      widget.onRefresh!();
                      }),

                  if(widget.onAdd!=null)
                  const SizedBox(width: 16,),

                  if(widget.onAdd!=null)
                  MainButton(text: "Add".tr(),
                      icon: const Icon(Icons.add_circle,
                       color: Colors.white,
                      ),
                      color: Colors.cyan, onPressed: (){
                        widget.onAdd!();

                  }),

                ],
              )
            ],
          ),
          rowsPerPage: _rowsPerPage,
          onRowsPerPageChanged: (rowCount) {
            setState(() {
              _rowsPerPage = rowCount!;
            });
          },
          sortColumnIndex: _sortColumnIndex,
          sortAscending: _sortAscending,dataRowHeight: 100,
          columns: [
            for(var item in widget.dataTableColumns)
            _dataColumnBuilder(item)
          ],
          source: DataSource(
              data: _data,
            onDelete: (id){
            widget.onDelete!(id);
            },
            onEdit: (id){
              widget.onEdit!(id);
            }
          ),
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
      label: Text(mmDataTableColumn.columnTitle,
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
