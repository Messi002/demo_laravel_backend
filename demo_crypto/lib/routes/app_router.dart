import 'package:demo_crypto/views/account_section/account.dart';
import 'package:demo_crypto/views/account_section/upgrade.dart';
import 'package:demo_crypto/views/account_section/kyc.dart';
import 'package:demo_crypto/views/go_to_screen.dart';
import 'package:demo_crypto/views/splash_screen/splash.dart';
import 'package:demo_crypto/views/transfer_section/benecifiary.dart';
import 'package:demo_crypto/views/transfer_section/pay_screen.dart';
import 'package:demo_crypto/views/transfer_section/transfer_screen.dart';
import 'package:get/get.dart';

class AppRouter {
  static const String splashScreen = "/splash_screen";
  static const String gotoScreen = "/go_to_screen";
  static const String transferScreen = "/go_to_screen/transfer_screen";
  static const String beneficiaryScreen = "/transfer_screen/beneficiary";
  static const String payScreen = "/beneficiary/pay_screen";
  static const String accountScreen = "/go_to_screen/account_screen";
  static const String kycScreen = "/account_screen/upgrade_screen";
  static const String upgradeScreen = "/account_screen/kyc_screen";
  static const String congratsScreen = "/transfer_screen/congrats_screen";

  List<GetPage> routes = [
    GetPage(name: splashScreen, page: () => const Splashscreen()),
    GetPage(name: gotoScreen, page: () => const GoToScreen()),
    GetPage(name: transferScreen, page: () =>  TransferScreen()),
    GetPage(name: beneficiaryScreen, page: () =>  BenecifiaryScreen()),
    GetPage(name: payScreen, page: () =>  PayScreen()),
    GetPage(name: accountScreen, page: () => AccountScreen()),
    GetPage(name: kycScreen, page: () =>  KYCScreen()),
    GetPage(name: upgradeScreen, page: () => UpgradeeScreen()),
  ];
}


/*
Optimize code for [specific metric]:Optimize code for 
specific metrics such as speed, memory usage, performance, 
readability, maintainability including its 
strengths, weaknesses and provide suggestions for improvement.

Update [code] to [new standard]: Bring code up to date with the 
latest standards, best practices, coding conventions and/or use 
modern programming concepts, libraries, and frameworks.
*/