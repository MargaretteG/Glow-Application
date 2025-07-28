import 'package:flutter/material.dart';
import 'package:glow_application/main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:glow_application/widgets/popup.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(65),
        child: AppBar(
          backgroundColor: const Color(0xFFFA8298),
          automaticallyImplyLeading: true,
          iconTheme: const IconThemeData(color: Colors.white),
          centerTitle: true,
          title: Container(
            margin: const EdgeInsets.only(top: 9),
            child: Text(
              'Settings',
              style: GoogleFonts.poppins(
                fontSize: 30,
                color: Colors.white,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        children: [
          _buildSettingsTile(
            icon: Icons.person_outline,
            title: 'Account',
            subtitle: 'Manage your profile and login',
            onTap: () {
              // Navigate to account settings
            },
          ),
          _buildSettingsTile(
            icon: Icons.notifications_none,
            title: 'Notifications',
            subtitle: 'Push, SMS, and email preferences',
            onTap: () {
              // Navigate to notification settings
            },
          ),
          _buildSettingsTile(
            icon: Icons.lock_outline,
            title: 'Privacy',
            subtitle: 'Permissions and privacy settings',
            onTap: () {
              // Navigate to privacy settings
            },
          ),
          _buildSettingsTile(
            icon: Icons.color_lens_outlined,
            title: 'Theme',
            subtitle: 'Light or dark mode',
            onTap: () {
              // Open theme settings
            },
          ),
          _buildSettingsTile(
            icon: Icons.help_outline,
            title: 'Help & Support',
            subtitle: 'FAQs and contact support',
            onTap: () {
              // Navigate to help page
            },
          ),
          const SizedBox(height: 20),
          TextButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return GlowPopup(
                    title: 'Log Out?',
                    headerIcon: Icons.logout,
                    description: 'Already leaving?',
                    hasTextField: false,
                    confirmText: 'Log Out',
                    onConfirm: () {
                      Navigator.of(context).pop();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const MyHomePage()),
                      );
                    },
                  );
                },
              );
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.pink,
              backgroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              elevation: 2,
            ),
            child: const Text(
              'Log Out',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 16,
        ),
        leading: Icon(icon, size: 26, color: Colors.pink),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}
