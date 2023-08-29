import 'package:dartz/dartz.dart';
import 'package:mealmate_dashboard/core/error/failures.dart';
import 'package:mealmate_dashboard/core/usecase/usecase.dart';
import 'package:mealmate_dashboard/features/store/data/models/ingredient_model.dart';
import 'package:mealmate_dashboard/features/store/domain/repositories/store_repository.dart';

class SaveNotificationUseCase implements UseCase<bool, SaveNotificationParams> {
  final StoreRepository storeRepository;

  SaveNotificationUseCase({required this.storeRepository});

  @override
  Future<Either<Failure, bool>> call(SaveNotificationParams params) async {
    return storeRepository.saveNotification(body: params.getBody());
  }
}

class SaveNotificationParams implements UseCaseParams {
  final String title;
  final String body;

  SaveNotificationParams(
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
  Map<String, dynamic> getBody() => {
    "title": title,
    "body": body,
  };

  @override
  List<Object?> get props => [title,body];

  @override
  bool? get stringify => true;
}
