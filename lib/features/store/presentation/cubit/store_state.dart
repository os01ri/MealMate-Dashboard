// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'store_cubit.dart';

class StoreState {
  final CubitStatus status;
  final List<IngredientModel> ingredients;
  final List<Nutritional> nutritional;
  final List<CategoriesIngredientModel> categories;
  final List<UnitTypesModel> unitTypes;
  const StoreState({
    this.status = CubitStatus.initial,
    this.ingredients = const [],
    this.nutritional = const [],
    this.categories = const [],
    this.unitTypes = const [],
  });

  StoreState copyWith({
    CubitStatus? status,
    List<IngredientModel>? ingredients,
    List<Nutritional>? nutritional,
    List<CategoriesIngredientModel>? categories,
    List<UnitTypesModel>? unitTypes,
  }) {
    return StoreState(
      status: status ?? this.status,
      ingredients: ingredients ?? this.ingredients,
      nutritional: nutritional ?? this.nutritional,
      categories: categories ?? this.categories,
      unitTypes: unitTypes ?? this.unitTypes,
    );
  }
}
