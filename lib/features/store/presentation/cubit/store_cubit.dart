import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:mealmate_dashboard/core/helper/cubit_status.dart';
import 'package:mealmate_dashboard/core/unified_api/parallel/parallel.dart';
import 'package:mealmate_dashboard/core/unified_api/parallel/parallel_service.dart';
import 'package:mealmate_dashboard/features/store/data/models/categories_ingredient.dart';
import 'package:mealmate_dashboard/features/store/data/models/categories_model.dart';
import 'package:mealmate_dashboard/features/store/data/models/ingredient_model.dart';
import 'package:mealmate_dashboard/features/store/data/models/recipe_model.dart';
import 'package:mealmate_dashboard/features/store/data/models/types_model.dart';
import 'package:mealmate_dashboard/features/store/data/models/unit_types_model.dart';
import 'package:mealmate_dashboard/features/store/data/repositories/store_repository_impl.dart';
import 'package:mealmate_dashboard/features/store/domain/usecases/add_categories.dart';
import 'package:mealmate_dashboard/features/store/domain/usecases/add_categories_types.dart';
import 'package:mealmate_dashboard/features/store/domain/usecases/add_ingredients.dart';
import 'package:mealmate_dashboard/features/store/domain/usecases/add_nutritional.dart';
import 'package:mealmate_dashboard/features/store/domain/usecases/add_recipes.dart';
import 'package:mealmate_dashboard/features/store/domain/usecases/add_types.dart';
import 'package:mealmate_dashboard/features/store/domain/usecases/delete_categories.dart';
import 'package:mealmate_dashboard/features/store/domain/usecases/delete_categories_types.dart';
import 'package:mealmate_dashboard/features/store/domain/usecases/delete_ingredient.dart';
import 'package:mealmate_dashboard/features/store/domain/usecases/delete_nutritional.dart';
import 'package:mealmate_dashboard/features/store/domain/usecases/delete_recipe.dart';
import 'package:mealmate_dashboard/features/store/domain/usecases/delete_types.dart';
import 'package:mealmate_dashboard/features/store/domain/usecases/index_categories.dart';
import 'package:mealmate_dashboard/features/store/domain/usecases/index_categories_ingredient.dart';
import 'package:mealmate_dashboard/features/store/domain/usecases/index_ingredients.dart';
import 'package:mealmate_dashboard/features/store/domain/usecases/index_nutritional.dart';
import 'package:mealmate_dashboard/features/store/domain/usecases/index_recipe.dart';
import 'package:mealmate_dashboard/features/store/domain/usecases/index_types.dart';
import 'package:mealmate_dashboard/features/store/domain/usecases/index_unit_types.dart';

part 'store_state.dart';

class StoreCubit extends Cubit<StoreState> {
  final _indexRecipes = IndexRecipesUseCase(storeRepository: StoreRepositoryImpl());
  final _addRecipe = AddRecipesUseCase(storeRepository: StoreRepositoryImpl());
  final _deleteRecipe = DeleteRecipeUseCase(storeRepository: StoreRepositoryImpl());

  final _indexIngredients = IndexIngredientsUseCase(storeRepository: StoreRepositoryImpl());
  final _addIngredients = AddIngredientsUseCase(storeRepository: StoreRepositoryImpl());
  final _deleteIngredient = DeleteIngredientUseCase(storeRepository: StoreRepositoryImpl());

  final _indexNutritional = IndexNutritionalUseCase(storeRepository: StoreRepositoryImpl());
  final _addNutritional = AddNutritionalUseCase(storeRepository: StoreRepositoryImpl());
  final _deleteNutritional = DeleteNutritionalUseCase(storeRepository: StoreRepositoryImpl());

  final _indexUnitTypes = IndexUnitTypesUseCase(storeRepository: StoreRepositoryImpl());

  final _indexCategoriesTypes = IndexCategoriesIngredientUseCase(storeRepository: StoreRepositoryImpl());
  final _addCategoriesTypes = AddCategoriesIngredientUseCase(storeRepository: StoreRepositoryImpl());
  final _deleteCategoriesTypes = DeleteCategoriesIngredientUseCase(storeRepository: StoreRepositoryImpl());

