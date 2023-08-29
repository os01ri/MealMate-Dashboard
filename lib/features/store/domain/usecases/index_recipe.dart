import 'package:dartz/dartz.dart';
import 'package:mealmate_dashboard/core/error/failures.dart';
import 'package:mealmate_dashboard/core/usecase/usecase.dart';
import 'package:mealmate_dashboard/features/store/data/models/ingredient_model.dart';
import 'package:mealmate_dashboard/features/store/data/models/recipe_model.dart';
import 'package:mealmate_dashboard/features/store/domain/repositories/store_repository.dart';

class IndexRecipesUseCase implements UseCase<RecipeModelResponse, IndexRecipesParams> {
  final StoreRepository storeRepository;

  IndexRecipesUseCase({required this.storeRepository});

  @override
  Future<Either<Failure, RecipeModelResponse>> call(IndexRecipesParams params) async {
    return storeRepository.indexRecipes(params: params.getParams());
  }
}

class IndexRecipesParams implements UseCaseParams {
  final int? perPage;
  final int? page;

  IndexRecipesParams({
    this.perPage,
    this.page,
  });

  @override
  Map<String, dynamic> getParams() {
    return {
      if (page != null) "page": page.toString(),
      if (perPage != null) "perPage": perPage.toString(),
    };
  }

  @override
  Map<String, dynamic> getBody() => {};

  @override
  List<Object?> get props => [page, perPage];

  @override
  bool? get stringify => true;
}
