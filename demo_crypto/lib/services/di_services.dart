import 'package:demo_crypto/services/api_services.dart';
import 'package:demo_crypto/views/splash_screen/splash_controller.dart';
import 'package:demo_crypto/views/splash_screen/splash_repo.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> initCertainControllers() async {
  final sharedPreferences = await SharedPreferences.getInstance();


  Get.put<SharedPreferences>(sharedPreferences);

  Get.put<ApiClient>(
      ApiClient(sharedPreferences: Get.find<SharedPreferences>()), permanent: true);

  Get.put<SplashRepo>(SplashRepo(apiClient: Get.find<ApiClient>()));

  Get.put<SplashController>(SplashController());
}
