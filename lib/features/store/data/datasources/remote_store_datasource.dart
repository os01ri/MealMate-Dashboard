import 'package:mealmate_dashboard/core/unified_api/api_variables.dart';
import 'package:mealmate_dashboard/core/unified_api/methods/get_api.dart';
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

}
