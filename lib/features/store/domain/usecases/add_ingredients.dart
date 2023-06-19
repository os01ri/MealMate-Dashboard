import 'package:dartz/dartz.dart';
import 'package:mealmate_dashboard/core/error/failures.dart';
import 'package:mealmate_dashboard/core/usecase/usecase.dart';
import 'package:mealmate_dashboard/features/store/data/models/ingredient_model.dart';
import 'package:mealmate_dashboard/features/store/domain/repositories/store_repository.dart';

class AddIngredientsUseCase implements UseCase<bool, AddIngredientsParams> {
  final StoreRepository storeRepository;

  AddIngredientsUseCase({required this.storeRepository});

  @override
  Future<Either<Failure, bool>> call(AddIngredientsParams params) async {
    return storeRepository.addIngredients(body: params.getBody());
  }
}

class AddIngredientsParams implements UseCaseParams {
  final String name;
  final String imageUrl;
  final double price;
  final int priceById;
  final int priceUnitId;
  final String categoryId;
  final List<IngredientNutritionals> ingredientNutritionals;

  AddIngredientsParams(
      {
        required this.name,
        required this.imageUrl,
        required this.price,
        required this.priceById,
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
    "price_by": priceById,
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
