import 'package:dartz/dartz.dart';
import 'package:mealmate_dashboard/core/error/failures.dart';
import 'package:mealmate_dashboard/core/usecase/usecase.dart';
import 'package:mealmate_dashboard/features/store/data/models/ingredient_model.dart';
import 'package:mealmate_dashboard/features/store/domain/repositories/store_repository.dart';

class UpdateTypesUseCase implements UseCase<bool, UpdateTypesParams> {
  final StoreRepository storeRepository;

  UpdateTypesUseCase({required this.storeRepository});

  @override
  Future<Either<Failure, bool>> call(UpdateTypesParams params) async {
    return storeRepository.updateTypes(body: params.getBody());
  }
}

class UpdateTypesParams implements UseCaseParams {
  final Map<String,dynamic> body;

  UpdateTypesParams(
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
