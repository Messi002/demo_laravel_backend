import 'package:demo_crypto/Constants/constants.dart';
import 'package:demo_crypto/routes/app_router.dart';
import 'package:demo_crypto/views/account_section/acc_section_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileCardWithCustomPainter extends StatelessWidget {
  const ProfileCardWithCustomPainter({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 230,
        child: Stack(
          children: [
            // The custom painter background
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 178,
              child: CustomPaint(
                painter: ProfileBackgroundPainter(),
              ),
            ),

            // Profile Picture
            Positioned(
              top: 38,
              left: MediaQuery.of(context).size.width * 0.04,
              child: const CircleAvatar(
                radius: 42,
                backgroundColor: Colors.blue,
                child: CircleAvatar(
                  radius: 36,
                  backgroundImage: NetworkImage(ConstantsClass.profilePicLink),
                ),
              ),
            ),

            Positioned(
              top: -50,
              left: MediaQuery.of(context).size.width * 0.3,
              child: SizedBox(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 80),
                    const Text(
                      'Divine Joe',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          '8686652357',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[300],
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(
                          Icons.content_copy,
                          color: Colors.white,
                          size: 10,
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    InkWell(
                      onTap: () => Get.toNamed(AppRouter.upgradeScreen),
                      child: const Chip(
                        padding: EdgeInsets.all(1),
                        label: Text(
                          '🏅 Tier 1',
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.orange,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Floating action button
            Positioned(
              bottom: 16,
              left: MediaQuery.of(context).size.width * 0.35,
              right: MediaQuery.of(context).size.width * 0.35,
              child: Container(
                width: 46,
                height: 70,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.elliptical(50, 50))),
                child: const Icon(
                  Icons.edit,
                  color: Colors.orange,
                  size: 30,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey[800]!
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(20, 0)
      ..quadraticBezierTo(0, 0, 0, 20)
      ..lineTo(0, size.height - 40)
      ..quadraticBezierTo(0, size.height, 20, size.height)
      ..lineTo(size.width - 20, size.height)
      ..quadraticBezierTo(size.width, size.height, size.width, size.height - 20)
      ..lineTo(size.width, 20)
      ..quadraticBezierTo(size.width, 0, size.width - 20, 0)
      ..close();

    path.moveTo(size.width / 2 - 46, size.height);
    path.arcToPoint(
      Offset(size.width / 2 + 46, size.height),
      radius: const Radius.circular(46),
      clockwise: false,
    );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

//Icons section

Widget buildMenuItem(IconData icon, String label1, String label2,
    {VoidCallback? onTapAction}) {
  return GestureDetector(
    onTap: onTapAction,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF3C4B52),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Icon(
            icon,
            color: Colors.orange,
            size: 28,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label1,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.white,
          ),
        ),
        Text(
          label2,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.white,
          ),
        ),
      ],
    ),
  );
}

class SettingsOptions extends StatelessWidget {
  final controller = Get.find<AccSectionController>();

  SettingsOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16),
      children: [
        _buildSettingsTile(
          icon: Icons.account_balance_wallet,
          iconColor: Colors.orange,
          backgroundColor: Colors.lightBlue[50]!,
          title: "Accounts",
          subtitle: "Manage your accounts",
          trailing: const Icon(Icons.chevron_right, color: Colors.white),
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Coming soon...')),
            );
          },
        ),
        _buildSettingsTile(
          icon: Icons.language,
          iconColor: Colors.orange,
          backgroundColor: Colors.lightBlue[50]!,
          title: "Language",
          subtitle: "You can change the app language",
          trailing: const Icon(Icons.chevron_right, color: Colors.white),
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Coming soon...')),
            );
          },
        ),
        _buildSettingsTile(
          icon: Icons.fingerprint,
          iconColor: Colors.orange,
          backgroundColor: Colors.lightBlue[50]!,
          title: "Finger print",
          subtitle: "Biometric login",
          trailing: Obx(
            () => Switch(
              value: controller.isFingerprintEnabled.value,
              onChanged: (bool value) {
                controller.toggleFingerprint();
              },
              activeColor: Colors.orange,
            ),
          ),
          onTap: () {
            controller.toggleFingerprint();
          },
        ),
        _buildSettingsTile(
          icon: Icons.brightness_6,
          iconColor: Colors.orange,
          backgroundColor: Colors.lightBlue[50]!,
          title: "Light Mode",
          subtitle: "Switch between light & dark mode",
          trailing: Obx(
            () => Switch(
              value: controller.isLightModeEnabled.value,
              onChanged: (bool value) {
                controller.toggleLightMode();
              },
              activeColor: Colors.orange,
            ),
          ),
          onTap: () {
            controller.toggleLightMode();
          },
        ),
      ],
    );
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required Color iconColor,
    required Color backgroundColor,
    required String title,
    required String subtitle,
    required Widget trailing,
    VoidCallback? onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        onTap: onTap,
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: iconColor,
            size: 28,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            color: Colors.grey[400],
            fontSize: 14,
          ),
        ),
        trailing: trailing,
      ),
    );
  }
}

//! -------------Upgrade SECTION------------

Widget buildTierCard(Tier tier) {
  return Card(
    color: const Color(0xFF3C4B52),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    margin: const EdgeInsets.symmetric(vertical: 10),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // const Icon(
              //   Icons.emoji_events,
              //   color: Colors.orange,
              // )

              const Text("🏅"),
              const SizedBox(width: 8),
              Text(
                tier.tierName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Divider(
            height: 10,
            color: Colors.grey[600]!,
          ),
          const SizedBox(height: 10),
          _buildTierRow("Daily transaction limit", tier.transactionLimit),
          const SizedBox(height: 10),
          _buildTierRow("Maximum account balance", tier.accountBalance),
        ],
      ),
    ),
  );
}

Widget _buildTierRow(String label, String value) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        label,
        style: TextStyle(
          color: Colors.grey[300],
          fontSize: 16,
        ),
      ),
      Text(
        value,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    ],
  );
}


//!-----------------KYC VERIFICATION--------------

