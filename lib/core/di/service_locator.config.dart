import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/di/service_locator.dart' as _i;
import 'package:shopping_app/core/network/network_module.dart' as _i2;
import 'package:shopping_app/features/account/data/data_source/account_data_source.dart'
    as _i3;
import 'package:shopping_app/features/account/data/repo/account_repo_impl.dart'
    as _i4;
import 'package:shopping_app/features/account/domain/repo/account_repo.dart'
    as _i5;
import 'package:shopping_app/features/account/domain/use_case/get_account_use_case.dart'
    as _i6;
import 'package:shopping_app/features/account/domain/use_case/update_account_use_case.dart'
    as _i7;
import 'package:shopping_app/features/auth/data/api/auth_api.dart' as _i8;
import 'package:shopping_app/features/auth/data/api/register_api.dart' as _i9;
import 'package:shopping_app/features/auth/data/data_source/auth_data_source_imp.dart'
    as _i10;
import 'package:shopping_app/features/auth/data/repo/auth_repo_imp.dart'
    as _i11;
import 'package:shopping_app/features/auth/data/repo/data_source/register_repo.dart'
    as _i12;
import 'package:shopping_app/features/auth/domain/repo/auth_repo.dart' as _i13;
import 'package:shopping_app/features/auth/domain/use_case/login_use_case.dart'
    as _i14;
import 'package:shopping_app/features/auth/domain/use_case/register_use_case.dart'
    as _i15;
import 'package:shopping_app/features/auth/presentation/view_model/login/login_cubit.dart'
    as _i16;
import 'package:shopping_app/features/auth/presentation/view_model/register/register_cubit.dart'
    as _i17;
import 'package:shopping_app/features/cart/data/api/cart_api.dart' as _i18;
import 'package:shopping_app/features/cart/data/data_source/cart_data_source_impl.dart'
    as _i19;
import 'package:shopping_app/features/cart/data/repo/cart_repo_impl.dart'
    as _i20;
import 'package:shopping_app/features/cart/domain/repo/cart_repo.dart' as _i21;
import 'package:shopping_app/features/cart/domain/use_case/add_cart_use_case.dart'
    as _i22;
import 'package:shopping_app/features/cart/domain/use_case/delete_cart_use_case.dart'
    as _i23;
import 'package:shopping_app/features/cart/domain/use_case/get_cart_use_case.dart'
    as _i24;
import 'package:shopping_app/features/cart/presentation/view_model/cart_cubit.dart'
    as _i25;
import 'package:shopping_app/features/favourite/data/repo/favourite_repo_impl.dart'
    as _i26;
import 'package:shopping_app/features/favourite/domain/repo/favourite_repo.dart'
    as _i27;
import 'package:shopping_app/features/favourite/domain/use_case/get_favourite_use_case.dart'
    as _i28;
import 'package:shopping_app/features/home/data/data_source/home_data_source_impl.dart'
    as _i29;
import 'package:shopping_app/features/home/data/repo/home_repo_impl.dart'
    as _i30;
import 'package:shopping_app/features/home/domain/repo/home_repo.dart' as _i31;
import 'package:shopping_app/features/home/domain/use_case/get_all_categories_use_case.dart'
    as _i32;
import 'package:shopping_app/features/home/domain/use_case/get_all_products_use_case.dart'
    as _i33;
import 'package:shopping_app/features/home/presentation/view_model/home_cubit.dart'
    as _i34;
import 'package:shopping_app/features/products_by_category/data/repo/products_by_category_repo_impl.dart'
    as _i35;
import 'package:shopping_app/features/products_by_category/domain/repo/products_by_category_repo.dart'
    as _i36;
import 'package:shopping_app/features/products_by_category/domain/use_case/get_products_by_category_use_case.dart'
    as _i37;
import 'package:shopping_app/features/products_by_category/presentation/view_model/products_by_category_cubit.dart'
    as _i38;
import 'package:dio/dio.dart' as _i39;

