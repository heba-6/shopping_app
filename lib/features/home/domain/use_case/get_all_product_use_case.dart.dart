import 'package:shopping_app/features/home/domain/repo/home_repo_interface.dart';
@injectable
class GetAllProductUseCase.dart {
  final HomeRepoInterface_repo;
  GetAllProductUseCase(this._repo);
      Future<ResultApi<ProductResponseEntity>>invoke() async=>await_repo.getallproduct();

}