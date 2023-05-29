import 'package:dartz/dartz.dart';
import 'package:mealmate_dashboard/core/error/failures.dart';
import 'package:mealmate_dashboard/core/unified_api/handling_exception_manager.dart';
import 'package:mealmate_dashboard/features/store/data/datasources/remote_store_datasource.dart';
import 'package:mealmate_dashboard/features/store/data/models/ingredient_model.dart';
import 'package:mealmate_dashboard/features/store/domain/repositories/store_repository.dart';

class StoreRepositoryImpl with HandlingExceptionManager implements StoreRepository {
  final _datasource = RemoteStoreDatasource();

  @override
  Future<Either<Failure, IngredientModelResponse>> indexIngredients({Map<String, dynamic>? params}) {
    return wrapHandling(
      tryCall: () async {
        final result = await _datasource.indexIngredients(params: params);
        return Right(result);
      },
    );
  }

  @override
  Future<Either<Failure, NutritionalModelResponse>> indexNutritional({Map<String, dynamic>? params}) {
    return wrapHandling(
      tryCall: () async {
        final result = await _datasource.indexNutritional(params: params);
        return Right(result);
      },
    );
  }



  @override
  Future<Either<Failure, IngredientModel>> showIngredient({required int id}) {
    // TODO: implement showIngredient
    throw UnimplementedError();
  }
}
