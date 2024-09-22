import 'package:demo_crypto/utils/custom_loader.dart';
import 'package:demo_crypto/utils/utils.dart';
import 'package:demo_crypto/views/transfer_section/transfer_section_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BenecifiaryScreen extends StatelessWidget {
  BenecifiaryScreen({super.key});
  final TransferSectionController controller =
      Get.find<TransferSectionController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: InkWell(
              onTap: () {
                controller.searchQuery.value = "";
                Get.back();
              },
              child: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                // size: 2,
              )),
          title: const Text(
            'Beneficiaries',
          ),
        ),
        body: SafeArea(
          child: Obx(() {
            return controller.isLoading.value
                ? const CustomLoader(isFullScreen: true)
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: TextFormField(
                            onChanged: (value) {
                              controller.setSearchQuery(value);
                            },
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: const Color(0xFF3C4B52),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                              prefixIcon:
                                  const Icon(Icons.search, color: Colors.white),
                              hintText: "Search",
                              hintStyle: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Obx(
                          () => ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: controller.filteredBeneficiaries.length,
                            itemBuilder: (context, index) {
                              final beneficiary =
                                  controller.filteredBeneficiaries[index];
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 10),
                                child: ListTile(
                                  minTileHeight: 90,
                                  // ignore: prefer_const_constructors
                                  leading: CircleAvatar(
                                    backgroundColor: Colors.orange,
                                    child: const Text("AP"),
                                  ),
                                  title: Text(
                                    beneficiary.name,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  subtitle: Text(
                                    "${beneficiary.bank} ${beneficiary.accountNumber}",
                                    style: const TextStyle(color: Colors.grey),
                                  ),
                                  onTap: () {
                                    controller
                                        .setSelectedBeneficiary(beneficiary);

                                    controller.searchQuery.value = "";
                                    Get.back();
                                  },

                                  trailing: Column(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          controller
                                              .setBeneficiaryinControllers(
                                                  beneficiary);
                                          Future.delayed(
                                              const Duration(milliseconds: 300),
                                              () {
                                            AppUtils.showUpdateDialog(
                                              context,
                                              controller.nameController,
                                              controller.bankController,
                                              controller
                                                  .accountNumberController2,
                                              () {
                                                // Update logic
                                                controller
                                                    .updateSelectedBeneficiary(
                                                        beneficiary);
                                              },
                                            );
                                          });
                                        },
                                        child: Icon(
                                          Icons.edit,
                                          color: Colors.orange,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          AppUtils.showDeleteConfirmationDialog(
                                              context,
                                              () => controller
                                                  .deleteSelectedBeneficiary(
                                                      beneficiary.id));
                                        },
                                        child: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                      )
                                    ],
                                  ),
                                  tileColor: const Color(0xFF3C4B52),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 6, horizontal: 16),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
          }),
        ));
  }
}
