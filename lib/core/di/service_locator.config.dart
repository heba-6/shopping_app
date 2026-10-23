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
import 'package:shopping_app/core/di/network_module.dart' as _i889;
import 'package:shopping_app/features/account/data/api/account_api.dart'
    as _i72;
import 'package:shopping_app/features/account/data/repo/data_source/data_source_imp.dart'
    as _i246;
import 'package:shopping_app/features/account/data/repo/repo/repo_imp.dart'
    as _i732;
import 'package:shopping_app/features/account/domain/repo/account_data_source_interface.dart'
    as _i845;
import 'package:shopping_app/features/account/domain/repo/account_repo_interface.dart'
    as _i416;
import 'package:shopping_app/features/account/domain/use_case/get_user_profile_use_case.dart'
    as _i399;
import 'package:shopping_app/features/account/domain/use_case/update_user_profile_use_case.dart'
    as _i216;
import 'package:shopping_app/features/account/presentation/view_model/account_cubit.dart'
    as _i588;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final networkModule = _$NetworkModule();
    gh.lazySingleton<_i361.Dio>(() => networkModule.dio);
    gh.lazySingleton<_i72.AccountApi>(() => _i72.AccountApi(gh<_i361.Dio>()));
    gh.lazySingleton<_i845.AccountDataSourceInterface>(
      () => _i246.AccountDataSourceImpl(gh<_i72.AccountApi>()),
    );
    gh.lazySingleton<_i416.AccountRepoInterface>(
      () => _i732.AccountRepoImpl(gh<_i845.AccountDataSourceInterface>()),
    );
    gh.factory<_i399.GetUserProfileUseCase>(
      () => _i399.GetUserProfileUseCase(gh<_i416.AccountRepoInterface>()),
    );
    gh.factory<_i216.UpdateUserProfileUseCase>(
      () => _i216.UpdateUserProfileUseCase(gh<_i416.AccountRepoInterface>()),
    );
    gh.factory<_i588.AccountCubit>(
      () => _i588.AccountCubit(
        gh<_i399.GetUserProfileUseCase>(),
        gh<_i216.UpdateUserProfileUseCase>(),
      ),
    );
    return this;
  }
}

class _$NetworkModule extends _i889.NetworkModule {}
