import 'package:flutter/material.dart';
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
import 'package:mealmate_dashboard/features/store/data/models/recipe_model.dart';
import 'package:mealmate_dashboard/features/store/domain/usecases/index_ingredients.dart';
import 'package:mealmate_dashboard/features/store/domain/usecases/index_recipe.dart';
import 'package:mealmate_dashboard/features/store/presentation/cubit/store_cubit.dart';
import 'package:mealmate_dashboard/features/store/presentation/widgets/ingredients/ingredient_delete_fields_widget.dart';
import 'package:mealmate_dashboard/features/store/presentation/widgets/ingredients/ingredients_add_fields_widget.dart';
import 'package:mealmate_dashboard/features/store/presentation/widgets/nutritional/nutritional_delete_fields_widget.dart';
import 'package:mealmate_dashboard/features/store/presentation/widgets/recipes/recipes_delete_fields_widget.dart';

class RecipesPage extends StatefulWidget {
  const RecipesPage({super.key});

  @override
  State<RecipesPage> createState() => _RecipesPageState();
}

class _RecipesPageState extends State<RecipesPage> {
  late final StoreCubit _storeCubit;

  @override
  void initState() {
    super.initState();
    _storeCubit = StoreCubit()..getRecipes(IndexRecipesParams());
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
                recipesDataTable(state.recipes),
                _ => Text('error'.tr()).center(),
              };
              },
            ).expand(),
          ],
        ).padding(AppConfig.pagePadding),
      ),
    );
  }

  Widget recipesDataTable(List<RecipeModel> recipes){
    List<Map<String, dynamic>> data = [];
    List<MMDataTableColumn> dataTableColumns = [];

    for(var item in recipes)
      {
        data.add({
          "id": item.id,
          "name": item.name,
          "category": item.category!.name,
          "type": item.type!.name,
          "steps": item.steps!.map((e) => "${e.name}: ${e.description!}").join("\n").toString(),
          "image" : item.url,
          "editAndDelete": item.id
        });
      }
    dataTableColumns.addAll(
      [
        MMDataTableColumn(
            dataKey: "id",
            dataType: MMDataTableColumnType.num,
            columnTitle: "ID".tr(),
            isSortEnabled: true
        ),
        MMDataTableColumn(
            dataKey: "name",
            dataType: MMDataTableColumnType.string,
            columnTitle: "Name".tr(),
            isSortEnabled: true
        ),
        MMDataTableColumn(
            dataKey: "category",
            dataType: MMDataTableColumnType.string,
            columnTitle: "Category".tr(),
            isSortEnabled: true
        ),
        MMDataTableColumn(
            dataKey: "type",
            dataType: MMDataTableColumnType.string,
            columnTitle: "Type".tr(),
            isSortEnabled: true
        ),
        MMDataTableColumn(
            dataKey: "steps",
            dataType: MMDataTableColumnType.string,
            columnTitle: "Steps".tr(),
            isSortEnabled: true
        ),
        MMDataTableColumn(
            dataKey: "image",
            dataType: MMDataTableColumnType.image,
            columnTitle: "Image".tr(),
            isSortEnabled: false
        ),
        MMDataTableColumn(
            dataKey: "editAndDelete",
            dataType: MMDataTableColumnType.editAndDelete,
            columnTitle: "Edit/Delete".tr(),
            isSortEnabled: false
        ),

      ]
    );

    return MMDataTable(
      dataTableTitle: "Recipes Table".tr(),
        data: data,
        dataTableColumns: dataTableColumns,
      onRefresh: (){
        _storeCubit.getRecipes(IndexRecipesParams());
      },
      onAdd: (){
        showMMAddDialog(context: context,
            title: "Add Recipes".tr(),
            addFieldsWidget: IngredientsAddFieldWidget(
              onAddFinish: (){
                _storeCubit.getRecipes(IndexRecipesParams());
              },
            )
        );
      },
      onDelete: (id){
        showMMDeleteDialog(context: context,
          title: "Delete Recipes".tr(),
          deleteFieldsWidget: RecipesDeleteFieldWidget(
            id: id,
            onDeleteFinish: (){
              _storeCubit.getRecipes(IndexRecipesParams());
            },
          ),
        );
      },
    );
  }
}

