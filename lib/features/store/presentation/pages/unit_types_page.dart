import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mealmate_dashboard/core/extensions/widget_extensions.dart';
import 'package:mealmate_dashboard/core/helper/app_config.dart';
import 'package:mealmate_dashboard/core/helper/cubit_status.dart';
import 'package:mealmate_dashboard/core/ui/widgets/mm_data_table/mm_add_dialog.dart';
import 'package:mealmate_dashboard/core/ui/widgets/mm_data_table/mm_data_table.dart';
import 'package:mealmate_dashboard/core/ui/widgets/mm_data_table/mm_data_table_column_type.dart';
import 'package:mealmate_dashboard/core/ui/widgets/mm_data_table/mm_data_teble_enums.dart';
import 'package:mealmate_dashboard/core/ui/widgets/mm_data_table/mm_delete_dialog.dart';
import 'package:mealmate_dashboard/features/store/data/models/ingredient_model.dart';
import 'package:mealmate_dashboard/features/store/data/models/unit_types_model.dart';
import 'package:mealmate_dashboard/features/store/domain/usecases/index_ingredients.dart';
import 'package:mealmate_dashboard/features/store/domain/usecases/index_nutritional.dart';
import 'package:mealmate_dashboard/features/store/domain/usecases/index_unit_types.dart';
import 'package:mealmate_dashboard/features/store/presentation/cubit/store_cubit.dart';
import 'package:mealmate_dashboard/features/store/presentation/widgets/nutritional/nutritional_add_fields_widget.dart';
import 'package:mealmate_dashboard/features/store/presentation/widgets/nutritional/nutritional_delete_fields_widget.dart';

class UnitTypesPage extends StatefulWidget {
  const UnitTypesPage({super.key});

  @override
  State<UnitTypesPage> createState() => _UnitTypesPageState();
}

class _UnitTypesPageState extends State<UnitTypesPage> {
  late final StoreCubit _storeCubit;

  @override
  void initState() {
    super.initState();
    _storeCubit = StoreCubit()..getUnitTypes(IndexUnitTypesParams());
  }



  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _storeCubit,
      child: Scaffold(
        body: Column(
          children: [
            BlocBuilder<StoreCubit, StoreState>(
              bloc: _storeCubit,
              builder: (BuildContext context, StoreState state) {
                return switch (state.status) {
                CubitStatus.loading => const CircularProgressIndicator.adaptive().center(),
                CubitStatus.success =>
                unitTypesDataTable(state.unitTypes),
                _ => Text('error'.tr()).center(),
              };
              },
            ).expand(),
          ],
        ).padding(AppConfig.pagePadding),
      ),
    );
  }

  Widget unitTypesDataTable(List<UnitTypesModel> unitTypes){
    List<Map<String, dynamic>> data = [];
    List<MMDataTableColumn> dataTableColumns = [];

    for(var item in unitTypes)
      {
        data.add({
          "id": item.id,
          "name": item.name,
          "code": item.code
        });
      }
    dataTableColumns.addAll(
      [
        MMDataTableColumn(
            dataKey: "id",
            dataType: MMDataTableColumnType.num,
            columnTitle: "ID",
            isSortEnabled: true
        ),
        MMDataTableColumn(
            dataKey: "name",
            dataType: MMDataTableColumnType.string,
            columnTitle: "Name",
            isSortEnabled: true
        ),
        MMDataTableColumn(
            dataKey: "code",
            dataType: MMDataTableColumnType.string,
            columnTitle: "Code",
            isSortEnabled: true
        ),


      ]
    );

    return MMDataTable(
      dataTableTitle: "Unit Types Table",
        data: data,
        dataTableColumns: dataTableColumns,
      onRefresh: (){
        _storeCubit.getUnitTypes(IndexUnitTypesParams());
      },

    );
  }
}

