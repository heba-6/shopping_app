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
import 'package:shopping_app/features/home/data/api/api.dart' as _i1016;
import 'package:shopping_app/features/home/data/repo/data_source/data_source_imp.dart'
    as _i862;
import 'package:shopping_app/features/home/data/repo/repo/home_repo_imp.dart'
    as _i95;
import 'package:shopping_app/features/home/domain/repo/home_data_source_interface.dart'
    as _i879;
import 'package:shopping_app/features/home/domain/repo/home_repo_interface.dart'
    as _i191;
import 'package:shopping_app/features/home/domain/use_case/get_all_product_use_case.dart'
    as _i260;
import 'package:shopping_app/features/home/presentation/view_model/home_cubit.dart'
    as _i991;
import 'package:shopping_app/features/onboarding/data/api/api.dart' as _i530;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final networkModule = _$NetworkModule();
    gh.lazySingleton<_i361.Dio>(() => networkModule.dio);
    gh.lazySingleton<_i1016.Api>(() => _i1016.Api(gh<_i361.Dio>()));
    gh.lazySingleton<_i530.Api>(() => _i530.Api(gh<_i361.Dio>()));
    gh.lazySingleton<_i879.HomeDataSourceInterface>(
      () => _i862.HomeDataSourceImpl(gh<_i1016.Api>()),
    );
    gh.factory<_i191.HomeRepoInterface>(
      () => _i95.HomeRepoImpl(gh<_i879.HomeDataSourceInterface>()),
    );
    gh.factory<_i260.GetAllProductUseCase>(
      () => _i260.GetAllProductUseCase(gh<_i191.HomeRepoInterface>()),
    );
    gh.factory<_i991.HomeCubit>(
      () => _i991.HomeCubit(gh<_i260.GetAllProductUseCase>()),
    );
    return this;
  }
}

class _$NetworkModule extends _i1016.NetworkModule {}
