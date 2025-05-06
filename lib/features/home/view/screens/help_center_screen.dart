import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpCenterScreen extends StatelessWidget {
  static const route = '/help-center';

  const HelpCenterScreen({super.key});

  void _launchEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'graduationp@gmail.com',
      query: 'subject=Support Request',
    );
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    }
  }

  void _launchPhone() async {
    final Uri phoneUri = Uri(scheme: 'tel', path: '0546804148');
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: LocaleText('help_center')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Contact Us',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          ListTile(
            leading: const Icon(Icons.email),
            title: const Text('graduationp@gmail.com'),
            onTap: _launchEmail,
          ),
          ListTile(
            leading: const Icon(Icons.phone),
            title: const Text('0546804148'),
            onTap: _launchPhone,
          ),
          const SizedBox(height: 24),
          const Text(
            'Frequently Asked Questions (FAQs)',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          ExpansionTile(
            title: const Text('How do I change my password?'),
            children: const [ListTile(title: Text('Go to Settings > Security > Change Password.'))],
          ),
          ExpansionTile(
            title: const Text('Is my data secure?'),
            children: const [
              ListTile(
                title: Text('Yes, we use multi-factor authentication and follow OWASP security standards.'),
              ),
            ],
          ),
          ExpansionTile(
            title: const Text('How do I use the AI tools in the app?'),
            children: const [
              ListTile(
                title: Text('Navigate to Name Generator or Logo Generator and enter your business details.')),
            ],
          ),
        ],
      ),
    );
  }
}
