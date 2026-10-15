import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/networking/result_api.dart';
import 'package:shopping_app/features/home/domain/entities/product_response_entity.dart';
import 'package:shopping_app/features/home/domain/repo/home_repo_interface.dart';

@injectable
class GetAllProductUseCase {
  final HomeRepoInterface _repo;

  GetAllProductUseCase(this._repo);

  Future<ResultApi<ProductResponseEntity>> invoke({
    required int skip,
    int limit = 10,
  }) {
    return _repo.getallproduct(skip: skip, limit: limit);
  }
}
