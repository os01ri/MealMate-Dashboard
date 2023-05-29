import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mealmate_dashboard/core/extensions/widget_extensions.dart';
import 'package:mealmate_dashboard/core/helper/app_config.dart';
import 'package:mealmate_dashboard/core/helper/cubit_status.dart';
import 'package:mealmate_dashboard/core/ui/widgets/mm_data_table/mm_add_dialog.dart';
import 'package:mealmate_dashboard/core/ui/widgets/mm_data_table/mm_data_table.dart';
import 'package:mealmate_dashboard/core/ui/widgets/mm_data_table/mm_data_table_column_type.dart';
import 'package:mealmate_dashboard/core/ui/widgets/mm_data_table/mm_data_teble_enums.dart';
import 'package:mealmate_dashboard/features/store/data/models/ingredient_model.dart';
import 'package:mealmate_dashboard/features/store/domain/usecases/index_ingredients.dart';
import 'package:mealmate_dashboard/features/store/domain/usecases/index_nutritional.dart';
import 'package:mealmate_dashboard/features/store/presentation/cubit/store_cubit.dart';
import 'package:mealmate_dashboard/features/store/presentation/widgets/nutritional/nutritional_add_fields_widget.dart';

class NutritionalPage extends StatefulWidget {
  const NutritionalPage({super.key});

  @override
  State<NutritionalPage> createState() => _NutritionalPageState();
}

class _NutritionalPageState extends State<NutritionalPage> {
  late final StoreCubit _storeCubit;

  @override
  void initState() {
    super.initState();
    _storeCubit = StoreCubit()..getNutritional(IndexNutritionalParams());
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
                nutritionalDataTable(state.nutritional),
                _ => const Text('error').center(),
              };
              },
            ).expand(),
          ],
        ).padding(AppConfig.pagePadding),
      ),
    );
  }

  Widget nutritionalDataTable(List<Nutritional> nutritional){
    List<Map<String, dynamic>> data = [];
    List<MMDataTableColumn> dataTableColumns = [];

    for(var item in nutritional)
      {
        data.add({
          // "id": item.id,
          "name": item.name,
          "editAndDelete":true

        });
      }
    dataTableColumns.addAll(
      [
        // MMDataTableColumn(
        //     dataKey: "id",
        //     dataType: MMDataTableColumnType.string,
        //     columnTitle: "ID",
        //     isSortEnabled: true
        // ),
        MMDataTableColumn(
            dataKey: "name",
            dataType: MMDataTableColumnType.string,
            columnTitle: "Name",
            isSortEnabled: true
        ),

        MMDataTableColumn(
            dataKey: "editAndDelete",
            dataType: MMDataTableColumnType.editAndDelete,
            columnTitle: "Edit/Delete",
            isSortEnabled: false
        ),

      ]
    );

    return MMDataTable(
      dataTableTitle: "Nutritional Table",
        data: data,
        dataTableColumns: dataTableColumns,
      onRefresh: (){
        _storeCubit.getNutritional(IndexNutritionalParams());
      },
      onAdd: (){
        showMMAddDialog(context: context,
          title: "Add Nutritional",
          addFieldsWidget: NutritionalAddFieldWidget(
            onAdd: (){
              _storeCubit.getNutritional(IndexNutritionalParams());
            },
          )
        );
      },
    );
  }
}

