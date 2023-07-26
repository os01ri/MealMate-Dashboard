import 'dart:async';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:mealmate_dashboard/core/helper/helper_functions.dart';
import 'package:mealmate_dashboard/main.dart';

import '../error/exceptions.dart';
import '../error/failures.dart';

mixin HandlingExceptionManager {
  Future<Either<Failure, T>> wrapHandling<T>(
      {required Future<Right<Failure, T>> Function() tryCall}) async {
    try {
      final right = await tryCall();
      return right;
    } on UnauthenticatedException catch (e) {
      log("<<UnauthenticatedException>>");
      if(navigatorKey.currentState!=null)
      HelperFunctions.logout();

      return Left(UnauthenticatedFailure(e.message));
    } on ValidationException catch (e) {
      log("<<validateRegister>>");
      return Left(ValidationFailure(e.message));
    } on ServerException catch (e) {
      log("<< ServerException >> ");
      return Left(ServerFailure(e.message));
    } catch (e) {
      log("<< catch >> error is $e");
      return const Left(ServerFailure('something went wrong'));
    }
  }
}
