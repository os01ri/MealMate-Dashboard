
import 'dart:convert';

import 'package:mealmate_dashboard/features/store/data/models/recipe_model.dart';

class IngredientModelResponse {
  final List<IngredientModel>? data;

  IngredientModelResponse({
    this.data,
  });

  IngredientModelResponse copyWith({
    List<IngredientModel>? data,
  }) =>
      IngredientModelResponse(
        data: data ?? this.data,
      );

  factory IngredientModelResponse.fromRawJson(String str) =>
      IngredientModelResponse.fromJson(
        json.decode(
            '{"data":${json.encode((json.decode(str) as Map)['data'])}}'),
      );

  String toRawJson() => json.encode(toJson());

  factory IngredientModelResponse.fromJson(Map<String, dynamic> json) =>
      IngredientModelResponse(
        data: json["data"] == null
            ? []
            : List<IngredientModel>.from(
                json["data"]!.map((x) => IngredientModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class IngredientModel {
  final int? id;
  final String? name;
  final dynamic price;
  final dynamic priceById;
  final String? imageUrl;
  final List<Nutritional>? nutritionals;
  final RecipeIngredient? recipeIngredient;
  final String? ingredientUnitType;
  final String? ingredientUnitTypeId;
  final String? ingredientCategory;
  final String? ingredientCategoryId;
  IngredientModel(
      {this.id,
      this.name,
      this.nutritionals,
      this.price,
      this.imageUrl,
        this.ingredientUnitType,
        this.ingredientUnitTypeId,
        this.recipeIngredient,
        this.ingredientCategory,
        this.ingredientCategoryId,
      this.priceById});

  IngredientModel copyWith({
    int? id,
    String? name,
    List<Nutritional>? nutritionals,
    RecipeIngredient? recipeIngredient,
    dynamic price,
    dynamic priceById,
    String? url,
    String? ingredientUnitType,
    String? ingredientUnitTypeId,
    String? ingredientCategory,
    String? ingredientCategoryId,
  }) =>
      IngredientModel(
        id: id ?? this.id,
        name: name ?? this.name,
        nutritionals: nutritionals ?? this.nutritionals,
        recipeIngredient: recipeIngredient ?? this.recipeIngredient,
        price: price ?? this.price,
        priceById: priceById ?? this.priceById,
        imageUrl: url ?? this.imageUrl,
          ingredientUnitType: ingredientUnitType ?? this.ingredientUnitType,
          ingredientUnitTypeId: ingredientUnitTypeId ?? this.ingredientUnitTypeId,
          ingredientCategoryId: ingredientCategoryId ?? this.ingredientCategoryId,
          ingredientCategory: ingredientCategory ?? this.ingredientCategory
      );

  factory IngredientModel.fromRawJson(String str) =>
      IngredientModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory IngredientModel.fromJson(Map<String, dynamic> json) =>
      IngredientModel(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        priceById:json["unit"]==null?null: (json['price_by'].toString() + " " + json["unit"]['name'].toString()),
        imageUrl: json["url"],
        nutritionals: json["nutritionals"] == null
            ? []
            : List<Nutritional>.from(
            json["nutritionals"]!.map((x) => Nutritional.fromJson(x))),
        recipeIngredient: json["recipe_ingredient"] == null
            ? null
            : RecipeIngredient.fromJson(json["recipe_ingredient"]),
        ingredientUnitType:json["unit"]==null?"": json["unit"]['name'].toString(),
        ingredientUnitTypeId: json["unit"]==null?"": json["unit"]['id'].toString(),
        ingredientCategoryId:json["category1"]==null?"": json["category1"]['id'].toString(),
        ingredientCategory: json["category1"]==null?"": json["category1"]['name'].toString(),

      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "price_by": priceById,
        "url": imageUrl,
        "nutritionals": nutritionals == null
            ? []
            : List<dynamic>.from(nutritionals!.map((x) => x.toJson())),
    "recipe_ingredient": recipeIngredient == null
        ? null
        : recipeIngredient!.toJson(),
      };
}

class NutritionalModelResponse {
  final List<Nutritional>? data;

  NutritionalModelResponse({
    this.data,
  });

  NutritionalModelResponse copyWith({
    List<Nutritional>? data,
  }) =>
      NutritionalModelResponse(
        data: data ?? this.data,
      );

  factory NutritionalModelResponse.fromRawJson(String str) =>
      NutritionalModelResponse.fromJson(
        json.decode(
            '{"data":${json.encode((json.decode(str) as Map)['data'])}}'),
      );

  String toRawJson() => json.encode(toJson());

  factory NutritionalModelResponse.fromJson(Map<String, dynamic> json) =>
      NutritionalModelResponse(
        data: json["data"] == null
            ? []
            : List<Nutritional>.from(
                json["data"]!.map((x) => Nutritional.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Nutritional {
  final int? id;
  final String? name;
  final IngredientNutritionals? ingredientNutritionals;

  Nutritional({
    this.id,
    this.name,
    this.ingredientNutritionals,
  });

  Nutritional copyWith({
    int? id,
    String? name,
    IngredientNutritionals? ingredientNutritionals,
  }) =>
      Nutritional(
        id: id ?? this.id,
        name: name ?? this.name,
        ingredientNutritionals:
            ingredientNutritionals ?? this.ingredientNutritionals,
      );

  factory Nutritional.fromRawJson(String str) =>
      Nutritional.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Nutritional.fromJson(Map<String, dynamic> json) => Nutritional(
        id: json["id"],
        name: json["name"],
        ingredientNutritionals: json["ingredient_nutritionals"] == null
            ? null
            : IngredientNutritionals.fromJson(json["ingredient_nutritionals"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "ingredient_nutritionals": ingredientNutritionals?.toJson(),
      };
}

class IngredientNutritionals {
   double? value;
   int? id;
   double? percent;
   int? unitId;

  IngredientNutritionals({
    this.value,
    this.id,
    this.percent,
    this.unitId
  });

  IngredientNutritionals copyWith({
    double? value,
    int? id,
    double? percent,
    int? unitId
  }) =>
      IngredientNutritionals(
        value: value ?? this.value,
        id: id ?? this.id,
        percent: percent ?? this.percent,
        unitId: unitId ?? this.unitId,

      );

  factory IngredientNutritionals.fromRawJson(String str) =>
      IngredientNutritionals.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory IngredientNutritionals.fromJson(Map<String, dynamic> json) =>
      IngredientNutritionals(
        value: json["value"],
        percent: json["precent"],
        id: json["id"],
        unitId: json["unit_id"],
      );

  Map<String, dynamic> toJson() => {
    "value": value,
    "precent": percent,
    "id": id,
    "unit_id": unitId,
      };
}
