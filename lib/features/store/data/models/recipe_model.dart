import 'dart:convert';
import 'package:mealmate_dashboard/features/store/data/models/categories_ingredient.dart';
import 'package:mealmate_dashboard/features/store/data/models/ingredient_model.dart';

class RecipeModelResponse {
  final List<RecipeModel>? data;

  RecipeModelResponse({
    this.data,
  });

  RecipeModelResponse copyWith({
    List<RecipeModel>? data,
  }) =>
      RecipeModelResponse(
        data: data ?? this.data,
      );

  factory RecipeModelResponse.fromRawJson(String str) =>
      RecipeModelResponse.fromJson(
        json.decode(
            '{"data":${json.encode((json.decode(str) as Map)['data'])}}'),
      );

  String toRawJson() => json.encode(toJson());

  factory RecipeModelResponse.fromJson(Map<String, dynamic> json) =>
      RecipeModelResponse(
        data: json["data"] == null
            ? []
            : List<RecipeModel>.from(
            json["data"]!.map((x) => RecipeModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "data": data == null
        ? []
        : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}


class RecipeModel {
  dynamic id;
  dynamic name;
  dynamic description;
  dynamic time;
  dynamic url;
  dynamic feeds;
  dynamic hash;
  dynamic status;
  dynamic userId;
  CategoriesIngredientModel? type;
  CategoriesIngredientModel? category;
  List<IngredientModel>? ingredients;
  List<Steps>? steps;

  RecipeModel(
      {this.id,
        this.name,
        this.description,
        this.time,
        this.url,
        this.feeds,
        this.hash,
        this.status,
        this.userId,
        this.type,
        this.category,
        this.ingredients,
        this.steps});

  RecipeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    time = json['time'];
    url = json['url'];
    feeds = json['feeds'];
    hash = json['hash'];
    status = json['status'];
    userId = json['user_id'];
    type = json['type'] != null ? new CategoriesIngredientModel.fromJson(json['type']) : null;
    category =
    json['category'] != null ? new CategoriesIngredientModel.fromJson(json['category']) : null;
    if (json['ingredients'] != null) {
      ingredients = <IngredientModel>[];
      json['ingredients'].forEach((v) {
        ingredients!.add(new IngredientModel.fromJson(v));
      });
    }
    if (json['steps'] != null) {
      steps = <Steps>[];
      json['steps'].forEach((v) {
        steps!.add(new Steps.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['time'] = this.time;
    data['url'] = this.url;
    data['feeds'] = this.feeds;
    data['hash'] = this.hash;
    data['status'] = this.status;
    data['user_id'] = this.userId;
    if (this.type != null) {
      data['type'] = this.type!.toJson();
    }
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    if (this.ingredients != null) {
      data['ingredients'] = this.ingredients!.map((v) => v.toJson()).toList();
    }
    if (this.steps != null) {
      data['steps'] = this.steps!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}



class RecipeIngredient {
  dynamic id;
  dynamic recipeId;
  dynamic ingredientId;
  dynamic quantity;
  dynamic unitId;
  dynamic unitName;

  RecipeIngredient(
      {this.id, this.recipeId, this.ingredientId, this.quantity, this.unitId,this.unitName});

  RecipeIngredient.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    recipeId = json['recipe_id'];
    ingredientId = json['ingredient_id'];
    quantity = json['quantity'];
    unitId = json['unit_id'];
    unitName = json['unit_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['recipe_id'] = this.recipeId;
    data['ingredient_id'] = this.ingredientId;
    data['quantity'] = this.quantity;
    data['unit_id'] = this.unitId;
    return data;
  }
}

class Steps {
  dynamic id;
  dynamic name;
  dynamic rank;
  dynamic description;

  Steps({this.id, this.name, this.rank, this.description});

  Steps.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    rank = json['rank'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['rank'] = this.rank;
    data['description'] = this.description;
    return data;
  }
}
