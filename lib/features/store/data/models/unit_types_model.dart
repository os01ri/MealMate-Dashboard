// import 'dart:convert';

// import 'package:mealmate_dashboard/features/store/domain/entities/ingredient.dart';

// class IngredientModel extends Ingredient {
//   IngredientModel({
//     final String? name,
//     final double? price,
//     final String? imageUrl,
//   }) : super(
//           name: name,
//           price: price,
//           imageUrl: imageUrl,
//         );

//   IngredientModel copyWith({
//     String? name,
//     double? price,
//     String? imageUrl,
//   }) {
//     return IngredientModel(
//       name: name ?? this.name,
//       price: price ?? this.price,
//       imageUrl: imageUrl ?? this.imageUrl,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'name': name,
//       'price': price,
//       'imageUrl': imageUrl,
//     };
//   }

//   factory IngredientModel.fromMap(Map<String, dynamic> map) {
//     return IngredientModel(
//       name: map['name'] != null ? map['name'] as String : null,
//       price: map['price'] != null ? map['price'] as double : null,
//       imageUrl: map['imageUrl'] != null ? map['imageUrl'] as String : null,
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory IngredientModel.fromJson(String source) =>
//       IngredientModel.fromMap(json.decode(source) as Map<String, dynamic>);

//   @override
//   String toString() => 'IngredientModel(name: $name, price: $price, imageUrl: $imageUrl)';

//   @override
//   bool operator ==(covariant IngredientModel other) {
//     if (identical(this, other)) return true;

//     return other.name == name && other.price == price && other.imageUrl == imageUrl;
//   }

//   @override
//   int get hashCode => name.hashCode ^ price.hashCode ^ imageUrl.hashCode;
// }

// To parse this JSON data, do
//
//     final ingredientModel = ingredientModelFromJson(jsonString);

// To parse this JSON data, do
//
//     final ingredientModelResponse = ingredientModelResponseFromJson(jsonString);

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
