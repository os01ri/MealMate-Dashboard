import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mealmate_dashboard/core/extensions/context_extensions.dart';
import 'package:mealmate_dashboard/core/extensions/routing_extensions.dart';
import 'package:mealmate_dashboard/core/extensions/widget_extensions.dart';
import 'package:mealmate_dashboard/core/helper/app_config.dart';
import 'package:mealmate_dashboard/core/helper/assets_paths.dart';
import 'package:mealmate_dashboard/core/helper/cubit_status.dart';
import 'package:mealmate_dashboard/core/ui/font/typography.dart';
import 'package:mealmate_dashboard/core/ui/theme/colors.dart';
import 'package:mealmate_dashboard/core/ui/widgets/data_table/mm_data_table.dart';
import 'package:mealmate_dashboard/core/ui/widgets/main_text_field.dart';
import 'package:mealmate_dashboard/features/store/data/models/ingredient_model.dart';
import 'package:mealmate_dashboard/features/store/domain/usecases/index_ingredients.dart';
import 'package:mealmate_dashboard/features/store/presentation/cubit/store_cubit.dart';
import 'package:mealmate_dashboard/router/app_routes.dart';

class StorePage extends StatefulWidget {
  const StorePage({super.key});

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  late final StoreCubit _storeCubit;

  @override
  void initState() {
    super.initState();

    _storeCubit = StoreCubit()..getIngredients(IndexIngredientsParams());
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
                ingredientsDataTable(state.ingredients),
                _ => const Text('error').center(),
              };
              },
            ).expand(),
          ],
        ).padding(AppConfig.pagePadding),
      ),
    );
  }

  Widget ingredientsDataTable(List<IngredientModel> ingredients){
    List<Map<String, dynamic>> data = [];
    List<MMDataTableColumn> dataTableColumns = [];

    for(var item in ingredients)
      {
        data.add({
          "id": item.id,
          "name": item.name,
          "nutritional":item.nutritionals!.map((e) => "${e.name}: ${e.ingredientNutritionals!.value}%").join("\n").toString()
        });
      }
    dataTableColumns.addAll(
      [
        MMDataTableColumn(
            dataKey: "id",
            dataType: MMDataTableColumnType.string,
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
            dataKey: "nutritional",
            dataType: MMDataTableColumnType.string,
            columnTitle: "Nutritional value",
            isSortEnabled: true
        ),
      ]
    );

    return MMDataTable(
      dataTableTitle: "Ingredients Table",
        data: data,
        dataTableColumns: dataTableColumns,
    );
  }
}