  final _indexCategories = IndexCategoriesUseCase(storeRepository: StoreRepositoryImpl());
  final _addCategories = AddCategoriesUseCase(storeRepository: StoreRepositoryImpl());
  final _deleteCategories = DeleteCategoriesUseCase(storeRepository: StoreRepositoryImpl());

  final _indexTypes = IndexTypesUseCase(storeRepository: StoreRepositoryImpl());
  final _addTypes = AddTypesUseCase(storeRepository: StoreRepositoryImpl());
  final _deleteTypes = DeleteTypesUseCase(storeRepository: StoreRepositoryImpl());

  StoreCubit() : super(const StoreState());

  getRecipes(IndexRecipesParams params) async {
    emit(state.copyWith(status: CubitStatus.loading));

    final result = await _indexRecipes(params);

    result.fold(
          (l) {
        log('fail');
        emit(state.copyWith(status: CubitStatus.failure));
      },
          (r) {
        log('succ');
        emit(state.copyWith(status: CubitStatus.success, recipes: r.data));
      },
    );
  }

  addRecipe(AddRecipeParams params) async {
    emit(state.copyWith(status: CubitStatus.loading));

    final result = await _addRecipe(params);

    result.fold(
          (l) {
        log('fail');
        emit(state.copyWith(status: CubitStatus.failure));
      },
          (r) {
        log('succ');
        emit(state.copyWith(status: CubitStatus.success));
      },
    );
  }

  deleteRecipe(DeleteRecipeParams params) async {
    emit(state.copyWith(status: CubitStatus.loading));

    final result = await _deleteRecipe(params);

    result.fold(
          (l) {
        log('fail');
        emit(state.copyWith(status: CubitStatus.failure));
      },
          (r) {
        log('succ');
        emit(state.copyWith(status: CubitStatus.success));
      },
    );
  }



  getCategories(IndexCategoriesParams params) async {
    emit(state.copyWith(status: CubitStatus.loading));

    final result = await _indexCategories(params);

    result.fold(
          (l) {
        log('fail');
        emit(state.copyWith(status: CubitStatus.failure));
      },
          (r) {
        log('succ');
        emit(state.copyWith(status: CubitStatus.success, categories: r.data));
      },
    );
  }

  addCategories(AddCategoriesParams params) async {
    emit(state.copyWith(status: CubitStatus.loading));

    final result = await _addCategories(params);

    result.fold(
          (l) {
        log('fail');
        emit(state.copyWith(status: CubitStatus.failure));
      },
          (r) {
        log('succ');
        emit(state.copyWith(status: CubitStatus.success));
      },
    );
  }

  deleteCategories(DeleteCategoriesParams params) async {
    emit(state.copyWith(status: CubitStatus.loading));

    final result = await _deleteCategories(params);

    result.fold(
          (l) {
        log('fail');
        emit(state.copyWith(status: CubitStatus.failure));
      },
          (r) {
        log('succ');
        emit(state.copyWith(status: CubitStatus.success));
      },
    );
  }



  getTypes(IndexTypesParams params) async {
    emit(state.copyWith(status: CubitStatus.loading));

    final result = await _indexTypes(params);

    result.fold(
          (l) {
        log('fail');
        emit(state.copyWith(status: CubitStatus.failure));
      },
          (r) {
        log('succ');
        emit(state.copyWith(status: CubitStatus.success, types: r.data));
      },
    );
  }

  addTypes(AddTypesParams params) async {
    emit(state.copyWith(status: CubitStatus.loading));

    final result = await _addTypes(params);

    result.fold(
          (l) {
        log('fail');
        emit(state.copyWith(status: CubitStatus.failure));
      },
          (r) {
        log('succ');
        emit(state.copyWith(status: CubitStatus.success));
      },
    );
  }

  deleteTypes(DeleteTypesParams params) async {
    emit(state.copyWith(status: CubitStatus.loading));

    final result = await _deleteTypes(params);

    result.fold(
          (l) {
        log('fail');
        emit(state.copyWith(status: CubitStatus.failure));
      },
          (r) {
        log('succ');
        emit(state.copyWith(status: CubitStatus.success));
      },
    );
  }



