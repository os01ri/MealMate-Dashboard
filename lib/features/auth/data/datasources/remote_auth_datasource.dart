

import 'package:mealmate_dashboard/core/unified_api/api_variables.dart';
import 'package:mealmate_dashboard/core/unified_api/methods/post_api.dart';
import 'package:mealmate_dashboard/features/auth/data/models/login_response_model.dart';

class RemoteAuthDataSource {
  const RemoteAuthDataSource._();


  static Future<LoginResponseModel> loginUser({required Map<String, dynamic> body}) async {
    PostApi postApi = PostApi(
      uri: ApiVariables.login(),
      body: body,
      fromJson: loginResponseModelFromJson,
    );
    final result = await postApi.callRequest();
    return result;
  }

}
