import 'package:dartz/dartz.dart';
import 'package:mealmate_dashboard/core/error/failures.dart';
import 'package:mealmate_dashboard/features/store/data/models/categories_ingredient.dart';
import 'package:mealmate_dashboard/features/store/data/models/ingredient_model.dart';
import 'package:mealmate_dashboard/features/store/data/models/unit_types_model.dart';

abstract class StoreRepository {
  Future<Either<Failure, IngredientModelResponse>> indexIngredients({Map<String, dynamic> params});

  Future<Either<Failure, bool>> addIngredients({required Map<String, dynamic> body});

  Future<Either<Failure, bool>> deleteIngredient({required Map<String, dynamic> params});

  Future<Either<Failure, NutritionalModelResponse>> indexNutritional({Map<String, dynamic> params});

  Future<Either<Failure, bool>> addNutritional({required Map<String, dynamic> body});

  Future<Either<Failure, bool>> deleteNutritional({required Map<String, dynamic> params});

  Future<Either<Failure, UnitTypesModelResponse>> indexUnitTypes({required Map<String, dynamic> params});

  Future<Either<Failure, CategoriesIngredientResponse>> indexCategoriesIngredient({required Map<String, dynamic> params});

  Future<Either<Failure, bool>> addCategoriesIngredient({required Map<String, dynamic> body});

  Future<Either<Failure, bool>> deleteCategoriesIngredient({required Map<String, dynamic> params});

  Future<Either<Failure, IngredientModel>> showIngredient({required int id});
}
