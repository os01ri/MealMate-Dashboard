// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'store_cubit.dart';

class StoreState {
  final CubitStatus status;
  final List<IngredientModel> ingredients;
  final List<Nutritional> nutritional;
  const StoreState({
    this.status = CubitStatus.initial,
    this.ingredients = const [],
    this.nutritional = const []
  });

  StoreState copyWith({
    CubitStatus? status,
    List<IngredientModel>? ingredients,
    List<Nutritional>? nutritional,
  }) {
    return StoreState(
      status: status ?? this.status,
      ingredients: ingredients ?? this.ingredients,
      nutritional: nutritional ?? this.nutritional,
    );
  }
}
