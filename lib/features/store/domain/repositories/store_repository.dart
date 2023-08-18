import 'package:dartz/dartz.dart';
import 'package:mealmate_dashboard/core/error/failures.dart';
import 'package:mealmate_dashboard/features/store/data/models/categories_ingredient.dart';
import 'package:mealmate_dashboard/features/store/data/models/categories_model.dart';
import 'package:mealmate_dashboard/features/store/data/models/ingredient_model.dart';
import 'package:mealmate_dashboard/features/store/data/models/recipe_model.dart';
import 'package:mealmate_dashboard/features/store/data/models/types_model.dart';
import 'package:mealmate_dashboard/features/store/data/models/unit_types_model.dart';

abstract class StoreRepository {
  Future<Either<Failure, RecipeModelResponse>> indexRecipes({Map<String, dynamic> params});

  Future<Either<Failure, bool>> addRecipe({required Map<String, dynamic> body});

  Future<Either<Failure, bool>> updateRecipe({required Map<String, dynamic> body});

  Future<Either<Failure, bool>> deleteRecipe({required Map<String, dynamic> params});

  Future<Either<Failure, bool>> acceptRecipe({required Map<String, dynamic> params});

  Future<Either<Failure, bool>> disableRecipe({required Map<String, dynamic> params});


  Future<Either<Failure, CategoriesModelResponse>> indexCategories({Map<String, dynamic> params});

  Future<Either<Failure, bool>> addCategories({required Map<String, dynamic> body});

  Future<Either<Failure, bool>> updateCategories({required Map<String, dynamic> body});

  Future<Either<Failure, bool>> deleteCategories({required Map<String, dynamic> params});


  Future<Either<Failure, TypesModelResponse>> indexTypes({Map<String, dynamic> params});

  Future<Either<Failure, bool>> addTypes({required Map<String, dynamic> body});

  Future<Either<Failure, bool>> updateTypes({required Map<String, dynamic> body});

  Future<Either<Failure, bool>> deleteTypes({required Map<String, dynamic> params});



  Future<Either<Failure, IngredientModelResponse>> indexIngredients({Map<String, dynamic> params});

  Future<Either<Failure, bool>> addIngredients({required Map<String, dynamic> body});

  Future<Either<Failure, bool>> updateIngredients({required Map<String, dynamic> body});

  Future<Either<Failure, bool>> deleteIngredient({required Map<String, dynamic> params});



  Future<Either<Failure, NutritionalModelResponse>> indexNutritional({Map<String, dynamic> params});

  Future<Either<Failure, bool>> addNutritional({required Map<String, dynamic> body});

  Future<Either<Failure, bool>> updateNutritional({required Map<String, dynamic> body});

  Future<Either<Failure, bool>> deleteNutritional({required Map<String, dynamic> params});



  Future<Either<Failure, UnitTypesModelResponse>> indexUnitTypes({required Map<String, dynamic> params});



  Future<Either<Failure, CategoriesIngredientResponse>> indexCategoriesIngredient({required Map<String, dynamic> params});

  Future<Either<Failure, bool>> addCategoriesIngredient({required Map<String, dynamic> body});

  Future<Either<Failure, bool>> updateCategoriesIngredient({required Map<String, dynamic> body});

  Future<Either<Failure, bool>> deleteCategoriesIngredient({required Map<String, dynamic> params});



  Future<Either<Failure, IngredientModel>> showIngredient({required int id});
}