  getIngredients(IndexIngredientsParams params) async {
    emit(state.copyWith(status: CubitStatus.loading));

    final result = await _indexIngredients(params);

    result.fold(
          (l) {
        log('fail');
        emit(state.copyWith(status: CubitStatus.failure));
      },
          (r) {
        log('succ');
        emit(state.copyWith(status: CubitStatus.success, ingredients: r.data));
      },
    );
  }

  addIngredients(AddIngredientsParams params) async {
    emit(state.copyWith(status: CubitStatus.loading));

    final result = await _addIngredients(params);

    result.fold(
          (l) {
        log('fail');
        emit(state.copyWith(status: CubitStatus.failure));
      },
          (r) {
        log('succ');
        emit(state.copyWith(status: CubitStatus.success));
      },
    );
  }

  deleteIngredient(DeleteIngredientParams params) async {
    emit(state.copyWith(status: CubitStatus.loading));

    final result = await _deleteIngredient(params);

    result.fold(
          (l) {
        log('fail');
        emit(state.copyWith(status: CubitStatus.failure));
      },
          (r) {
        log('succ');
        emit(state.copyWith(status: CubitStatus.success));
      },
    );
  }


  getNutritional(IndexNutritionalParams params) async {
    emit(state.copyWith(status: CubitStatus.loading));

    final result = await _indexNutritional(params);

    result.fold(
          (l) {
        log('fail');
        emit(state.copyWith(status: CubitStatus.failure));
      },
          (r) {
        log('succ');
        emit(state.copyWith(status: CubitStatus.success, nutritional: r.data));
      },
    );
  }

  addNutritional(AddNutritionalParams params) async {
    emit(state.copyWith(status: CubitStatus.loading));

    final result = await _addNutritional(params);

    result.fold(
          (l) {
        log('fail');
        emit(state.copyWith(status: CubitStatus.failure));
      },
          (r) {
        log('succ');
        emit(state.copyWith(status: CubitStatus.success));
      },
    );
  }

  deleteNutritional(DeleteNutritionalParams params) async {
    emit(state.copyWith(status: CubitStatus.loading));

    final result = await _deleteNutritional(params);

    result.fold(
          (l) {
        log('fail');
        emit(state.copyWith(status: CubitStatus.failure));
      },
          (r) {
        log('succ');
        emit(state.copyWith(status: CubitStatus.success));
      },
    );
  }

  getUnitTypes(IndexUnitTypesParams params) async {
    emit(state.copyWith(status: CubitStatus.loading));

    final result = await _indexUnitTypes(params);

    result.fold(
          (l) {
        log('fail');
        emit(state.copyWith(status: CubitStatus.failure));
      },
          (r) {
        log('succ');
        emit(state.copyWith(status: CubitStatus.success, unitTypes: r.data));
      },
    );
  }

  getIngredientsCategories(IndexCategoriesIngredientParams params) async {
    emit(state.copyWith(status: CubitStatus.loading));

    final result = await _indexCategoriesTypes(params);

    result.fold(
          (l) {
        log('fail');
        emit(state.copyWith(status: CubitStatus.failure));
      },
          (r) {
        log('succ');
        emit(state.copyWith(status: CubitStatus.success, categoriesIngredients: r.data));
      },
    );
  }

  addIngredientsCategories(AddCategoriesIngredientParams params) async {
    emit(state.copyWith(status: CubitStatus.loading));

    final result = await _addCategoriesTypes(params);

    result.fold(
          (l) {
        log('fail');
        emit(state.copyWith(status: CubitStatus.failure));
      },
          (r) {
        log('succ');
        emit(state.copyWith(status: CubitStatus.success));
      },
    );
  }

  deleteIngredientsCategories(DeleteCategoriesIngredientParams params) async {
    emit(state.copyWith(status: CubitStatus.loading));

    final result = await _deleteCategoriesTypes(params);

    result.fold(
          (l) {
        log('fail');
        emit(state.copyWith(status: CubitStatus.failure));
      },
          (r) {
        log('succ');
        emit(state.copyWith(status: CubitStatus.success));
      },
    );
  }


