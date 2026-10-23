// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:dio/dio.dart' as _i361;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/auth/data/api/auth_api.dart' as _i302;
import '../../features/auth/data/api/register_api.dart' as _i403;
import '../../features/auth/data/repo/data_source/auth_data_source_imp.dart'
    as _i477;
import '../../features/auth/data/repo/data_source/register_repo.dart' as _i395;
import '../../features/auth/data/repo/repo/auth_repo_imp.dart' as _i909;
import '../../features/auth/domain/repo/auth_data_source_interface.dart'
    as _i701;
import '../../features/auth/domain/repo/auth_repo_interface.dart' as _i389;
import '../../features/auth/presentation/view_model/register/register_cubit.dart'
    as _i70;
import '../../features/favourite/data/api/favourite_api.dart' as _i491;
import '../../features/favourite/data/repo/data_source/favourite_data_source_imp.dart'
    as _i384;
import '../../features/favourite/data/repo/repo/favourite_repo_imp.dart'
    as _i149;
import '../../features/favourite/domain/repo/favourite_data_source_interface.dart'
    as _i215;
import '../../features/favourite/domain/repo/favourite_repo_interface.dart'
    as _i171;
import '../../features/favourite/domain/use_case/add_to_favourite_use_case.dart'
    as _i999;
import '../../features/favourite/domain/use_case/get_favourites_use_case.dart'
    as _i474;
import '../../features/favourite/domain/use_case/remove_favourite_use_case.dart'
    as _i495;
import '../../features/favourite/presentation/view_model/favourite_cubit.dart'
    as _i640;
import '../../features/home/data/api/api.dart' as _i168;
import '../../features/home/data/repo/data_source/home_data_source_imp.dart'
    as _i879;
import '../../features/home/data/repo/repo/home_repo_imp.dart' as _i1000;
import '../../features/home/domain/repo/home_data_source_interface.dart'
    as _i273;
import '../../features/home/domain/repo/home_repo_interface.dart' as _i1027;
import '../../features/home/domain/use_case/get_all_categories_use_case.dart'
    as _i843;
import '../../features/home/domain/use_case/get_all_product_use_case.dart'
    as _i206;
import '../../features/home/presentation/view_model/home_cubit.dart' as _i940;
import '../../features/onboarding/data/api/api.dart' as _i14;
import '../../features/products_by_category/data/api/products_by_category_api.dart'
    as _i883;
import '../../features/products_by_category/data/repo/data_source/products_by_category_data_source_imp.dart'
    as _i890;
import '../../features/products_by_category/data/repo/repo/products_by_category_repo_imp.dart'
    as _i459;
import '../../features/products_by_category/domain/repo/products_by_category_data_source_interface.dart'
    as _i417;
import '../../features/products_by_category/domain/repo/products_by_category_repo_interface.dart'
    as _i65;
import '../../features/products_by_category/domain/use_case/get_products_by_category_use_case.dart'
    as _i552;
import '../../features/products_by_category/presentation/view_model/products_by_category_cubit.dart'
    as _i1055;
import '../../features/search/data/api/search_api.dart' as _i156;
import '../../features/search/data/repo/data_source/search_data_source_imp.dart'
    as _i1053;
import '../../features/search/data/repo/repo/search_repo_imp.dart' as _i811;
import '../../features/search/domain/repo/search_data_source_interface.dart'
    as _i477;
import '../../features/search/domain/repo/search_repo_interface.dart' as _i44;
import '../../features/search/domain/use_case/search_products_use_case.dart'
    as _i1047;
import '../../features/search/presentation/view_model/search_cubit.dart'
    as _i794;
