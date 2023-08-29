import 'package:dartz/dartz.dart';
import 'package:mealmate_dashboard/core/error/failures.dart';
import 'package:mealmate_dashboard/core/usecase/usecase.dart';
import 'package:mealmate_dashboard/features/store/data/models/ingredient_model.dart';
import 'package:mealmate_dashboard/features/store/domain/repositories/store_repository.dart';

class AcceptRecipeUseCase implements UseCase<bool, AcceptRecipeParams> {
  final StoreRepository storeRepository;

  AcceptRecipeUseCase({required this.storeRepository});

  @override
  Future<Either<Failure, bool>> call(AcceptRecipeParams params) async {
    return storeRepository.acceptRecipe(params: params.getParams());
  }
}

class AcceptRecipeParams implements UseCaseParams {
  final int id;


  AcceptRecipeParams({
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
