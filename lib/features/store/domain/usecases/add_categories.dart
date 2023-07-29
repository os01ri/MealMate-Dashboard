import 'package:dartz/dartz.dart';
import 'package:mealmate_dashboard/core/error/failures.dart';
import 'package:mealmate_dashboard/core/usecase/usecase.dart';
import 'package:mealmate_dashboard/features/store/data/models/ingredient_model.dart';
import 'package:mealmate_dashboard/features/store/domain/repositories/store_repository.dart';

class AddCategoriesUseCase implements UseCase<bool, AddCategoriesParams> {
  final StoreRepository storeRepository;

  AddCategoriesUseCase({required this.storeRepository});

  @override
  Future<Either<Failure, bool>> call(AddCategoriesParams params) async {
    return storeRepository.addCategories(body: params.getBody());
  }
}

class AddCategoriesParams implements UseCaseParams {
  final String name;
  final String imageUrl;

  AddCategoriesParams(
      {
        required this.name,
        required this.imageUrl,

      });


  @override
  Map<String, dynamic> getParams() {
    return {
      };
  }

  @override
  Map<String, dynamic> getBody() => {
    "name": name,
    "url": imageUrl,
  };

  @override
  List<Object?> get props => [name,imageUrl];

  @override
  bool? get stringify => true;
}
