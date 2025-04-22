import 'package:flutter/material.dart';

class SaudiRegulationsScreen extends StatelessWidget {
  static const route = '/saudi-laws';

  const SaudiRegulationsScreen({super.key});

  final List<Map<String, String>> regulations = const [
    {
      'title': 'Business Licenses',
      'description':
          'Learn how to apply for and renew business licenses in Saudi Arabia.',
    },
    {
      'title': 'Zakat & Tax Rules',
      'description':
          'Understand Zakat regulations and tax obligations for startups.',
    },
    {
      'title': 'Commercial Laws',
      'description': 'Explore key legal frameworks for commercial activities.',
    },
    {
      'title': 'Labor & Employment',
      'description':
          'Know the rules about hiring, contracts, and worker rights.',
    },
    {
      'title': 'Investment Rules',
      'description': 'Understand foreign and local investment regulations.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D3446),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A4E5F),
        title: const Text('Saudi Business Laws'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: regulations.length,
          itemBuilder: (context, index) {
            final law = regulations[index];
            return Card(
              color: const Color(0xFF1A4E5F),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                title: Text(
                  law['title']!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  law['description']!,
                  style: const TextStyle(color: Colors.white70, fontSize: 14),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white70,
                  size: 16,
                ),
                onTap: () {
                  // TODO: Navigate to a web view or detail page in the future
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
