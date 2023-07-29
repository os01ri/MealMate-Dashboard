
import 'dart:convert';

class CategoriesIngredientResponse {
  final List<CategoriesIngredientModel>? data;

  CategoriesIngredientResponse({
    this.data,
  });

  CategoriesIngredientResponse copyWith({
    List<CategoriesIngredientModel>? data,
  }) =>
      CategoriesIngredientResponse(
        data: data ?? this.data,
      );

  factory CategoriesIngredientResponse.fromRawJson(String str) =>
      CategoriesIngredientResponse.fromJson(
        json.decode(
            '{"data":${json.encode((json.decode(str) as Map)['data']['categories'])}}'),
      );

  String toRawJson() => json.encode(toJson());

  factory CategoriesIngredientResponse.fromJson(Map<String, dynamic> json) =>
      CategoriesIngredientResponse(
        data: json["data"] == null
            ? []
            : List<CategoriesIngredientModel>.from(
                json["data"]!.map((x) => CategoriesIngredientModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class CategoriesIngredientModel {
  final int? id;
  final String? name;
  final String? url;

  CategoriesIngredientModel({this.id,
    this.name,
    this.url
  });

  CategoriesIngredientModel copyWith({
    int? id,
    String? name,
    String? url,

  }) =>
      CategoriesIngredientModel(
        id: id ?? this.id,
        name: name ?? this.name,
        url: url ?? this.url,
      );

  factory CategoriesIngredientModel.fromRawJson(String str) =>
      CategoriesIngredientModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CategoriesIngredientModel.fromJson(Map<String, dynamic> json) =>
      CategoriesIngredientModel(
        id: json["id"],
        name: json["name"],
        url: json["url"]
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "url": url,
      };
}
