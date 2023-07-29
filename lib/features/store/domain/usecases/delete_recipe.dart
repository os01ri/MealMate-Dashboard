import 'package:dartz/dartz.dart';
import 'package:mealmate_dashboard/core/error/failures.dart';
import 'package:mealmate_dashboard/core/usecase/usecase.dart';
import 'package:mealmate_dashboard/features/store/data/models/ingredient_model.dart';
import 'package:mealmate_dashboard/features/store/domain/repositories/store_repository.dart';

class DeleteRecipeUseCase implements UseCase<bool, DeleteRecipeParams> {
  final StoreRepository storeRepository;

  DeleteRecipeUseCase({required this.storeRepository});

  @override
  Future<Either<Failure, bool>> call(DeleteRecipeParams params) async {
    return storeRepository.deleteRecipe(params: params.getParams());
  }
}

class DeleteRecipeParams implements UseCaseParams {
  final int id;


  DeleteRecipeParams({
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
