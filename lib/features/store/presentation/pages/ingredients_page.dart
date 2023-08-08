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
import 'package:mealmate_dashboard/core/ui/widgets/mm_data_table/mm_update_dialog.dart';
import 'package:mealmate_dashboard/features/store/data/models/ingredient_model.dart';
import 'package:mealmate_dashboard/features/store/domain/usecases/index_ingredients.dart';
import 'package:mealmate_dashboard/features/store/presentation/cubit/store_cubit.dart';
import 'package:mealmate_dashboard/features/store/presentation/widgets/ingredients/ingredient_delete_fields_widget.dart';
import 'package:mealmate_dashboard/features/store/presentation/widgets/ingredients/ingredients_add_fields_widget.dart';
import 'package:mealmate_dashboard/features/store/presentation/widgets/nutritional/nutritional_delete_fields_widget.dart';

class IngredientsPage extends StatefulWidget {
  const IngredientsPage({super.key});

  @override
  State<IngredientsPage> createState() => _IngredientsPageState();
}

class _IngredientsPageState extends State<IngredientsPage> {
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
                _ => Text('error'.tr()).center(),
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
          "nutritional":item.nutritionals!.map((e) => "${e.name}: ${e.ingredientNutritionals!.value}%").join("\n").toString(),
          "price" : item.price,
          "priceBy": item.priceById,
          "image" : item.imageUrl,
          "editAndDelete": item

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
            columnTitle: "Name".tr(),
            isSortEnabled: true
        ),
        MMDataTableColumn(
            dataKey: "nutritional",
            dataType: MMDataTableColumnType.string,
            columnTitle: "Nutritional value".tr(),
            isSortEnabled: true
        ),
        MMDataTableColumn(
            dataKey: "price",
            dataType: MMDataTableColumnType.num,
            columnTitle: "Price".tr(),
            isSortEnabled: true
        ),
        MMDataTableColumn(
            dataKey: "priceBy",
            dataType: MMDataTableColumnType.string,
            columnTitle: "Price By".tr(),
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
      dataTableTitle: "Ingredients Table".tr(),
        data: data,
        dataTableColumns: dataTableColumns,
      onRefresh: (){
        _storeCubit.getIngredients(IndexIngredientsParams());
      },
      onAdd: (){
        showMMAddDialog(context: context,
            title: "Add Ingredient".tr(),
            addFieldsWidget: IngredientsAddFieldWidget(
              onAddFinish: (){
                _storeCubit.getIngredients(IndexIngredientsParams());
              },
            )
        );
      },
      onEdit: (item){
        showMMUpdateDialog(context: context,
            title: "Update Ingredient".tr(),
            updateFieldsWidget: IngredientsAddFieldWidget(
              onAddFinish: (){
                _storeCubit.getIngredients(IndexIngredientsParams());
              },
              isAdd: false,
              ingredientModel: item,
            )
        );
      },
      onDelete: (id){
        showMMDeleteDialog(context: context,
          title: "Delete Ingredient".tr(),
          deleteFieldsWidget: IngredientDeleteFieldWidget(
            id: id,
            onDeleteFinish: (){
              _storeCubit.getIngredients(IndexIngredientsParams());
            },
          ),
        );
      },
    );
  }
}

