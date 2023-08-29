import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:mealmate_dashboard/core/error/failures.dart';


abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

abstract class UseCaseParams extends Equatable {
  Map<String, dynamic> getBody() => {};

  Map<String, dynamic> getParams() => {};

  @override
  List<Object?> get props => [];
}

class NoParams implements UseCaseParams {
  @override
  Map<String, dynamic> getBody() => {};

  @override
  Map<String, dynamic> getParams() => {};

  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => false;
}
