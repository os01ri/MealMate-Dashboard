import 'package:dartz/dartz.dart';
import 'package:mealmate_dashboard/core/error/failures.dart';
import 'package:mealmate_dashboard/core/usecase/usecase.dart';
import 'package:mealmate_dashboard/features/store/data/models/ingredient_model.dart';
import 'package:mealmate_dashboard/features/store/domain/repositories/store_repository.dart';

class UpdateNutritionalUseCase implements UseCase<bool, UpdateNutritionalParams> {
  final StoreRepository storeRepository;

  UpdateNutritionalUseCase({required this.storeRepository});

  @override
  Future<Either<Failure, bool>> call(UpdateNutritionalParams params) async {
    return storeRepository.updateNutritional(body: params.getBody());
  }
}

class UpdateNutritionalParams implements UseCaseParams {
  final Map<String,dynamic> body;

  UpdateNutritionalParams(
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
