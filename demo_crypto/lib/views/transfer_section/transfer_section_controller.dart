// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:demo_crypto/routes/app_router.dart';
import 'package:demo_crypto/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:demo_crypto/models/beneficiary.dart';
import 'package:demo_crypto/models/debit_account.dart';
import 'package:demo_crypto/models/transfer.dart';
import 'package:demo_crypto/views/transfer_section/transfer_section_repo.dart';

class TransferSectionController extends GetxController {
  // ================================
  // Dependencies
  // ================================
  final TransferSectionRepo _transferSectionRepo;

  // ================================
  // Controllers
  // ================================
  final TextEditingController accountNumberController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController bankController = TextEditingController();
  final TextEditingController accountNumberController2 =
      TextEditingController();

  // ================================
  // Observables
  // ================================
  var isLoading = false.obs;
  var daIndex = 0.obs;
  var daIndex2 = 0.obs;

  var selectedAccount = const DebitAccountModel(
    id: '-1',
    bankName: 'Select an account',
    accountNumber: '',
  ).obs;
  var selectedBank = 'Select a bank'.obs;
  var accountNumber = ''.obs;
  var amount = ''.obs;
  var description = ''.obs;
  var selectedBeneficiary =
      const BeneficiaryModel(id: '', name: '', bank: '', accountNumber: '').obs;
  var isAnonymous = false.obs;

  var searchQuery = ''.obs;

  var accountList = <DebitAccountModel>[].obs;

  // var bankList = <String>[
  //   'GTBank',
  //   'AccessBank',
  //   'UBA',
  //   'Zenith Bank',
  // ].obs;

  var transferList = <TransferModel>[].obs;
  var debitAccountList = <DebitAccountModel>[].obs;
  var beneficiariesList = <BeneficiaryModel>[].obs;

  // ================================
  // Computed Properties
  // ================================
  List<BeneficiaryModel> get filteredBeneficiaries {
    if (searchQuery.value.isEmpty) {
      return beneficiariesList;
    } else {
      return beneficiariesList.where((beneficiary) {
        return beneficiary.name
                .toLowerCase()
                .contains(searchQuery.value.toLowerCase()) ||
            beneficiary.bank
                .toLowerCase()
                .contains(searchQuery.value.toLowerCase()) ||
            beneficiary.accountNumber.contains(searchQuery.value);
      }).toList();
    }
  }

  // ================================
  // Constructor
  // ================================
  TransferSectionController({
    required TransferSectionRepo transferSectionRepo,
  }) : _transferSectionRepo = transferSectionRepo;

  // ================================
  // Lifecycle Methods
  // ================================
  @override
  void onInit() async {
    super.onInit();
    await initTransferController();
    accountNumberController.text = accountNumber.value;

    accountNumberController.addListener(() {
      setAccountNumber(accountNumberController.text);
    });
  }

  @override
  void onClose() {
    accountNumberController.dispose();
    super.onClose();
  }

  // ================================
  // Setter Methods
  // ================================
  void setSelectedBeneficiary(BeneficiaryModel beneficiary) {
    selectedBeneficiary.value = beneficiary;
    accountNumber.value = beneficiary.accountNumber;
    accountNumberController.text = beneficiary.accountNumber;
  }

  void setSelectedAccount(DebitAccountModel account, int index) {
    selectedAccount.value = account;
    daIndex.value = index;
  }

  void setSelectedBank(String bank, int index) {
    selectedBank.value = bank;
    daIndex2.value = index;
  }

  void setAccountNumber(String number) {
    accountNumber.value = number;

    if (number.length < 9 || number.length > 10) {
      selectedBeneficiary.value =
          const BeneficiaryModel(name: '', bank: '', accountNumber: '', id: '');
    }
  }

  void setAmount(String amountValue) {
    amount.value = amountValue;
  }

  void setDescription(String desc) {
    description.value = desc;
  }

  void toggleAnonymous(bool value) {
    isAnonymous.value = value;
  }

  void setSearchQuery(String query) {
    searchQuery.value = query;
  }

  void setBeneficiaryinControllers(BeneficiaryModel model) {
    accountNumberController2.text = model.accountNumber;
    nameController.text = model.name;
    bankController.text = model.bank;
  }

