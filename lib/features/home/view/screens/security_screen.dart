import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:start_pro/features/home/view/screens/change_password_screen.dart';

class SecurityScreen extends StatefulWidget {
  static const route = '/security';

  const SecurityScreen({super.key});

  @override
  State<SecurityScreen> createState() => _SecurityScreenState();
}

class _SecurityScreenState extends State<SecurityScreen> {
  bool is2FAEnabled = false;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _load2FAStatus();
  }

  Future<void> _load2FAStatus() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final doc =
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .get();
      final data = doc.data();
      if (data != null && data.containsKey('twoFactorEnabled')) {
        setState(() {
          is2FAEnabled = data['twoFactorEnabled'] ?? false;
        });
      }
    }
    setState(() => isLoading = false);
  }

  Future<void> _update2FAStatus(bool value) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance.collection('users').doc(user.uid).update(
        {'twoFactorEnabled': value},
      );

      setState(() {
        is2FAEnabled = value;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(value ? '2FA Enabled' : '2FA Disabled')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: LocaleText('security')),
      body:
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  const Text(
                    'Password & Account Security',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  ListTile(
                    leading: const Icon(Icons.lock_outline),
                    title: const Text('Change Password'),
                    subtitle: const Text('Update your account password'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      Navigator.pushNamed(context, ChangePasswordScreen.route);
                    },
                  ),
                  const Divider(),
                  SwitchListTile(
                    secondary: const Icon(Icons.phonelink_lock),
                    title: const Text('Two-Factor Authentication'),
                    subtitle: const Text('Add extra security to your account'),
                    value: is2FAEnabled,
                    onChanged: (value) => _update2FAStatus(value),
                  ),
                  const Divider(),
                
                ],
              ),
    );
  }
}
