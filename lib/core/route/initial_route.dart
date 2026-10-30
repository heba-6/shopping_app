import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_app/core/constants/app_keys.dart';
import 'package:shopping_app/core/di/service_locator.dart';
import 'package:shopping_app/core/helper/app_secure_storage.dart';
import 'package:shopping_app/core/route/app_route.dart';

Future<String> initialRoute() async {
  final prefs = await SharedPreferences.getInstance();
  final bool seenOnboarding = prefs.getBool('seenOnboarding') ?? false;
  if (!seenOnboarding) {
    return RoutesManager.onBoarding;
  }
  final storage = serviceLocator<AppSecureStorage>();
  final token = await storage.read(AppKeys.token);

  if (token.isNotEmpty) {
    return RoutesManager.appSection;
  } else {
    return RoutesManager.hello;
  }
}
