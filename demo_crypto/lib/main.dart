import 'package:demo_crypto/routes/app_router.dart';
import 'package:demo_crypto/services/di_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initCertainControllers();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 200),
      navigatorKey: Get.key,
      initialRoute: AppRouter.splashScreen,
      getPages: AppRouter().routes,
      title: 'Demo',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF263238),
        appBarTheme: const AppBarTheme(
          color: Color(0xFF263238),
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w500,
            height: 1.2,
            letterSpacing: 1,
          ),
        ),
      ),
    );
    // );
  }
}
