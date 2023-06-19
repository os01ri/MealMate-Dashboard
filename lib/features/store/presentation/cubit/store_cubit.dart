import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:mealmate_dashboard/core/helper/cubit_status.dart';
import 'package:mealmate_dashboard/core/unified_api/parallel/parallel.dart';
import 'package:mealmate_dashboard/core/unified_api/parallel/parallel_service.dart';
import 'package:mealmate_dashboard/features/store/data/models/ingredient_model.dart';
import 'package:mealmate_dashboard/features/store/data/repositories/store_repository_impl.dart';
import 'package:mealmate_dashboard/features/store/domain/usecases/add_ingredients.dart';
import 'package:mealmate_dashboard/features/store/domain/usecases/add_nutritional.dart';
import 'package:mealmate_dashboard/features/store/domain/usecases/delete_nutritional.dart';
import 'package:mealmate_dashboard/features/store/domain/usecases/index_ingredients.dart';
import 'package:mealmate_dashboard/features/store/domain/usecases/index_nutritional.dart';

part 'store_state.dart';

class StoreCubit extends Cubit<StoreState> {
  final _indexIngredients = IndexIngredientsUseCase(storeRepository: StoreRepositoryImpl());
  final _addIngredients = AddIngredientsUseCase(storeRepository: StoreRepositoryImpl());
  final _indexNutritional = IndexNutritionalUseCase(storeRepository: StoreRepositoryImpl());
  final _addNutritional = AddNutritionalUseCase(storeRepository: StoreRepositoryImpl());
  final _deleteNutritional = DeleteNutritionalUseCase(storeRepository: StoreRepositoryImpl());

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

  get(IndexNutritionalParams params){
    emit(state.copyWith(status: CubitStatus.loading));
    
     
    ParallelService parallelService = ParallelService(services: [
      ParallelModel(
          service: _indexNutritional(params),
          name: "_indexNutritional"),
    ]);


    parallelService.getResults().catchError((onError){
     
    }).then((value) {
      if (parallelService.isServicesFailed()) {
        log('fail');
        emit(state.copyWith(status: CubitStatus.failure));
       
      } else {
        dynamic forstRes = value!.firstWhere((element) => element.name=="_indexNutritional").finalResult;
        log('succ sadads');
        var fData = forstRes.fold(
              (l) {
            log('fail');
          },
              (r) => r.data,
        );
        emit(state.copyWith(status: CubitStatus.success, nutritional: fData));
      }
    });

  }

}
