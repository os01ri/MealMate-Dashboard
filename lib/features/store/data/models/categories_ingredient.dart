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
            '{"data":${json.encode((json.decode(str) as Map)['data'])}}'),
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
