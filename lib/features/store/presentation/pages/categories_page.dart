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
import 'package:mealmate_dashboard/features/store/data/models/categories_ingredient.dart';
import 'package:mealmate_dashboard/features/store/data/models/categories_model.dart';
import 'package:mealmate_dashboard/features/store/data/models/ingredient_model.dart';
import 'package:mealmate_dashboard/features/store/data/models/unit_types_model.dart';
import 'package:mealmate_dashboard/features/store/domain/usecases/index_categories.dart';
import 'package:mealmate_dashboard/features/store/domain/usecases/index_categories_ingredient.dart';
import 'package:mealmate_dashboard/features/store/domain/usecases/index_ingredients.dart';
import 'package:mealmate_dashboard/features/store/domain/usecases/index_nutritional.dart';
import 'package:mealmate_dashboard/features/store/domain/usecases/index_unit_types.dart';
import 'package:mealmate_dashboard/features/store/presentation/cubit/store_cubit.dart';
import 'package:mealmate_dashboard/features/store/presentation/widgets/categories/categories_add_fields_widget.dart';
import 'package:mealmate_dashboard/features/store/presentation/widgets/categories/categories_delete_fields_widget.dart';
import 'package:mealmate_dashboard/features/store/presentation/widgets/categories_ingredients/categories_ingredients_add_fields_widget.dart';
import 'package:mealmate_dashboard/features/store/presentation/widgets/categories_ingredients/categories_ingredients_delete_fields_widget.dart';
import 'package:mealmate_dashboard/features/store/presentation/widgets/nutritional/nutritional_add_fields_widget.dart';
import 'package:mealmate_dashboard/features/store/presentation/widgets/nutritional/nutritional_delete_fields_widget.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  late final StoreCubit _storeCubit;

  @override
  void initState() {
    super.initState();
    _storeCubit = StoreCubit()..getCategories(IndexCategoriesParams());
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
                categoriesDataTable(state.categories),
                _ => Text('error'.tr()).center(),
              };
              },
            ).expand(),
          ],
        ).padding(AppConfig.pagePadding),
      ),
    );
  }

  Widget categoriesDataTable(List<CategoriesModel> categories){
    List<Map<String, dynamic>> data = [];
    List<MMDataTableColumn> dataTableColumns = [];

    for(var item in categories)
      {
        data.add({
          "id": item.id,
          "name": item.name,
          "image": item.url,
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
      dataTableTitle: "Categories Table".tr(),
        data: data,
        dataTableColumns: dataTableColumns,
      onRefresh: (){
        _storeCubit.getCategories(IndexCategoriesParams());
      },
      onAdd: (){
        showMMAddDialog(context: context,
          title: "Add Category".tr(),
          addFieldsWidget: CategoriesAddFieldWidget(
            onAddFinish: (){
              _storeCubit.getCategories(IndexCategoriesParams());
            },
          )
        );
      },
      onDelete: (id){

        showMMDeleteDialog(context: context,
            title: "Delete Category".tr(),
             deleteFieldsWidget: CategoriesDeleteFieldWidget(
               id: id,
               onDeleteFinish: (){
                 _storeCubit.getCategories(IndexCategoriesParams());
               },
             ),
        );
      },
    );
  }
}

