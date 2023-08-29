
import 'package:dartz/dartz.dart';
import 'package:mealmate_dashboard/core/error/failures.dart';
import 'package:mealmate_dashboard/core/unified_api/handling_exception_manager.dart';
import 'package:mealmate_dashboard/features/auth/data/datasources/remote_auth_datasource.dart';
import 'package:mealmate_dashboard/features/auth/data/models/login_response_model.dart';
import 'package:mealmate_dashboard/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl with HandlingExceptionManager implements AuthRepository {

  @override
  Future<Either<Failure, LoginResponseModel>> loginUser({required Map<String, dynamic> body}) async {
    return wrapHandling(tryCall: () async {
      final result = await RemoteAuthDataSource.loginUser(body: body);
      return Right(result);
    });
  }

}
