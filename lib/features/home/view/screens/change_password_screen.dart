import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChangePasswordScreen extends StatefulWidget {
  static const route = '/change-password';

  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController currentPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isLoading = false;

  // للتحكم في إظهار أو إخفاء الحقول
  bool _obscureCurrent = true;
  bool _obscureNew = true;
  bool _obscureConfirm = true;

  Future<void> _changePassword() async {
    final user = _auth.currentUser;
    final currentPassword = currentPasswordController.text.trim();
    final newPassword = newPasswordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    if (newPassword != confirmPassword) {
      _showMessage('Passwords do not match');
      return;
    }

    setState(() => isLoading = true);

    try {
      final cred = EmailAuthProvider.credential(
        email: user!.email!,
        password: currentPassword,
      );

      await user.reauthenticateWithCredential(cred);
      await user.updatePassword(newPassword);

      // ✅ تحديث Firestore بكلمة المرور الجديدة
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .update({'password': newPassword});

      _showMessage('Password updated successfully');
      Navigator.pop(context);
    } catch (e) {
      _showMessage('Error: ${e.toString()}');
    }

    setState(() => isLoading = false);
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Change Password')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            const Text('Current Password'),
            const SizedBox(height: 8),
            TextField(
              controller: currentPasswordController,
              obscureText: _obscureCurrent,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: 'Enter current password',
                suffixIcon: IconButton(
                  icon: Icon(_obscureCurrent ? Icons.visibility_off : Icons.visibility),
                  onPressed: () {
                    setState(() => _obscureCurrent = !_obscureCurrent);
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text('New Password'),
            const SizedBox(height: 8),
            TextField(
              controller: newPasswordController,
              obscureText: _obscureNew,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: 'Enter new password',
                suffixIcon: IconButton(
                  icon: Icon(_obscureNew ? Icons.visibility_off : Icons.visibility),
                  onPressed: () {
                    setState(() => _obscureNew = !_obscureNew);
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text('Confirm New Password'),
            const SizedBox(height: 8),
            TextField(
              controller: confirmPasswordController,
              obscureText: _obscureConfirm,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: 'Re-enter new password',
                suffixIcon: IconButton(
                  icon: Icon(_obscureConfirm ? Icons.visibility_off : Icons.visibility),
                  onPressed: () {
                    setState(() => _obscureConfirm = !_obscureConfirm);
                  },
                ),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: isLoading ? null : _changePassword,
              child: isLoading
                  ? const CircularProgressIndicator()
                  : const Text('Save'),
            )
          ],
        ),
      ),
    );
  }
}
