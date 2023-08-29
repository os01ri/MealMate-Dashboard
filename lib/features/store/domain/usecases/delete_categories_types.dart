import 'package:dartz/dartz.dart';
import 'package:mealmate_dashboard/core/error/failures.dart';
import 'package:mealmate_dashboard/core/usecase/usecase.dart';
import 'package:mealmate_dashboard/features/store/data/models/ingredient_model.dart';
import 'package:mealmate_dashboard/features/store/domain/repositories/store_repository.dart';

class DeleteCategoriesIngredientUseCase implements UseCase<bool, DeleteCategoriesIngredientParams> {
  final StoreRepository storeRepository;

  DeleteCategoriesIngredientUseCase({required this.storeRepository});

  @override
  Future<Either<Failure, bool>> call(DeleteCategoriesIngredientParams params) async {
    return storeRepository.deleteCategoriesIngredient(params: params.getParams());
  }
}

class DeleteCategoriesIngredientParams implements UseCaseParams {
  final int id;


  DeleteCategoriesIngredientParams({
    required this.id,

  });

  @override
  Map<String, dynamic> getParams() {
    return {
      "id": id,
    };
  }

  @override
  Map<String, dynamic> getBody() => {
  };

  @override
  List<Object?> get props => [id];

  @override
  bool? get stringify => true;
}
