import 'package:mealmate_dashboard/core/unified_api/api_variables.dart';
import 'package:mealmate_dashboard/core/unified_api/methods/delete_api.dart';
import 'package:mealmate_dashboard/core/unified_api/methods/get_api.dart';
import 'package:mealmate_dashboard/core/unified_api/methods/post_api.dart';
import 'package:mealmate_dashboard/core/unified_api/methods/put_api.dart';
import 'package:mealmate_dashboard/features/store/data/models/categories_ingredient.dart';
import 'package:mealmate_dashboard/features/store/data/models/categories_model.dart';
import 'package:mealmate_dashboard/features/store/data/models/ingredient_model.dart';
import 'package:mealmate_dashboard/features/store/data/models/recipe_model.dart';
import 'package:mealmate_dashboard/features/store/data/models/types_model.dart';
import 'package:mealmate_dashboard/features/store/data/models/unit_types_model.dart';

class RemoteStoreDatasource {

  ///Recipes
  ///
  Future<RecipeModelResponse> indexRecipes({Map<String, dynamic>? params}) async {
    GetApi getApi = GetApi(
      uri: ApiVariables.indexRecipes(),
      fromJson: RecipeModelResponse.fromRawJson,
    );
    final result = await getApi.callRequest();
    return result;
  }

  Future<bool> addRecipe({required Map<String, dynamic> body}) async {
    PostApi postApi = PostApi(
      uri: ApiVariables.addRecipe(),
      body: body,
      fromJson: (v) => true,
    );
    final result = await postApi.callRequest();
    return result;
  }

  Future<bool> updateRecipe({required Map<String, dynamic> body}) async {
    PutApi putApi = PutApi(
      uri: ApiVariables.updateRecipe(id: body["id"]),
      body: body,
      fromJson: (v) => true,
    );
    final result = await putApi.callRequest();
    return result;
  }

  Future<bool> deleteRecipe({required Map<String, dynamic> params}) async {
    DeleteApi deleteApi = DeleteApi(
      uri: ApiVariables.deleteRecipe(
          id: params['id']
      ),
      fromJson: (v) => true,
    );
    final result = await deleteApi.callRequest();
    return result;
  }


  ///CATEGORIES
  ///

  Future<CategoriesModelResponse> indexCategories({Map<String, dynamic>? params}) async {
    GetApi getApi = GetApi(
      uri: ApiVariables.indexCategories(),
      fromJson: CategoriesModelResponse.fromRawJson,
    );
    final result = await getApi.callRequest();
    return result;
  }

  Future<bool> addCategories({required Map<String, dynamic> body}) async {
    PostApi postApi = PostApi(
      uri: ApiVariables.addCategories(),
      body: body,
      fromJson: (v) => true,
    );
    final result = await postApi.callRequest();
    return result;
  }

  Future<bool> updateCategories({required Map<String, dynamic> body}) async {
    PutApi putApi = PutApi(
      uri: ApiVariables.updateCategories(id: body["id"]),
      body: body,
      fromJson: (v) => true,
    );
    final result = await putApi.callRequest();
    return result;
  }

  Future<bool> deleteCategories({required Map<String, dynamic> params}) async {
    DeleteApi deleteApi = DeleteApi(
      uri: ApiVariables.deleteCategories(
          id: params['id']
      ),
      fromJson: (v) => true,
    );
    final result = await deleteApi.callRequest();
    return result;
  }


  ///TYPES
  ///


  Future<TypesModelResponse> indexTypes({Map<String, dynamic>? params}) async {
    GetApi getApi = GetApi(
      uri: ApiVariables.indexTypes(),
      fromJson: TypesModelResponse.fromRawJson,
    );
    final result = await getApi.callRequest();
    return result;
  }

  Future<bool> addTypes({required Map<String, dynamic> body}) async {
    PostApi postApi = PostApi(
      uri: ApiVariables.addTypes(),
      body: body,
      fromJson: (v) => true,
    );
    final result = await postApi.callRequest();
    return result;
  }

  Future<bool> updateType({required Map<String, dynamic> body}) async {
    PutApi putApi = PutApi(
      uri: ApiVariables.updateTypes(id: body["id"]),
      body: body,
      fromJson: (v) => true,
    );
    final result = await putApi.callRequest();
    return result;
  }

