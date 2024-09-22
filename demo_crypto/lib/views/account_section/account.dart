import 'package:demo_crypto/routes/app_router.dart';
import 'package:demo_crypto/views/account_section/acc_section_controller.dart';
import 'package:demo_crypto/views/account_section/account_section_repo.dart';
import 'package:demo_crypto/views/account_section/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountScreen extends StatelessWidget {
  AccountScreen({super.key});
  final AccSectionController controller = Get.put(AccSectionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: InkWell(
              onTap: () {
                Get.back();
              },
              child: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                // size: 2,
              )),
          title: const Text(
            'Account',
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 18.0),
                  child: ProfileCardWithCustomPainter(),
                ),
                const SizedBox(height: 20),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Upgrade KYC
                        buildMenuItem(Icons.person_remove, "Upgrade", "KYC",
                            onTapAction: () =>
                                Get.toNamed(AppRouter.kycScreen)),
                        // Change PIN
                        buildMenuItem(
                          Icons.settings,
                          "Change",
                          "PIN",
                        ),
                        // My QR Code
                        buildMenuItem(
                          Icons.qr_code,
                          "My",
                          "QR Code",
                        ),
                        // Help & Support
                        buildMenuItem(Icons.help_outline, "Help", "& Support"),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                SettingsOptions(),
              ],
            ),
          ),
        ));
  }
}
