import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/networking/result_api.dart';
import 'package:shopping_app/features/home/domain/entities/category_entity.dart';
import 'package:shopping_app/features/home/domain/repo/home_repo_interface.dart';

@injectable
class GetAllCategoriesUseCase {
  final HomeRepoInterface _homeRepo;

  GetAllCategoriesUseCase(this._homeRepo);

  Future<ResultApi<List<CategoryEntity>>> invoke() {
    return _homeRepo.getAllCategories();
  }
}
