import 'package:demo_crypto/routes/app_router.dart';
import 'package:demo_crypto/views/transfer_section/transfer_section_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PayScreen extends StatelessWidget {
  final TransferSectionController controller =
      Get.find<TransferSectionController>();

  PayScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        SizedBox(
                            height: MediaQuery.sizeOf(context).height * 0.05),

                        headerSection(),
                        const SizedBox(height: 20),

                        SizedBox(
                          width: double.maxFinite,
                          // height: 300,
                          child: CustomPaint(
                            // size: Size(double.infinity,
                            //     300), // Custom size for the transaction summary
                            painter: ReceiptPainter(),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Center(
                                    child: Text(
                                      "Transaction Summary",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  const Divider(color: Colors.grey),
                                  summaryRow(
                                      "Name",
                                      controller
                                          .selectedBeneficiary.value.name),
                                  summaryRow("Transaction date", "02/04/2021",
                                      isBold: true),
                                  summaryRow("Transaction fee", "₦10"),
                                  summaryRow(
                                      "Payment", "₦${controller.amount}"),
                                  summaryRow("Total Payback Amount",
                                      "₦${double.parse(controller.amount.value) + 10}",
                                      isBold: true),
                                ],
                              ),
                            ),
                          ),
                        ),

                        // Pay Button
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Obx(() {
            return SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                ),
                onPressed: !controller.isLoading.value
                    ? () {
                        controller.createNewTransfer();
                      }
                    : null,
                child: !controller.isLoading.value
                    ? const Text('Pay')
                    : const CircularProgressIndicator.adaptive(
                        backgroundColor: Colors.red,
                      ),
              ),
            );
          }),
          SizedBox(height: MediaQuery.of(context).viewPadding.bottom + 50)
        ],
      ),
    ));
  }

  Widget headerSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("From",
                style: TextStyle(color: Colors.white, fontSize: 12)),
            Text(
              // '',
              controller.selectedAccount.value.accountNumber,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
            Text(
              controller.selectedBank.value,
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
          ],
        ),
        Column(
          children: [
            Text(
              "₦ ${controller.amount.value}.00",
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            Icon(Icons.compare_arrows, color: Colors.white, size: 30),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Text("To",
                style: TextStyle(color: Colors.white, fontSize: 12)),
            Text(
              controller.selectedBeneficiary.value.accountNumber,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
            Text(
              controller.selectedBeneficiary.value.name,
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
          ],
        ),
      ],
    );
  }

  Widget summaryRow(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(color: Colors.grey),
          ),
          Text(
            value,
            style: TextStyle(
                color: Colors.white,
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
          ),
        ],
      ),
    );
  }
}

class ReceiptPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    final path = Path();

    const double scallopRadius = 10;
    const double scallopDiameter = scallopRadius * 2;

    path.moveTo(0, 0);

    for (double i = 0; i < size.width; i += scallopDiameter) {
      path.arcToPoint(
        Offset(i + scallopRadius, 0),
        radius: const Radius.circular(scallopRadius),
        clockwise: false,
      );
    }

    path.lineTo(size.width, size.height - scallopRadius);

    for (double i = size.width; i >= 0; i -= scallopDiameter) {
      path.arcToPoint(
        Offset(i - scallopRadius, size.height),
        radius: const Radius.circular(scallopRadius),
        clockwise: false,
      );
    }

    path.lineTo(0, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
