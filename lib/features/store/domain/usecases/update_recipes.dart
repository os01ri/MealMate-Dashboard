import 'package:dartz/dartz.dart';
import 'package:mealmate_dashboard/core/error/failures.dart';
import 'package:mealmate_dashboard/core/usecase/usecase.dart';
import 'package:mealmate_dashboard/features/store/data/models/ingredient_model.dart';
import 'package:mealmate_dashboard/features/store/domain/repositories/store_repository.dart';

class UpdateRecipesUseCase implements UseCase<bool, UpdateRecipesParams> {
  final StoreRepository storeRepository;

  UpdateRecipesUseCase({required this.storeRepository});

  @override
  Future<Either<Failure, bool>> call(UpdateRecipesParams params) async {
    return storeRepository.updateRecipe(body: params.getBody());
  }
}

class UpdateRecipesParams implements UseCaseParams {
  final Map<String,dynamic> body;

  UpdateRecipesParams(
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
