import 'package:dartz/dartz.dart';
import 'package:mealmate_dashboard/core/error/failures.dart';
import 'package:mealmate_dashboard/features/store/data/models/ingredient_model.dart';

abstract class StoreRepository {
  Future<Either<Failure, IngredientModelResponse>> indexIngredients({Map<String, dynamic> params});

  Future<Either<Failure, bool>> addIngredients({required Map<String, dynamic> body});

  Future<Either<Failure, NutritionalModelResponse>> indexNutritional({Map<String, dynamic> params});

  Future<Either<Failure, bool>> addNutritional({required Map<String, dynamic> body});

  Future<Either<Failure, bool>> deleteNutritional({required Map<String, dynamic> params});

  Future<Either<Failure, IngredientModel>> showIngredient({required int id});
}
