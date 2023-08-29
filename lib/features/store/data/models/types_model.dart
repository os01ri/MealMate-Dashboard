
import 'dart:convert';

class TypesModelResponse {
  final List<TypesModel>? data;

  TypesModelResponse({
    this.data,
  });

  TypesModelResponse copyWith({
    List<TypesModel>? data,
  }) =>
      TypesModelResponse(
        data: data ?? this.data,
      );

  factory TypesModelResponse.fromRawJson(String str) =>
      TypesModelResponse.fromJson(
        json.decode(
            '{"data":${json.encode((json.decode(str) as Map)['data'])}}'),
      );

  String toRawJson() => json.encode(toJson());

  factory TypesModelResponse.fromJson(Map<String, dynamic> json) =>
      TypesModelResponse(
        data: json["data"] == null
            ? []
            : List<TypesModel>.from(
                json["data"]!.map((x) => TypesModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class TypesModel {
  final int? id;
  final String? name;
  final String? url;

  TypesModel({this.id,
    this.name,
    this.url
  });

  TypesModel copyWith({
    int? id,
    String? name,
    String? url,

  }) =>
      TypesModel(
        id: id ?? this.id,
        name: name ?? this.name,
        url: url ?? this.url,
      );

  factory TypesModel.fromRawJson(String str) =>
      TypesModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TypesModel.fromJson(Map<String, dynamic> json) =>
      TypesModel(
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