  Future<bool> deleteTypes({required Map<String, dynamic> params}) async {
    DeleteApi deleteApi = DeleteApi(
      uri: ApiVariables.deleteTypes(
          id: params['id']
      ),
      fromJson: (v) => true,
    );
    final result = await deleteApi.callRequest();
    return result;
  }

  ///INGREDIENTS
  ///

  Future<IngredientModelResponse> indexIngredients({Map<String, dynamic>? params}) async {
    GetApi getApi = GetApi(
      uri: ApiVariables.indexIngredients(),
      fromJson: IngredientModelResponse.fromRawJson,
    );
    final result = await getApi.callRequest();
    return result;
  }

  Future<bool> addIngredient({required Map<String, dynamic> body}) async {
    PostApi postApi = PostApi(
      uri: ApiVariables.addIngredients(),
      body: body,
      fromJson: (v) => true,
    );
    final result = await postApi.callRequest();
    return result;
  }

  Future<bool> updateIngredient({required Map<String, dynamic> body}) async {
    PutApi putApi = PutApi(
      uri: ApiVariables.updateIngredients(id: body["id"]),
      body: body,
      fromJson: (v) => true,
    );
    final result = await putApi.callRequest();
    return result;
  }

  Future<bool> deleteIngredient({required Map<String, dynamic> params}) async {
    DeleteApi deleteApi = DeleteApi(
      uri: ApiVariables.deleteIngredient(
          id: params['id']
      ),
      fromJson: (v) => true,
    );
    final result = await deleteApi.callRequest();
    return result;
  }

  ///NUTRITIONAL
  ///

  Future<NutritionalModelResponse> indexNutritional({Map<String, dynamic>? params}) async {
    GetApi getApi = GetApi(
      uri: ApiVariables.indexNutritional(),
      fromJson: NutritionalModelResponse.fromRawJson,
    );
    final result = await getApi.callRequest();
    return result;
  }

  Future<bool> addNutritional({required Map<String, dynamic> body}) async {
    PostApi postApi = PostApi(
      uri: ApiVariables.addNutritional(),
      body: body,
      fromJson: (v) => true,
    );
    final result = await postApi.callRequest();
    return result;
  }

  Future<bool> updateNutritional({required Map<String, dynamic> body}) async {
    PutApi putApi = PutApi(
      uri: ApiVariables.updateNutritional(id: body["id"]),
      body: body,
      fromJson: (v) => true,
    );
    final result = await putApi.callRequest();
    return result;
  }

  Future<bool> deleteNutritional({required Map<String, dynamic> params}) async {
    DeleteApi deleteApi = DeleteApi(
      uri: ApiVariables.deleteNutritional(
          id: params['id']
      ),
      fromJson: (v) => true,
    );
    final result = await deleteApi.callRequest();
    return result;
  }

  ///UNIT TYPES
  ///

  Future<UnitTypesModelResponse> indexUnitTypes({Map<String, dynamic>? params}) async {
    GetApi getApi = GetApi(
      uri: ApiVariables.indexUnitTypes(),
      fromJson: UnitTypesModelResponse.fromRawJson,
    );
    final result = await getApi.callRequest();
    return result;
  }


  ///CATEGORIES INGREDIENT
  ///
  Future<CategoriesIngredientResponse> indexCategoriesIngredient({Map<String, dynamic>? params}) async {
    GetApi getApi = GetApi(
      uri: ApiVariables.indexCategoriesIngredient(),
      fromJson: CategoriesIngredientResponse.fromRawJson,
    );
    final result = await getApi.callRequest();
    return result;
  }


  Future<bool> addCategoriesIngredient({required Map<String, dynamic> body}) async {
    PostApi postApi = PostApi(
      uri: ApiVariables.addCategoriesIngredient(),
      body: body,
      fromJson: (v) => true,
    );
    final result = await postApi.callRequest();
    return result;
  }

  Future<bool> updateCategoriesIngredient({required Map<String, dynamic> body}) async {
    PutApi putApi = PutApi(
      uri: ApiVariables.updateCategoriesIngredient(id: body["id"]),
      body: body,
      fromJson: (v) => true,
    );
    final result = await putApi.callRequest();
    return result;
  }


  Future<bool> deleteCategoriesIngredient({required Map<String, dynamic> params}) async {
    DeleteApi deleteApi = DeleteApi(
      uri: ApiVariables.deleteCategoriesIngredient(
          id: params['id']
      ),
      fromJson: (v) => true,
    );
    final result = await deleteApi.callRequest();
    return result;
  }


}
