import 'package:dartz/dartz.dart';
import 'package:mealmate_dashboard/core/error/failures.dart';
import 'package:mealmate_dashboard/core/usecase/usecase.dart';
import 'package:mealmate_dashboard/features/store/data/models/ingredient_model.dart';
import 'package:mealmate_dashboard/features/store/data/models/unit_types_model.dart';
import 'package:mealmate_dashboard/features/store/domain/repositories/store_repository.dart';

class IndexUnitTypesUseCase implements UseCase<UnitTypesModelResponse, IndexUnitTypesParams> {
  final StoreRepository storeRepository;

  IndexUnitTypesUseCase({required this.storeRepository});

  @override
  Future<Either<Failure, UnitTypesModelResponse>> call(IndexUnitTypesParams params) async {
    return storeRepository.indexUnitTypes(params: params.getParams());
  }
}

class IndexUnitTypesParams implements UseCaseParams {
  final int? perPage;
  final int? page;

  IndexUnitTypesParams({
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
