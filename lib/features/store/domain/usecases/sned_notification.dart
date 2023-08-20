import 'package:dartz/dartz.dart';
import 'package:mealmate_dashboard/core/error/failures.dart';
import 'package:mealmate_dashboard/core/usecase/usecase.dart';
import 'package:mealmate_dashboard/features/store/data/models/ingredient_model.dart';
import 'package:mealmate_dashboard/features/store/domain/repositories/store_repository.dart';

class SendNotificationUseCase implements UseCase<bool, SendNotificationParams> {
  final StoreRepository storeRepository;

  SendNotificationUseCase({required this.storeRepository});

  @override
  Future<Either<Failure, bool>> call(SendNotificationParams params) async {
    return storeRepository.sendNotification(body: params.getBody());
  }
}

class SendNotificationParams implements UseCaseParams {
  final String title;
  final String body;

  SendNotificationParams(
      {
        required this.title,
        required this.body,

      });


  @override
  Map<String, dynamic> getParams() {
    return {
      };
  }

  @override
  Map<String, dynamic> getBody() =>{
    "to": "/topics/all",
    "notification": {
      "title": title,
      "body": body
    }
  };

  @override
  List<Object?> get props => [title,body];

  @override
  bool? get stringify => true;
}
