import 'package:dartz/dartz.dart';
import 'package:mealmate_dashboard/core/error/failures.dart';
import 'package:mealmate_dashboard/core/usecase/usecase.dart';
import 'package:mealmate_dashboard/features/store/data/models/ingredient_model.dart';
import 'package:mealmate_dashboard/features/store/domain/repositories/store_repository.dart';

class UpdateCategoriesIngredientsUseCase implements UseCase<bool, UpdateCategoriesIngredientsParams> {
  final StoreRepository storeRepository;

  UpdateCategoriesIngredientsUseCase({required this.storeRepository});

  @override
  Future<Either<Failure, bool>> call(UpdateCategoriesIngredientsParams params) async {
    return storeRepository.updateCategoriesIngredient(body: params.getBody());
  }
}

class UpdateCategoriesIngredientsParams implements UseCaseParams {
  final Map<String,dynamic> body;

  UpdateCategoriesIngredientsParams(
      {
        required this.body,

      });


  @override
  Map<String, dynamic> getParams() {
    return {
      };
  }

  @override
  Map<String, dynamic> getBody() => body;

  @override
  List<Object?> get props => [body];

  @override
  bool? get stringify => true;
}
