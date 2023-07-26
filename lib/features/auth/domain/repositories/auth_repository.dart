import 'package:dartz/dartz.dart';
import 'package:mealmate_dashboard/core/error/failures.dart';
import 'package:mealmate_dashboard/features/auth/data/models/login_response_model.dart';

abstract class AuthRepository {

  Future<Either<Failure, LoginResponseModel>> loginUser({required Map<String, dynamic> body});

}
