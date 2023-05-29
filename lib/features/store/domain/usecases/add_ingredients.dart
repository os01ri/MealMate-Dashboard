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


  AddIngredientsParams({
    required this.name,

  });

  @override
  Map<String, dynamic> getParams() {
    return {
      };
  }

  @override
  Map<String, dynamic> getBody() => {
    "name": name.toString(),
  };

  @override
  List<Object?> get props => [name];

  @override
  bool? get stringify => true;
}
