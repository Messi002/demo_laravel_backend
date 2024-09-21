import 'dart:async';

import 'package:demo_crypto/views/splash_screen/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    FocusManager.instance.primaryFocus?.unfocus();

    super.initState();

    Get.find<SplashController>().init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Icon(
          Icons.adjust_outlined,
          size: 40,
          color: Colors.white,
        ),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Color(0xFF263238),
        ),
      ),
    );
  }
}
