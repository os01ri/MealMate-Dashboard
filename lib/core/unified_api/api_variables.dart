import 'dart:developer';

class ApiVariables {
  /////////////
  ///General///
  /////////////
  static const _scheme = 'http';
  static const _host = 'food.programmer23.store';

  static Uri _mainUri({
    required String path,
    Map<String, dynamic>? queryParameters,
  }) {
    final uri = Uri(
      scheme: _scheme,
      host: _host,
      path: '/$path',
      queryParameters: queryParameters,
    );
    log(uri.toString());
    return uri;
  }

  static Uri notificationsUri() {
    final uri = Uri(
      scheme: "https",
      host: "fcm.googleapis.com",
      path: "/fcm/send",
    );
    log(uri.toString());
    return uri;
  }

  ///Auth
  static Uri _auth({required String path}) {
    return _mainUri(path: 'auth/$path');
  }



  static Uri uploadMedia() => _mainUri(path: 'mediaUpload');
  // Uri uploadVideo() => _mainUri(path: "videoUpload");
  // Uri uploadGif() => _mainUri(path: "GIFUpload");

  static Uri _mobileUri({required String path, Map<String, dynamic>? queryParameters}) => _mainUri(
    path: path,
    queryParameters: queryParameters,
  );

  static Uri _dashboardUri({required String path, Map<String, dynamic>? queryParameters}) => _mainUri(
    path: "dashboard/$path",
    queryParameters: queryParameters,
  );


  static Uri indexRecipes({Map<String, dynamic>? queryParameters}) =>
      _dashboardUri(path: 'recipe/index', queryParameters: queryParameters);

  static Uri addRecipe({Map<String, dynamic>? queryParameters}) =>
      _dashboardUri(path: 'recipe/store', queryParameters: queryParameters);

  static Uri updateRecipe({Map<String, dynamic>? queryParameters,required dynamic id}) =>
      _dashboardUri(path: 'recipe/$id/update', queryParameters: queryParameters);

  static Uri deleteRecipe({required int id,}) =>
      _dashboardUri(path: 'recipe/$id/destroy');


  static Uri acceptRecipe({required int id,}) =>
      _dashboardUri(path: 'recipe/$id/accept');


  static Uri disableRecipe({required int id,}) =>
      _dashboardUri(path: 'recipe/$id/unactive');


  static Uri indexCategories({Map<String, dynamic>? queryParameters}) =>
      _dashboardUri(path: 'category/index', queryParameters: queryParameters);

  static Uri addCategories({Map<String, dynamic>? queryParameters}) =>
      _dashboardUri(path: 'category/store', queryParameters: queryParameters);

  static Uri updateCategories({Map<String, dynamic>? queryParameters,required dynamic id}) =>
      _dashboardUri(path: 'category/$id/update', queryParameters: queryParameters);

  static Uri deleteCategories({required int id,}) =>
      _dashboardUri(path: 'category/$id/destroy');



  static Uri indexTypes({Map<String, dynamic>? queryParameters}) =>
      _dashboardUri(path: 'type/index', queryParameters: queryParameters);

  static Uri addTypes({Map<String, dynamic>? queryParameters}) =>
      _dashboardUri(path: 'type/store', queryParameters: queryParameters);

  static Uri updateTypes({Map<String, dynamic>? queryParameters,required dynamic id}) =>
      _dashboardUri(path: 'type/$id/update', queryParameters: queryParameters);

  static Uri deleteTypes({required int id,}) =>
      _dashboardUri(path: 'type/$id/destroy');




  static Uri indexIngredients({Map<String, dynamic>? queryParameters}) =>
      _dashboardUri(path: 'ingredient/index', queryParameters: queryParameters);

  static Uri addIngredients({Map<String, dynamic>? queryParameters}) =>
      _dashboardUri(path: 'ingredient/store', queryParameters: queryParameters);

  static Uri updateIngredients({Map<String, dynamic>? queryParameters,required dynamic id}) =>
      _dashboardUri(path: 'ingredient/$id/update', queryParameters: queryParameters);

  static Uri deleteIngredient({required int id,}) =>
      _dashboardUri(path: 'ingredient/$id/destroy');


  static Uri indexNutritional({Map<String, dynamic>? queryParameters}) =>
      _dashboardUri(path: 'nutritional/index', queryParameters: queryParameters);

  static Uri addNutritional({Map<String, dynamic>? queryParameters}) =>
      _dashboardUri(path: 'nutritional/store', queryParameters: queryParameters);

  static Uri updateNutritional({Map<String, dynamic>? queryParameters,required dynamic id}) =>
      _dashboardUri(path: 'nutritional/$id/update', queryParameters: queryParameters);

  static Uri deleteNutritional({required String id,}) =>
      _dashboardUri(path: 'nutritional/$id/destroy');



  static Uri indexUnitTypes({Map<String, dynamic>? queryParameters}) =>
      _dashboardUri(path: 'unit/index', queryParameters: queryParameters);



  static Uri indexCategoriesIngredient({Map<String, dynamic>? queryParameters}) =>
      _dashboardUri(path: 'categoryingredient/index', queryParameters: queryParameters);

  static Uri addCategoriesIngredient({Map<String, dynamic>? queryParameters}) =>
      _dashboardUri(path: 'categoryingredient/store', queryParameters: queryParameters);

  static Uri updateCategoriesIngredient({Map<String, dynamic>? queryParameters,required dynamic id}) =>
      _dashboardUri(path: 'categoryingredient/$id/update', queryParameters: queryParameters);

  static Uri deleteCategoriesIngredient({required int id,}) =>
      _dashboardUri(path: 'categoryingredient/$id/destroy');



  static Uri login({Map<String, dynamic>? queryParameters}) =>
      _dashboardUri(path: 'auth/login', queryParameters: queryParameters);

  static Uri saveNotification({Map<String, dynamic>? queryParameters}) =>
      _mainUri(path: 'notification/store', queryParameters: queryParameters);

}
