import 'package:demo_crypto/views/account_section/acc_section_controller.dart';
import 'package:demo_crypto/views/account_section/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpgradeeScreen extends StatelessWidget {
  UpgradeeScreen({super.key});
  final controller = Get.find<AccSectionController>();
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
            'Upgrade Your Account',
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Obx(
                    () => ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.tiers.length,
                      itemBuilder: (context, index) {
                        final tier = controller.tiers[index];
                        return buildTierCard(tier);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
