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

  ///Auth
  static Uri _auth({required String path}) {
    return _mainUri(path: 'admin/$path');
  }

  static Uri register() {
    return _auth(path: 'register');
  }
  static Uri login() {
    return _auth(path: 'login');
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


  static Uri indexIngredients({Map<String, dynamic>? queryParameters}) =>
      _dashboardUri(path: 'ingredient/index', queryParameters: queryParameters);

  static Uri addIngredients({Map<String, dynamic>? queryParameters}) =>
      _dashboardUri(path: 'ingredient/store', queryParameters: queryParameters);

  static Uri indexNutritional({Map<String, dynamic>? queryParameters}) =>
      _dashboardUri(path: 'nutritional/index', queryParameters: queryParameters);

  static Uri addNutritional({Map<String, dynamic>? queryParameters}) =>
      _dashboardUri(path: 'nutritional/store', queryParameters: queryParameters);

  static Uri deleteNutritional({required String id,}) =>
      _dashboardUri(path: 'nutritional/$id/destroy');
}
