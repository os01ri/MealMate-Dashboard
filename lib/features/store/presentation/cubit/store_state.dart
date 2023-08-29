// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'store_cubit.dart';

class StoreState {
  final CubitStatus status;
  final List<IngredientModel> ingredients;
  final List<Nutritional> nutritional;
  final List<CategoriesIngredientModel> categoriesIngredients;
  final List<UnitTypesModel> unitTypes;
  final List<RecipeModel> recipes;
  final List<CategoriesModel> categories;
  final List<TypesModel> types;

  const StoreState({
    this.status = CubitStatus.initial,
    this.ingredients = const [],
    this.nutritional = const [],
    this.categoriesIngredients = const [],
    this.unitTypes = const [],
    this.recipes = const [],
    this.types = const [],
    this.categories = const [],
  });

  StoreState copyWith({
    CubitStatus? status,
    List<IngredientModel>? ingredients,
    List<Nutritional>? nutritional,
    List<CategoriesIngredientModel>? categoriesIngredients,
    List<UnitTypesModel>? unitTypes,
    List<RecipeModel>? recipes,
    List<CategoriesModel>? categories,
    List<TypesModel>? types,
  }) {
    return StoreState(
      status: status ?? this.status,
      ingredients: ingredients ?? this.ingredients,
      nutritional: nutritional ?? this.nutritional,
      categoriesIngredients: categoriesIngredients ?? this.categoriesIngredients,
      unitTypes: unitTypes ?? this.unitTypes,
      recipes: recipes ?? this.recipes,
      categories: categories ?? this.categories,
      types: types ?? this.types,
    );
  }
}