extension GetItInjectableX on _i.GetIt {
  _i.GetIt init({
    String? environment,
    EnvironmentFilter? environmentFilter,
  }) {
    final gh = GetItHelper(this, environment, environmentFilter);

    gh.lazySingleton<_i2.NetworkModule>(() => _i2.NetworkModule());
    gh.lazySingleton<_i39.Dio>(() => gh<_i2.NetworkModule>().dio);
    gh.lazySingleton<_i8.AuthApi>(() => _i8.AuthApi(gh<_i39.Dio>()));
    gh.lazySingleton<_i9.RegisterApi>(() => _i9.RegisterApi(gh<_i39.Dio>()));

    gh.lazySingleton<_i10.AuthDataSourceImp>(
      () => _i10.AuthDataSourceImp(gh<_i8.AuthApi>()),
    );

    gh.lazySingleton<_i11.AuthRepoImp>(
      () => _i11.AuthRepoImp(gh<_i10.AuthDataSourceImp>()),
    );

    gh.lazySingleton<_i12.RegisterRepo>(
      () => _i12.RegisterRepo(gh<_i9.RegisterApi>()),
    );

    gh.factory<_i17.RegisterCubit>(
      () => _i17.RegisterCubit(gh<_i12.RegisterRepo>()),
    );

    gh.factory<_i16.LoginCubit>(
      () => _i16.LoginCubit(gh<_i11.AuthRepoImp>()),
    );

    gh.lazySingleton<_i3.AccountDataSource>(
      () => _i3.AccountDataSource(gh<_i39.Dio>()),
    );

    gh.lazySingleton<_i4.AccountRepoImpl>(
      () => _i4.AccountRepoImpl(gh<_i3.AccountDataSource>()),
    );

    gh.lazySingleton<_i5.AccountRepo>(() => gh<_i4.AccountRepoImpl>());

    gh.lazySingleton<_i6.GetAccountUseCase>(
      () => _i6.GetAccountUseCase(gh<_i5.AccountRepo>()),
    );

    gh.lazySingleton<_i7.UpdateAccountUseCase>(
      () => _i7.UpdateAccountUseCase(gh<_i5.AccountRepo>()),
    );

    gh.lazySingleton<_i18.CartApi>(() => _i18.CartApi(gh<_i39.Dio>()));

    gh.lazySingleton<_i19.CartDataSourceImpl>(
      () => _i19.CartDataSourceImpl(gh<_i18.CartApi>()),
    );

    gh.lazySingleton<_i20.CartRepoImpl>(
      () => _i20.CartRepoImpl(gh<_i19.CartDataSourceImpl>()),
    );

    gh.lazySingleton<_i21.CartRepo>(() => gh<_i20.CartRepoImpl>());

    gh.lazySingleton<_i22.AddCartUseCase>(
      () => _i22.AddCartUseCase(gh<_i21.CartRepo>()),
    );

    gh.lazySingleton<_i23.DeleteCartUseCase>(
      () => _i23.DeleteCartUseCase(gh<_i21.CartRepo>()),
    );

    gh.lazySingleton<_i24.GetCartUseCase>(
      () => _i24.GetCartUseCase(gh<_i21.CartRepo>()),
    );

    gh.factory<_i25.CartCubit>(
      () => _i25.CartCubit(
        gh<_i22.AddCartUseCase>(),
        gh<_i23.DeleteCartUseCase>(),
        gh<_i24.GetCartUseCase>(),
      ),
    );

    gh.lazySingleton<_i26.FavouriteRepoImpl>(
      () => _i26.FavouriteRepoImpl(),
    );

    gh.lazySingleton<_i27.FavouriteRepo>(() => gh<_i26.FavouriteRepoImpl>());

    gh.lazySingleton<_i28.GetFavouriteUseCase>(
      () => _i28.GetFavouriteUseCase(gh<_i27.FavouriteRepo>()),
    );

    gh.lazySingleton<_i29.HomeDataSourceImpl>(
      () => _i29.HomeDataSourceImpl(gh<_i39.Dio>()),
    );

    gh.lazySingleton<_i30.HomeRepoImpl>(
      () => _i30.HomeRepoImpl(gh<_i29.HomeDataSourceImpl>()),
    );

    gh.lazySingleton<_i31.HomeRepo>(() => gh<_i30.HomeRepoImpl>());

    gh.lazySingleton<_i32.GetAllCategoriesUseCase>(
      () => _i32.GetAllCategoriesUseCase(gh<_i31.HomeRepo>()),
    );

    gh.lazySingleton<_i33.GetAllProductsUseCase>(
      () => _i33.GetAllProductsUseCase(gh<_i31.HomeRepo>()),
    );

    gh.factory<_i34.HomeCubit>(
      () => _i34.HomeCubit(
        gh<_i33.GetAllProductsUseCase>(),
        gh<_i32.GetAllCategoriesUseCase>(),
      ),
    );

    gh.lazySingleton<_i35.ProductsByCategoryRepoImpl>(
      () => _i35.ProductsByCategoryRepoImpl(),
    );

    gh.lazySingleton<_i36.ProductsByCategoryRepo>(
      () => gh<_i35.ProductsByCategoryRepoImpl>(),
    );

    gh.lazySingleton<_i37.GetProductsByCategoryUseCase>(
      () => _i37.GetProductsByCategoryUseCase(gh<_i36.ProductsByCategoryRepo>()),
    );

    gh.factory<_i38.ProductsByCategoryCubit>(
      () => _i38.ProductsByCategoryCubit(
        gh<_i37.GetProductsByCategoryUseCase>(),
      ),
    );

    return this;
  }
}