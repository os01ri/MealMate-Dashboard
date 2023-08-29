
import 'package:mealmate_dashboard/core/ui/widgets/mm_data_table/mm_data_teble_enums.dart';

class MMDataTableColumn {
  final String dataKey;
  final MMDataTableColumnType dataType;
  final String columnTitle;
  final bool isSortEnabled;

  MMDataTableColumn({required this.dataKey, required this.dataType, required this.columnTitle,required this.isSortEnabled});

}
