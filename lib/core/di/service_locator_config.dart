import 'package:get_it/get_it.dart' as i174;
import 'package:injectable/injectable.dart' as i526;

extension GetItInjectableX on i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  i174.GetIt init({
    String? environment,
    i526.EnvironmentFilter? environmentFilter,
  }) {
    i526.GetItHelper(this, environment, environmentFilter);
    return this;
  }
}
