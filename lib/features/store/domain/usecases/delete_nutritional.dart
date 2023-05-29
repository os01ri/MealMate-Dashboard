import 'package:dartz/dartz.dart';
import 'package:mealmate_dashboard/core/error/failures.dart';
import 'package:mealmate_dashboard/core/usecase/usecase.dart';
import 'package:mealmate_dashboard/features/store/data/models/ingredient_model.dart';
import 'package:mealmate_dashboard/features/store/domain/repositories/store_repository.dart';

class DeleteNutritionalUseCase implements UseCase<bool, DeleteNutritionalParams> {
  final StoreRepository storeRepository;

  DeleteNutritionalUseCase({required this.storeRepository});

  @override
  Future<Either<Failure, bool>> call(DeleteNutritionalParams params) async {
    return storeRepository.deleteNutritional(params: params.getParams());
  }
}

class DeleteNutritionalParams implements UseCaseParams {
  final String id;


  DeleteNutritionalParams({
    required this.id,

  });

  @override
  Map<String, dynamic> getParams() {
    return {
      "id": id.toString(),
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
