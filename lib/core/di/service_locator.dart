import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/di/service_locator.config.dart';

final serviceLocator = GetIt.instance;

@InjectableInit(initializerName: 'init', preferRelativeImports: true)
void configureDependencies() {
  serviceLocator.init();
}