  // ================================
  // Checker or Validator Methods
  // ================================
  bool validateFields() {
    if (selectedAccount.value.id == '-1' ||
        selectedAccount.value.bankName == 'Select an account' ||
        selectedAccount.value.accountNumber.isEmpty) {
      AppUtils.customSnackBarError(error: 'Please select a valid account.');
      return false;
    }

    if (selectedBank.value == 'Select a bank') {
      AppUtils.customSnackBarError(error: 'Please select a valid bank.');
      return false;
    }

    if (accountNumber.value.isEmpty) {
      AppUtils.customSnackBarError(error: 'Account number cannot be empty.');
      return false;
    }

    if (amount.value.isEmpty) {
      AppUtils.customSnackBarError(error: 'Amount cannot be empty.');
      return false;
    }

    if (description.value.isEmpty) {
      AppUtils.customSnackBarError(error: 'Description cannot be empty.');
      return false;
    }

    if (selectedBeneficiary.value.id.isEmpty ||
        selectedBeneficiary.value.name.isEmpty ||
        selectedBeneficiary.value.bank.isEmpty ||
        selectedBeneficiary.value.accountNumber.isEmpty) {
      AppUtils.customSnackBarError(error: 'Please select a valid beneficiary.');
      return false;
    }

    return true;
  }

  // ================================
  // Initialization Methods
  // ================================
  Future<void> initTransferController({bool shouldLoad = true}) async {
    if (shouldLoad) {
      isLoading.value = true;
    }

    try {
      await Future.wait([
        fetchDebitAccounts(),
        fetchBeneficiaries(),
      ]);
    } catch (e, st) {
      log('Error in initTransferController: $e\n$st');
      AppUtils.customSnackBarError(error: e.toString());
    } finally {
      if (shouldLoad) {
        isLoading.value = false;
      }
    }
  }

  // ================================
  // CRUD Operations
  // ================================

  Future<void> fetchTransfers() async {
    try {
      await _transferSectionRepo.getTransfers();
    } catch (e) {
      log("fetchTransfers: $e", name: "TransferSectionController-Error");
    }
  }

  Future<void> createNewTransfer() async {
    isLoading.value = true;
    try {
      await _transferSectionRepo.createTransfer(
        accountNumber: accountNumber.value,
        bank: selectedBank.value,
        beneficiaryName: selectedBeneficiary.value.name,
        beneficiaryAccountNumber: selectedBeneficiary.value.accountNumber,
        amount: double.tryParse(amount.value) ?? 0,
        description: description.value,
        isAnonymous: isAnonymous.value,
        transactionDate: DateTime.now(),
      );

      Get.offAllNamed(AppRouter.gotoScreen);

      AppUtils.customSnackBarSuccess(success: 'Transfer successfully created');
    } catch (e) {
      log("createNewTransfer: $e", name: "TransferSectionController-Error");
      AppUtils.customSnackBarError(error: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchDebitAccounts() async {
    try {
      final items = (await _transferSectionRepo.getDebitAccounts()).items;
      const defaultValue = DebitAccountModel(
          id: '-1', bankName: 'Select an account', accountNumber: '');

      accountList.assignAll(items);
      accountList.insert(0, defaultValue);
    } catch (e) {
      log("fetchDebitAccounts: $e", name: "TransferSectionController-Error");
      rethrow;
    }
  }

  Future<void> fetchBeneficiaries(
      {int pageSize = 10, String? lastDocumentId}) async {
    try {
      final items = (await _transferSectionRepo.getBeneficiaries(
              pageSize: pageSize, lastDocumentId: lastDocumentId))
          .items;

      beneficiariesList.assignAll(items);
    } catch (e) {
      log("fetchBeneficiaries: $e", name: "TransferSectionController-Error");
      rethrow;
    }
  }

  Future<void> updateSelectedBeneficiary(BeneficiaryModel beneficiary) async {
    if (nameController.text.isEmpty) {
      throw 'Name field cannot be empty';
    }

    if (bankController.text.isEmpty) {
      throw 'Bank field cannot be empty';
    }

    if (accountNumberController2.text.isEmpty) {
      throw 'Account number field cannot be empty';
    }
    try {
      await _transferSectionRepo.updateBeneficiary(
        id: beneficiary.id,
        name: nameController.text,
        bank: bankController.text,
        accountNumber: accountNumberController2.text,
      );
      await initTransferController(shouldLoad: false);
      AppUtils.customSnackBarSuccess(
          success: 'Beneficiary successfully updated');
    } catch (e) {
      log("updateSelectedBeneficiary: $e",
          name: "TransferSectionController-Error");
      AppUtils.customSnackBarError(error: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteSelectedBeneficiary(String id) async {
    try {
      isLoading.value = true;
      final deletedItem = await _transferSectionRepo.deleteBeneficiary(id);
      await initTransferController(shouldLoad: false);
      AppUtils.customSnackBarSuccess(
          success: 'Beneficiary successfully deleted');

      // if (deletedItem.items.isEmpty) {
      // }
    } catch (e) {
      log("deleteSelectedBeneficiary: $e",
          name: "TransferSectionController-Error");
      AppUtils.customSnackBarError(error: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}

class Beneficiary {
  final String name;
  final String bank;
  final String accountNumber;

  Beneficiary({
    required this.name,
    required this.bank,
    required this.accountNumber,
  });
}



// /api/beneficiaries?pageSize=10
// /api/beneficiaries?pageSize=10&lastDocumentId=LAST_DOCUMENT_ID