import '../helper/app_secure_storage.dart' as _i236;
import '../networking/auth_interceptor.dart' as _i323;
import '../storage/token_storage.dart' as _i973;
import 'register_modules.dart' as _i8;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModules = _$RegisterModules();
    final networkModule = _$NetworkModule();
    gh.factory<_i558.FlutterSecureStorage>(() => registerModules.storage);
    gh.lazySingleton<_i973.TokenStorage>(() => _i973.TokenStorage());
    gh.lazySingleton<_i302.AuthApi>(() => _i302.AuthApi());
    gh.lazySingleton<_i361.Dio>(() => networkModule.dio);
    gh.lazySingleton<_i236.AppSecureStorage>(
      () => _i236.AppSecureStorage(gh<_i558.FlutterSecureStorage>()),
    );
    gh.lazySingleton<_i403.RegisterApi>(
      () => _i403.RegisterApi(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i491.FavouriteApi>(
      () => _i491.FavouriteApi(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i168.Api>(() => _i168.Api(gh<_i361.Dio>()));
    gh.lazySingleton<_i14.Api>(() => _i14.Api(gh<_i361.Dio>()));
    gh.lazySingleton<_i883.ProductsByCategoryApi>(
      () => _i883.ProductsByCategoryApi(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i156.SearchApi>(() => _i156.SearchApi(gh<_i361.Dio>()));
    gh.factory<_i701.AuthDataSourceInterface>(
      () => _i477.AuthDataSourceImp(gh<_i302.AuthApi>()),
    );
    gh.lazySingleton<_i323.AuthInterceptor>(
      () => _i323.AuthInterceptor(gh<_i973.TokenStorage>()),
    );
    gh.lazySingleton<_i273.HomeDataSourceInterface>(
      () => _i879.HomeDataSourceImpl(gh<_i168.Api>()),
    );
    gh.lazySingleton<_i395.RegisterRepo>(
      () => _i395.RegisterRepo(gh<_i403.RegisterApi>()),
    );
    gh.lazySingleton<_i215.FavouriteDataSourceInterface>(
      () => _i384.FavouriteDataSourceImp(gh<_i491.FavouriteApi>()),
    );
    gh.factory<_i389.AuthRepoInterface>(
      () => _i909.AuthRepoImp(
        gh<_i701.AuthDataSourceInterface>(),
        gh<_i236.AppSecureStorage>(),
      ),
    );
    gh.lazySingleton<_i171.FavouriteRepoInterface>(
      () => _i149.FavouriteRepoImp(gh<_i215.FavouriteDataSourceInterface>()),
    );
    gh.lazySingleton<_i477.SearchDataSourceInterface>(
      () => _i1053.SearchDataSourceImp(gh<_i156.SearchApi>()),
    );
    gh.factory<_i999.AddToFavouriteUseCase>(
      () => _i999.AddToFavouriteUseCase(gh<_i171.FavouriteRepoInterface>()),
    );
    gh.factory<_i474.GetFavouritesUseCase>(
      () => _i474.GetFavouritesUseCase(gh<_i171.FavouriteRepoInterface>()),
    );
    gh.factory<_i495.RemoveFavouriteUseCase>(
      () => _i495.RemoveFavouriteUseCase(gh<_i171.FavouriteRepoInterface>()),
    );
    gh.lazySingleton<_i640.FavouriteCubit>(
      () => _i640.FavouriteCubit(
        gh<_i474.GetFavouritesUseCase>(),
        gh<_i999.AddToFavouriteUseCase>(),
        gh<_i495.RemoveFavouriteUseCase>(),
      ),
    );
    gh.lazySingleton<_i417.ProductsByCategoryDataSourceInterface>(
      () => _i890.ProductsByCategoryDataSourceImpl(
        gh<_i883.ProductsByCategoryApi>(),
      ),
    );
    gh.factory<_i1027.HomeRepoInterface>(
      () => _i1000.HomeRepoImpl(gh<_i273.HomeDataSourceInterface>()),
    );
    gh.lazySingleton<_i44.SearchRepoInterface>(
      () => _i811.SearchRepoImp(gh<_i477.SearchDataSourceInterface>()),
    );
    gh.factory<_i843.GetAllCategoriesUseCase>(
      () => _i843.GetAllCategoriesUseCase(gh<_i1027.HomeRepoInterface>()),
    );
    gh.factory<_i70.RegisterCubit>(
      () => _i70.RegisterCubit(gh<_i395.RegisterRepo>()),
    );
    gh.lazySingleton<_i65.ProductsByCategoryRepoInterface>(
      () => _i459.ProductsByCategoryRepoImpl(
        gh<_i417.ProductsByCategoryDataSourceInterface>(),
      ),
    );
    gh.factory<_i1047.SearchProductsUseCase>(
      () => _i1047.SearchProductsUseCase(gh<_i44.SearchRepoInterface>()),
    );
    gh.factory<_i206.GetAllProductUseCase>(
      () => _i206.GetAllProductUseCase(gh<_i1027.HomeRepoInterface>()),
    );
    gh.factory<_i794.SearchCubit>(
      () => _i794.SearchCubit(gh<_i1047.SearchProductsUseCase>()),
    );
    gh.factory<_i552.GetProductsByCategoryUseCase>(
      () => _i552.GetProductsByCategoryUseCase(
        repo: gh<_i65.ProductsByCategoryRepoInterface>(),
      ),
    );
    gh.factory<_i1055.ProductsByCategoryCubit>(
      () => _i1055.ProductsByCategoryCubit(
        gh<_i552.GetProductsByCategoryUseCase>(),
      ),
    );
    gh.factory<_i940.HomeCubit>(
      () => _i940.HomeCubit(
        gh<_i206.GetAllProductUseCase>(),
        gh<_i843.GetAllCategoriesUseCase>(),
      ),
    );
    return this;
  }
}

class _$RegisterModules extends _i8.RegisterModules {}

class _$NetworkModule extends _i168.NetworkModule {}
