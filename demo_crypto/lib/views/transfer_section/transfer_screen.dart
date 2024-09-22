import 'package:demo_crypto/models/debit_account.dart';
import 'package:demo_crypto/routes/app_router.dart';
import 'package:demo_crypto/utils/custom_loader.dart';
import 'package:demo_crypto/views/transfer_section/transfer_section_controller.dart';
import 'package:demo_crypto/views/transfer_section/transfer_section_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransferScreen extends StatelessWidget {
  TransferScreen({super.key});
  final transferRepo = Get.put(TransferSectionRepo(apiClient: Get.find()));

  final TransferSectionController controller =
      Get.put(TransferSectionController(transferSectionRepo: Get.find()));

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
            'Transfer',
          ),
        ),
        body: SafeArea(
          child: RefreshIndicator.adaptive(
            color: Colors.red,
            onRefresh: () => controller.initTransferController(),
            child: Obx(() {
              return controller.isLoading.value
                  ? const CustomLoader(isFullScreen: true)
                  : SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 20),
                                const Text(
                                  "Select account to debit",
                                  style: TextStyle(color: Colors.white),
                                ),
                                const SizedBox(height: 10),
                                Obx(
                                  () => DropdownButtonFormField<
                                      DebitAccountModel>(
                                    menuMaxHeight: 200,
                                    value: controller
                                        .accountList[controller.daIndex.value],
                                    decoration: _inputDecoration(),
                                    onChanged: (value) {
                                      if (value != null) {
                                        final index = controller.accountList
                                            .indexWhere(
                                                (item) => item.id == value.id);
                                        controller.setSelectedAccount(
                                            value, index);
                                      }
                                    },
                                    items: controller.accountList
                                        .map((account) =>
                                            DropdownMenuItem<DebitAccountModel>(
                                              value: account,
                                              child: Text(
                                                  "${account.accountNumber} ${account.bankName}"),
                                            ))
                                        .toList(),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                const Text(
                                  "Bank",
                                  style: TextStyle(color: Colors.white),
                                ),
                                const SizedBox(height: 10),
                                Obx(
                                  () => DropdownButtonFormField<String>(
                                    menuMaxHeight: 200,
                                    value: controller
                                        .accountList[controller.daIndex2.value]
                                        .bankName,
                                    decoration: _inputDecoration(),
                                    onChanged: (value) {
                                      if (value != null) {
                                        //add set to have single values
                                        final index = controller.accountList
                                            .indexWhere((item) =>
                                                item.bankName == value);
                                        controller.setSelectedBank(
                                            value, index);
                                      }
                                    },
                                    items: controller.accountList
                                        .map((bank) => DropdownMenuItem<String>(
                                              value: bank.bankName,
                                              child: Text(bank.bankName),
                                            ))
                                        .toList(),
                                  ),
                                ),
                                const SizedBox(height: 26),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Account Number",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Get.toNamed(
                                            AppRouter.beneficiaryScreen);
                                      },
                                      child: const Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          "Select from Beneficiary",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                TextFormField(
                                  controller:
                                      controller.accountNumberController,

                                  decoration: _inputDecoration(),
                                  // onChanged: (value) {
                                  //   controller.setAccountNumber(value);
                                  // },
                                ),

                                const SizedBox(height: 10),
                                // ignore: prefer_const_constructors
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Obx(
                                    () {
                                      final beneficiary =
                                          controller.selectedBeneficiary.value;
                                      return Text(
                                        beneficiary.name.isNotEmpty
                                            ? beneficiary.name
                                            : " ",
                                        style: const TextStyle(
                                            color: Colors.white),
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(height: 20),
                                const Text(
                                  "Amount",
                                  style: TextStyle(color: Colors.white),
                                ),
                                const SizedBox(height: 10),
                                TextFormField(
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: const Color(0xFF3C4B52),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide.none,
                                    ),
                                    prefixText: '₦ ',
                                    prefixStyle: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) {
                                    controller.setAmount(value);
                                  },
                                  style: const TextStyle(color: Colors.white),
                                ),
                                const SizedBox(height: 20),
                                const Text(
                                  "Description",
                                  style: TextStyle(color: Colors.white),
                                ),
                                const SizedBox(height: 10),
                                TextFormField(
                                  decoration: _inputDecoration(),
                                  onChanged: (value) {
                                    controller.setDescription(value);
                                  },
                                ),
                                const SizedBox(height: 10),
                                Obx(
                                  () => CheckboxListTile(
                                    title: const Text("Make transfer anonymous",
                                        style: TextStyle(color: Colors.white)),
                                    value: controller.isAnonymous.value,
                                    onChanged: (value) {
                                      if (value != null) {
                                        controller.toggleAnonymous(value);
                                      }
                                    },
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.all(16),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      backgroundColor: Colors.white,
                                      foregroundColor: Colors.black,
                                    ),
                                    onPressed: () {
                                      if(controller.validateFields()){
                                        Get.toNamed(AppRouter.payScreen);
                                      }
                                    },
                                    child: const Text('Proceed'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
            }),
          ),
        ));
  }

  InputDecoration _inputDecoration() {
    return InputDecoration(
      filled: true,
      fillColor: const Color(0xFF3C4B52),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    );
  }
}
