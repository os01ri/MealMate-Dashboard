import 'package:dartz/dartz.dart';
import 'package:mealmate_dashboard/core/error/failures.dart';
import 'package:mealmate_dashboard/core/usecase/usecase.dart';
import 'package:mealmate_dashboard/features/store/data/models/ingredient_model.dart';
import 'package:mealmate_dashboard/features/store/domain/repositories/store_repository.dart';

class UpdateCategoriesUseCase implements UseCase<bool, UpdateCategoriesParams> {
  final StoreRepository storeRepository;

  UpdateCategoriesUseCase({required this.storeRepository});

  @override
  Future<Either<Failure, bool>> call(UpdateCategoriesParams params) async {
    return storeRepository.updateCategories(body: params.getBody());
  }
}

class UpdateCategoriesParams implements UseCaseParams {
  final Map<String,dynamic> body;

  UpdateCategoriesParams(
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
