import 'package:dartz/dartz.dart';
import 'package:mealmate_dashboard/core/error/failures.dart';
import 'package:mealmate_dashboard/core/usecase/usecase.dart';
import 'package:mealmate_dashboard/features/store/data/models/ingredient_model.dart';
import 'package:mealmate_dashboard/features/store/domain/repositories/store_repository.dart';

class IndexNutritionalUseCase implements UseCase<NutritionalModelResponse, IndexNutritionalParams> {
  final StoreRepository storeRepository;

  IndexNutritionalUseCase({required this.storeRepository});

  @override
  Future<Either<Failure, NutritionalModelResponse>> call(IndexNutritionalParams params) async {
    return storeRepository.indexNutritional(params: params.getParams());
  }
}

class IndexNutritionalParams implements UseCaseParams {
  final int? perPage;
  final int? page;

  IndexNutritionalParams({
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
