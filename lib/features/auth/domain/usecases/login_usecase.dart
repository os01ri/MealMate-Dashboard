import 'package:dartz/dartz.dart';
import 'package:mealmate_dashboard/core/error/failures.dart';
import 'package:mealmate_dashboard/core/usecase/usecase.dart';
import 'package:mealmate_dashboard/features/auth/data/models/login_response_model.dart';
import 'package:mealmate_dashboard/features/auth/domain/repositories/auth_repository.dart';


class LoginUseCase implements UseCase<LoginResponseModel, LoginUserParams> {
  final AuthRepository repository;

  LoginUseCase({required this.repository});

  @override
  Future<Either<Failure, LoginResponseModel>> call(LoginUserParams body) async {
    return repository.loginUser(body: body.getBody());
  }
}

class LoginUserParams implements UseCaseParams {
  final String email;
  final String password;

  LoginUserParams({
    required this.email,
    required this.password,
  });

  @override
  Map<String, dynamic> getBody() => {"password": password, "username": email};

  @override
  Map<String, dynamic> getParams() => {};

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

  @override
  // TODO: implement stringify
  bool? get stringify => throw UnimplementedError();
}
