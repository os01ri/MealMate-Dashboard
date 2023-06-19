import 'package:dartz/dartz.dart';
import 'package:mealmate_dashboard/core/error/failures.dart';
import 'package:mealmate_dashboard/core/unified_api/handling_exception_manager.dart';
import 'package:mealmate_dashboard/features/store/data/datasources/remote_store_datasource.dart';
import 'package:mealmate_dashboard/features/store/data/models/categories_ingredient.dart';
import 'package:mealmate_dashboard/features/store/data/models/ingredient_model.dart';
import 'package:mealmate_dashboard/features/store/data/models/unit_types_model.dart';
import 'package:mealmate_dashboard/features/store/domain/repositories/store_repository.dart';

class StoreRepositoryImpl with HandlingExceptionManager implements StoreRepository {
  final _datasource = RemoteStoreDatasource();

  @override
  Future<Either<Failure, IngredientModelResponse>> indexIngredients({Map<String, dynamic>? params}) {
    return wrapHandling(
      tryCall: () async {
        final result = await _datasource.indexIngredients(params: params);
        return Right(result);
      },
    );
  }

  @override
  Future<Either<Failure, bool>> addIngredients({required Map<String, dynamic> body}) {
    return wrapHandling(
      tryCall: () async {
        final result = await _datasource.addIngredient(body: body);
        return Right(result);
      },
    );
  }


  @override
  Future<Either<Failure, NutritionalModelResponse>> indexNutritional({Map<String, dynamic>? params}) {
    return wrapHandling(
      tryCall: () async {
        final result = await _datasource.indexNutritional(params: params);
        return Right(result);
      },
    );
  }

  @override
  Future<Either<Failure, bool>> addNutritional({required Map<String, dynamic> body}) {
    return wrapHandling(
      tryCall: () async {
        final result = await _datasource.addNutritional(body: body);
        return Right(result);
      },
    );
  }



  @override
  Future<Either<Failure, bool>> deleteNutritional({required Map<String, dynamic> params}) {
    return wrapHandling(
      tryCall: () async {
        final result = await _datasource.deleteNutritional(params: params);
        return Right(result);
      },
    );
  }

  @override
  Future<Either<Failure, bool>> deleteIngredient({required Map<String, dynamic> params}) {
    return wrapHandling(
      tryCall: () async {
        final result = await _datasource.deleteIngredient(params: params);
        return Right(result);
      },
    );
  }


  @override
  Future<Either<Failure, UnitTypesModelResponse>> indexUnitTypes({Map<String, dynamic>? params}) {
    return wrapHandling(
      tryCall: () async {
        final result = await _datasource.indexUnitTypes(params: params);
        return Right(result);
      },
    );
  }

  @override
  Future<Either<Failure, CategoriesIngredientResponse>> indexCategoriesIngredient({Map<String, dynamic>? params}) {
    return wrapHandling(
      tryCall: () async {
        final result = await _datasource.indexCategoriesIngredient(params: params);
        return Right(result);
      },
    );
  }




  @override
  Future<Either<Failure, IngredientModel>> showIngredient({required int id}) {
    // TODO: implement showIngredient
    throw UnimplementedError();
  }
}
