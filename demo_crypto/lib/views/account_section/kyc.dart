import 'package:demo_crypto/views/account_section/acc_section_controller.dart';
import 'package:demo_crypto/views/account_section/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class KYCScreen extends StatelessWidget {
  KYCScreen({super.key});
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
          ),
        ),
        title: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'KYC Verification',
            ),
            Text(
              'Continue by verifying your identity',
              style: TextStyle(fontSize: 10),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.verificationSteps.length,
                  itemBuilder: (context, index) {
                    return Obx(() {
                      bool isSelected =
                          controller.selectedIndices.contains(index);

                      return buildVerificationTile(
                        title: controller.verificationSteps[index],
                        isSelected: isSelected,
                        onTap: () {
                          controller.toggleSelection(index);
                        },
                      );
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildVerificationTile({
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        decoration: BoxDecoration(
          color: const Color(0xFF3C4B52),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (isSelected)
              const Icon(
                Icons.check_circle,
                color: Colors.white,
              ),
          ],
        ),
      ),
    );
  }
}
