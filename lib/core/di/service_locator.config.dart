// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

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

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final networkModule = _$NetworkModule();
    gh.lazySingleton<_i361.Dio>(() => networkModule.dio);
    gh.lazySingleton<_i168.Api>(() => _i168.Api(gh<_i361.Dio>()));
    gh.lazySingleton<_i14.Api>(() => _i14.Api(gh<_i361.Dio>()));
    gh.lazySingleton<_i273.HomeDataSourceInterface>(
      () => _i879.HomeDataSourceImpl(gh<_i168.Api>()),
    );
    gh.factory<_i1027.HomeRepoInterface>(
      () => _i1000.HomeRepoImpl(gh<_i273.HomeDataSourceInterface>()),
    );
    gh.factory<_i843.GetAllCategoriesUseCase>(
      () => _i843.GetAllCategoriesUseCase(gh<_i1027.HomeRepoInterface>()),
    );
    gh.factory<_i206.GetAllProductUseCase>(
      () => _i206.GetAllProductUseCase(gh<_i1027.HomeRepoInterface>()),
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

class _$NetworkModule extends _i168.NetworkModule {}
