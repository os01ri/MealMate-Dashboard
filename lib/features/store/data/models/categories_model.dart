
import 'dart:convert';

class CategoriesModelResponse {
  final List<CategoriesModel>? data;

  CategoriesModelResponse({
    this.data,
  });

  CategoriesModelResponse copyWith({
    List<CategoriesModel>? data,
  }) =>
      CategoriesModelResponse(
        data: data ?? this.data,
      );

  factory CategoriesModelResponse.fromRawJson(String str) =>
      CategoriesModelResponse.fromJson(
        json.decode(
            '{"data":${json.encode((json.decode(str) as Map)['data'])}}'),
      );

  String toRawJson() => json.encode(toJson());

  factory CategoriesModelResponse.fromJson(Map<String, dynamic> json) =>
      CategoriesModelResponse(
        data: json["data"] == null
            ? []
            : List<CategoriesModel>.from(
                json["data"]!.map((x) => CategoriesModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class CategoriesModel {
  final int? id;
  final String? name;
  final String? url;

  CategoriesModel({this.id,
    this.name,
    this.url
  });

  CategoriesModel copyWith({
    int? id,
    String? name,
    String? url,

  }) =>
      CategoriesModel(
        id: id ?? this.id,
        name: name ?? this.name,
        url: url ?? this.url,
      );

  factory CategoriesModel.fromRawJson(String str) =>
      CategoriesModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CategoriesModel.fromJson(Map<String, dynamic> json) =>
      CategoriesModel(
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
