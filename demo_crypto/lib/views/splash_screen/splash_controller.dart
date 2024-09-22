import 'package:demo_crypto/routes/app_router.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  bool isLoading = false;
  bool noInternet = false;
  bool isUserLoggedIn = false;

  init() async {
    if (isUserLoggedIn) {
      Future.delayed(const Duration(seconds: 1), () {
        // navigate user to home screen
      });
    } else {
      // navigate user to onboarding screen
      Future.delayed(const Duration(seconds: 5), () {
        Get.offAllNamed(AppRouter.gotoScreen);
        // Get.offAndToNamed(AppRouter.mainNavigation);
      });
    }
  }
}
