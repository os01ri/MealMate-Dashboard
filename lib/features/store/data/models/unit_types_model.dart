
import 'dart:convert';

class UnitTypesModelResponse {
  final List<UnitTypesModel>? data;

  UnitTypesModelResponse({
    this.data,
  });

  UnitTypesModelResponse copyWith({
    List<UnitTypesModel>? data,
  }) =>
      UnitTypesModelResponse(
        data: data ?? this.data,
      );

  factory UnitTypesModelResponse.fromRawJson(String str) =>
      UnitTypesModelResponse.fromJson(
        json.decode(
            '{"data":${json.encode((json.decode(str) as Map)['data'])}}'),
      );

  String toRawJson() => json.encode(toJson());

  factory UnitTypesModelResponse.fromJson(Map<String, dynamic> json) =>
      UnitTypesModelResponse(
        data: json["data"] == null
            ? []
            : List<UnitTypesModel>.from(
                json["data"]!.map((x) => UnitTypesModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class UnitTypesModel {
  final int? id;
  final String? name;
  final String? code;

  UnitTypesModel({this.id,
    this.name,
    this.code
  });

  UnitTypesModel copyWith({
    int? id,
    String? name,
    String? code,

  }) =>
      UnitTypesModel(
        id: id ?? this.id,
        name: name ?? this.name,
        code: code ?? this.code,
      );

  factory UnitTypesModel.fromRawJson(String str) =>
      UnitTypesModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UnitTypesModel.fromJson(Map<String, dynamic> json) =>
      UnitTypesModel(
        id: json["id"],
        name: json["name"],
        code: json["code"]
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "code": code,
      };
}
