import 'package:dartz/dartz.dart';
import 'package:mealmate_dashboard/core/error/failures.dart';
import 'package:mealmate_dashboard/core/unified_api/handling_exception_manager.dart';
import 'package:mealmate_dashboard/features/store/data/datasources/remote_store_datasource.dart';
import 'package:mealmate_dashboard/features/store/data/models/categories_ingredient.dart';
import 'package:mealmate_dashboard/features/store/data/models/categories_model.dart';
import 'package:mealmate_dashboard/features/store/data/models/ingredient_model.dart';
import 'package:mealmate_dashboard/features/store/data/models/recipe_model.dart';
import 'package:mealmate_dashboard/features/store/data/models/types_model.dart';
import 'package:mealmate_dashboard/features/store/data/models/unit_types_model.dart';
import 'package:mealmate_dashboard/features/store/domain/repositories/store_repository.dart';

class StoreRepositoryImpl with HandlingExceptionManager implements StoreRepository {
  final _datasource = RemoteStoreDatasource();

  @override
  Future<Either<Failure, RecipeModelResponse>> indexRecipes({Map<String, dynamic>? params}) {
    return wrapHandling(
      tryCall: () async {
        final result = await _datasource.indexRecipes(params: params);
        return Right(result);
      },
    );
  }

  @override
  Future<Either<Failure, bool>> addRecipe({required Map<String, dynamic> body}) {
    return wrapHandling(
      tryCall: () async {
        final result = await _datasource.addRecipe(body: body);
        return Right(result);
      },
    );
  }

  @override
  Future<Either<Failure, bool>> deleteRecipe({required Map<String, dynamic> params}) {
    return wrapHandling(
      tryCall: () async {
        final result = await _datasource.deleteRecipe(params: params);
        return Right(result);
      },
    );
  }



  @override
  Future<Either<Failure, CategoriesModelResponse>> indexCategories({Map<String, dynamic>? params}) {
    return wrapHandling(
      tryCall: () async {
        final result = await _datasource.indexCategories(params: params);
        return Right(result);
      },
    );
  }

  @override
  Future<Either<Failure, bool>> addCategories({required Map<String, dynamic> body}) {
    return wrapHandling(
      tryCall: () async {
        final result = await _datasource.addCategories(body: body);
        return Right(result);
      },
    );
  }

  @override
  Future<Either<Failure, bool>> deleteCategories({required Map<String, dynamic> params}) {
    return wrapHandling(
      tryCall: () async {
        final result = await _datasource.deleteCategories(params: params);
        return Right(result);
      },
    );
  }



  @override
  Future<Either<Failure, TypesModelResponse>> indexTypes({Map<String, dynamic>? params}) {
    return wrapHandling(
      tryCall: () async {
        final result = await _datasource.indexTypes(params: params);
        return Right(result);
      },
    );
  }

  @override
  Future<Either<Failure, bool>> addTypes({required Map<String, dynamic> body}) {
    return wrapHandling(
      tryCall: () async {
        final result = await _datasource.addTypes(body: body);
        return Right(result);
      },
    );
  }

  @override
  Future<Either<Failure, bool>> deleteTypes({required Map<String, dynamic> params}) {
    return wrapHandling(
      tryCall: () async {
        final result = await _datasource.deleteTypes(params: params);
        return Right(result);
      },
    );
  }



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
  Future<Either<Failure, bool>> deleteIngredient({required Map<String, dynamic> params}) {
    return wrapHandling(
      tryCall: () async {
        final result = await _datasource.deleteIngredient(params: params);
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
  Future<Either<Failure, bool>> addCategoriesIngredient({required Map<String, dynamic> body}) {
    return wrapHandling(
      tryCall: () async {
        final result = await _datasource.addCategoriesIngredient(body: body);
        return Right(result);
      },
    );
  }



  @override
  Future<Either<Failure, bool>> deleteCategoriesIngredient({required Map<String, dynamic> params}) {
    return wrapHandling(
      tryCall: () async {
        final result = await _datasource.deleteCategoriesIngredient(params: params);
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
