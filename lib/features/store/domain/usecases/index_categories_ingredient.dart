import 'package:dartz/dartz.dart';
import 'package:mealmate_dashboard/core/error/failures.dart';
import 'package:mealmate_dashboard/core/usecase/usecase.dart';
import 'package:mealmate_dashboard/features/store/data/models/categories_ingredient.dart';
import 'package:mealmate_dashboard/features/store/data/models/ingredient_model.dart';
import 'package:mealmate_dashboard/features/store/data/models/unit_types_model.dart';
import 'package:mealmate_dashboard/features/store/domain/repositories/store_repository.dart';

class IndexCategoriesIngredientUseCase implements UseCase<CategoriesIngredientResponse, IndexCategoriesIngredientParams> {
  final StoreRepository storeRepository;

  IndexCategoriesIngredientUseCase({required this.storeRepository});

  @override
  Future<Either<Failure, CategoriesIngredientResponse>> call(IndexCategoriesIngredientParams params) async {
    return storeRepository.indexCategoriesIngredient(params: params.getParams());
  }
}

class IndexCategoriesIngredientParams implements UseCaseParams {
  final int? perPage;
  final int? page;

  IndexCategoriesIngredientParams({
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