  getNutritionalAndUnitsAndCategories(
      {required IndexUnitTypesParams paramsUnits,
        required IndexCategoriesIngredientParams paramsCategoriesIngredient,
        required IndexNutritionalParams paramsNutritional,
      }){
    emit(state.copyWith(status: CubitStatus.loading));


    ParallelService parallelService = ParallelService(services: [
      ParallelModel(
          service: _indexUnitTypes(paramsUnits),
          name: "_indexUnitTypes"),
      ParallelModel(
          service: _indexCategoriesTypes(paramsCategoriesIngredient),
          name: "_indexCategoriesTypes"),
      ParallelModel(
          service: _indexNutritional(paramsNutritional),
          name: "_indexNutritional"),
    ]);


    parallelService.getResults().catchError((onError){
      log('fail');
      emit(state.copyWith(status: CubitStatus.failure));
    }).then((value) {
      if (parallelService.isServicesFailed()) {
        log('fail');
        emit(state.copyWith(status: CubitStatus.failure));

      } else {
        log('success');

        dynamic indexNutritionalResult = value!.firstWhere((element) => element.name=="_indexNutritional").finalResult;
        var indexNutritionalData = indexNutritionalResult.fold((l) {log('fail');}, (r) => r.data,);

        dynamic indexCategoriesTypesResult = value.firstWhere((element) => element.name=="_indexCategoriesTypes").finalResult;
        var indexCategoriesTypesData = indexCategoriesTypesResult.fold((l) {log('fail');}, (r) => r.data,);

        dynamic indexUnitTypesResult = value.firstWhere((element) => element.name=="_indexUnitTypes").finalResult;
        var indexUnitTypesData = indexUnitTypesResult.fold((l) {log('fail');}, (r) => r.data,);

        emit(
            state.copyWith(
              status: CubitStatus.success,
              nutritional: indexNutritionalData,
              categoriesIngredients: indexCategoriesTypesData,
              unitTypes: indexUnitTypesData,
            ));
      }
    });

  }


  getRecipesAndUnitsAndCategories(
      {required IndexTypesParams paramsTypes,
        required IndexCategoriesParams paramsCategories,
        required IndexIngredientsParams paramsIngredients,
        required IndexUnitTypesParams paramsUnitTypes,
      }){
    emit(state.copyWith(status: CubitStatus.loading));


    ParallelService parallelService = ParallelService(services: [
      ParallelModel(
          service: _indexTypes(paramsTypes),
          name: "_indexTypes"),
      ParallelModel(
          service: _indexCategories(paramsCategories),
          name: "_indexCategories"),
      ParallelModel(
          service: _indexIngredients(paramsIngredients),
          name: "_indexIngredients"),
      ParallelModel(
          service: _indexUnitTypes(paramsUnitTypes),
          name: "_indexUnitTypes"),
    ]);


    parallelService.getResults().catchError((onError){
      log('fail');
      emit(state.copyWith(status: CubitStatus.failure));
    }).then((value) {
      if (parallelService.isServicesFailed()) {
        log('fail');
        emit(state.copyWith(status: CubitStatus.failure));

      } else {
        log('success');

        dynamic indexIngredientsResult = value!.firstWhere((element) => element.name=="_indexIngredients").finalResult;
        var indexIngredientsData = indexIngredientsResult.fold((l) {log('fail');}, (r) => r.data,);

        dynamic indexCategoriesResult = value.firstWhere((element) => element.name=="_indexCategories").finalResult;
        var indexCategoriesData = indexCategoriesResult.fold((l) {log('fail');}, (r) => r.data,);

        dynamic indexTypesResult = value.firstWhere((element) => element.name=="_indexTypes").finalResult;
        var indexTypesData = indexTypesResult.fold((l) {log('fail');}, (r) => r.data,);

        dynamic indexUnitTypesResult = value.firstWhere((element) => element.name=="_indexUnitTypes").finalResult;
        var indexUnitTypesData = indexUnitTypesResult.fold((l) {log('fail');}, (r) => r.data,);

        emit(
            state.copyWith(
              status: CubitStatus.success,
              ingredients: indexIngredientsData,
              categories: indexCategoriesData,
              types: indexTypesData,
              unitTypes: indexUnitTypesData
            ));
      }
    });

  }

}
