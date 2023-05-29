import 'package:mealmate_dashboard/core/unified_api/api_variables.dart';
import 'package:mealmate_dashboard/core/unified_api/methods/delete_api.dart';
import 'package:mealmate_dashboard/core/unified_api/methods/get_api.dart';
import 'package:mealmate_dashboard/core/unified_api/methods/post_api.dart';
import 'package:mealmate_dashboard/features/store/data/models/ingredient_model.dart';

class RemoteStoreDatasource {
  Future<IngredientModelResponse> indexIngredients({Map<String, dynamic>? params}) async {
    GetApi getApi = GetApi(
      uri: ApiVariables.indexIngredients(),
      fromJson: IngredientModelResponse.fromRawJson,
    );
    final result = await getApi.callRequest();
    return result;
  }

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

}
