import 'package:dartz/dartz.dart';
import 'package:mealmate_dashboard/core/error/failures.dart';
import 'package:mealmate_dashboard/core/usecase/usecase.dart';
import 'package:mealmate_dashboard/features/store/data/models/ingredient_model.dart';
import 'package:mealmate_dashboard/features/store/domain/repositories/store_repository.dart';

class AddRecipesUseCase implements UseCase<bool, AddRecipeParams> {
  final StoreRepository storeRepository;

  AddRecipesUseCase({required this.storeRepository});

  @override
  Future<Either<Failure, bool>> call(AddRecipeParams params) async {
    return storeRepository.addRecipe(body: params.getBody());
  }
}

class AddRecipeParams implements UseCaseParams {
  final String name;
  final String imageUrl;
  final double price;
  final double priceBy;
  final int priceUnitId;
  final int categoryId;
  final List<IngredientNutritionals> ingredientNutritionals;

  AddRecipeParams(
      {
        required this.name,
        required this.imageUrl,
        required this.price,
        required this.priceBy,
        required this.priceUnitId,
        required this.categoryId,
        required this.ingredientNutritionals
      });


  @override
  Map<String, dynamic> getParams() {
    return {
      };
  }

  @override
  Map<String, dynamic> getBody() => {
    "name": name,
    "price": price,
    "unit_id": priceUnitId,
    "price_by": priceBy,
    "category_id": categoryId,
    "url": imageUrl,
    "nutritional":[
      ...ingredientNutritionals.map((e) => e.toJson())
    ]
  };

  @override
  List<Object?> get props => [name];

  @override
  bool? get stringify => true;
}
