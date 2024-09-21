import 'package:demo_crypto/routes/app_router.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GoToScreen extends StatelessWidget {
  const GoToScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF263238),
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      Get.toNamed(AppRouter.transferScreen);
                    },
                    child: const Text("Go to Transfer Screen")),
                const SizedBox(height: 20),
                ElevatedButton(
                    onPressed: () {
                      Get.toNamed(AppRouter.accountScreen);
                    },
                    child: const Text("Go to Account Screen")),
              ],
            ),
          ),
        ));
  }
}
