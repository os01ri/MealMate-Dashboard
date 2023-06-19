import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:mealmate_dashboard/core/helper/cubit_status.dart';
import 'package:mealmate_dashboard/core/unified_api/parallel/parallel.dart';
import 'package:mealmate_dashboard/core/unified_api/parallel/parallel_service.dart';
import 'package:mealmate_dashboard/features/store/data/models/categories_ingredient.dart';
import 'package:mealmate_dashboard/features/store/data/models/ingredient_model.dart';
import 'package:mealmate_dashboard/features/store/data/models/unit_types_model.dart';
import 'package:mealmate_dashboard/features/store/data/repositories/store_repository_impl.dart';
import 'package:mealmate_dashboard/features/store/domain/usecases/add_ingredients.dart';
import 'package:mealmate_dashboard/features/store/domain/usecases/add_nutritional.dart';
import 'package:mealmate_dashboard/features/store/domain/usecases/delete_ingredient.dart';
import 'package:mealmate_dashboard/features/store/domain/usecases/delete_nutritional.dart';
import 'package:mealmate_dashboard/features/store/domain/usecases/index_categories_ingredient.dart';
import 'package:mealmate_dashboard/features/store/domain/usecases/index_ingredients.dart';
import 'package:mealmate_dashboard/features/store/domain/usecases/index_nutritional.dart';
import 'package:mealmate_dashboard/features/store/domain/usecases/index_unit_types.dart';

part 'store_state.dart';

class StoreCubit extends Cubit<StoreState> {
  final _indexIngredients = IndexIngredientsUseCase(storeRepository: StoreRepositoryImpl());
  final _addIngredients = AddIngredientsUseCase(storeRepository: StoreRepositoryImpl());
  final _deleteIngredient = DeleteIngredientUseCase(storeRepository: StoreRepositoryImpl());
  final _indexNutritional = IndexNutritionalUseCase(storeRepository: StoreRepositoryImpl());
  final _addNutritional = AddNutritionalUseCase(storeRepository: StoreRepositoryImpl());
  final _deleteNutritional = DeleteNutritionalUseCase(storeRepository: StoreRepositoryImpl());
  final _indexUnitTypes = IndexUnitTypesUseCase(storeRepository: StoreRepositoryImpl());
  final _indexCategoriesTypes = IndexCategoriesIngredientUseCase(storeRepository: StoreRepositoryImpl());

  StoreCubit() : super(const StoreState());

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
          categories: indexCategoriesTypesData,
          unitTypes: indexUnitTypesData,
        ));
      }
    });

  }

}
