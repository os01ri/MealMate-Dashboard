import 'package:dartz/dartz.dart';
import 'package:mealmate_dashboard/core/error/failures.dart';
import 'package:mealmate_dashboard/core/usecase/usecase.dart';
import 'package:mealmate_dashboard/features/store/data/models/ingredient_model.dart';
import 'package:mealmate_dashboard/features/store/domain/repositories/store_repository.dart';

class AddCategoriesIngredientUseCase implements UseCase<bool, AddCategoriesIngredientParams> {
  final StoreRepository storeRepository;

  AddCategoriesIngredientUseCase({required this.storeRepository});

  @override
  Future<Either<Failure, bool>> call(AddCategoriesIngredientParams params) async {
    return storeRepository.addCategoriesIngredient(body: params.getBody());
  }
}

class AddCategoriesIngredientParams implements UseCaseParams {
  final String name;
  final String imageUrl;

  AddCategoriesIngredientParams(
      {
        required this.name,
        required this.imageUrl,

      });


  @override
  Map<String, dynamic> getParams() {
    return {
      };
  }

  @override
  Map<String, dynamic> getBody() => {
    "name": name,
    "url": imageUrl,
  };

  @override
  List<Object?> get props => [name,imageUrl];

  @override
  bool? get stringify => true;
}
