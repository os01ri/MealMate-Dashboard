import 'package:dartz/dartz.dart';
import 'package:mealmate_dashboard/core/error/failures.dart';
import 'package:mealmate_dashboard/core/usecase/usecase.dart';
import 'package:mealmate_dashboard/features/store/data/models/ingredient_model.dart';
import 'package:mealmate_dashboard/features/store/domain/repositories/store_repository.dart';

class IndexIngredientsUseCase implements UseCase<IngredientModelResponse, IndexIngredientsParams> {
  final StoreRepository storeRepository;

  IndexIngredientsUseCase({required this.storeRepository});

  @override
  Future<Either<Failure, IngredientModelResponse>> call(IndexIngredientsParams params) async {
    return storeRepository.indexIngredients(params: params.getParams());
  }
}

class IndexIngredientsParams implements UseCaseParams {
  final int? perPage;
  final int? page;
  final dynamic categoryId;

  IndexIngredientsParams({
    this.perPage,
    this.page,
    this.categoryId
  });

  @override
  Map<String, dynamic> getParams() {
    return {
      if (page != null) "page": page.toString(),
      if (perPage != null) "perPage": perPage.toString(),
      if (categoryId != null) "category_id": categoryId.toString(),
    };
  }

  @override
  Map<String, dynamic> getBody() => {};

  @override
  List<Object?> get props => [page, perPage];

  @override
  bool? get stringify => true;
}
