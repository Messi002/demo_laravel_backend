import 'dart:developer';

import 'package:get/get.dart';

class AccSectionController extends GetxController {
  var isFingerprintEnabled = true.obs;
  var isLightModeEnabled = false.obs;

  void toggleFingerprint() {
    isFingerprintEnabled.value = !isFingerprintEnabled.value;
  }

  void toggleLightMode() {
    isLightModeEnabled.value = !isLightModeEnabled.value;
  }

  var tiers = <Tier>[
    Tier(
      tierName: "Tier 1",
      transactionLimit: "₦50,000.00",
      accountBalance: "₦300,000.00",
    ),
    Tier(
      tierName: "Tier 2",
      transactionLimit: "₦200,000.00",
      accountBalance: "₦500,000.00",
    ),
    Tier(
      tierName: "Tier 3",
      transactionLimit: "₦5,000,000.00",
      accountBalance: "Unlimited",
    ),
  ].obs;

    var verificationSteps = [
    'Personal information',
    'Face verification',
    'BVN Verification'
  ].obs;

  var selectedIndices = <int>[].obs;

  void toggleSelection(int index) {

    if (selectedIndices.contains(index)) {
      selectedIndices.remove(index);
    } else {
      selectedIndices.add(index);
    }
  }
}

class Tier {
  final String tierName;
  final String transactionLimit;
  final String accountBalance;

  Tier({
    required this.tierName,
    required this.transactionLimit,
    required this.accountBalance,
  });
}
