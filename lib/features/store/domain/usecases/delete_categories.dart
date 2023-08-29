import 'package:dartz/dartz.dart';
import 'package:mealmate_dashboard/core/error/failures.dart';
import 'package:mealmate_dashboard/core/usecase/usecase.dart';
import 'package:mealmate_dashboard/features/store/data/models/ingredient_model.dart';
import 'package:mealmate_dashboard/features/store/domain/repositories/store_repository.dart';

class DeleteCategoriesUseCase implements UseCase<bool, DeleteCategoriesParams> {
  final StoreRepository storeRepository;

  DeleteCategoriesUseCase({required this.storeRepository});

  @override
  Future<Either<Failure, bool>> call(DeleteCategoriesParams params) async {
    return storeRepository.deleteCategories(params: params.getParams());
  }
}

class DeleteCategoriesParams implements UseCaseParams {
  final int id;


  DeleteCategoriesParams({
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
