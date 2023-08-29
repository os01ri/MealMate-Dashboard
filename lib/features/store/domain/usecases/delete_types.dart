import 'package:dartz/dartz.dart';
import 'package:mealmate_dashboard/core/error/failures.dart';
import 'package:mealmate_dashboard/core/usecase/usecase.dart';
import 'package:mealmate_dashboard/features/store/data/models/ingredient_model.dart';
import 'package:mealmate_dashboard/features/store/domain/repositories/store_repository.dart';

class DeleteTypesUseCase implements UseCase<bool, DeleteTypesParams> {
  final StoreRepository storeRepository;

  DeleteTypesUseCase({required this.storeRepository});

  @override
  Future<Either<Failure, bool>> call(DeleteTypesParams params) async {
    return storeRepository.deleteTypes(params: params.getParams());
  }
}

class DeleteTypesParams implements UseCaseParams {
  final int id;


  DeleteTypesParams({
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
