import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import './pdf_viewer_screen.dart';

class SaudiRegulationsScreen extends StatelessWidget {
  static const route = '/saudi-laws';

  const SaudiRegulationsScreen({super.key});

  final List<Map<String, String>> regulations = const [
    {
      'titleKey': 'accounting_title',
      'descriptionKey': 'accounting_description',
      'pdfPath': 'assets/pdfs/Accounting and Auditing Profession System.pdf',
    },
    {
      'titleKey': 'resident_title',
      'descriptionKey': 'resident_description',
      'pdfPath': 'assets/pdfs/Accredited Resident System.pdf',
    },
    {
      'titleKey': 'fraud_title',
      'descriptionKey': 'fraud_description',
      'pdfPath': 'assets/pdfs/Anti-Commercial Fraud System.pdf',
    },
    {
      'titleKey': 'arbitration_title',
      'descriptionKey': 'arbitration_description',
      'pdfPath': 'assets/pdfs/Arbitration system.pdf',
    },
    {
      'titleKey': 'chambers_title',
      'descriptionKey': 'chambers_description',
      'pdfPath': 'assets/pdfs/Chambers of Commerce System.pdf',
    },
    {
      'titleKey': 'chemical_title',
      'descriptionKey': 'chemical_description',
      'pdfPath': 'assets/pdfs/Chemical Management System.pdf',
    },
    {
      'titleKey': 'agency_title',
      'descriptionKey': 'agency_description',
      'pdfPath': 'assets/pdfs/Commercial Agency System.pdf',
    },
    {
      'titleKey': 'data_title',
      'descriptionKey': 'data_description',
      'pdfPath': 'assets/pdfs/Commercial Data System.pdf',
    },
    {
      'titleKey': 'ledger_title',
      'descriptionKey': 'ledger_description',
      'pdfPath': 'assets/pdfs/Commercial ledger system.pdf',
    },
    {
      'titleKey': 'paper_title',
      'descriptionKey': 'paper_description',
      'pdfPath': 'assets/pdfs/Commercial paper system.pdf',
    },
    {
      'titleKey': 'registry_title',
      'descriptionKey': 'registry_description',
      'pdfPath': 'assets/pdfs/Commercial Registry System.pdf',
    },
    {
      'titleKey': 'companies_title',
      'descriptionKey': 'companies_description',
      'pdfPath': 'assets/pdfs/Companies system.pdf',
    },
    {
      'titleKey': 'measurement_title',
      'descriptionKey': 'measurement_description',
      'pdfPath': 'assets/pdfs/Measurement and calibration system.pdf',
    },
    {
      'titleKey': 'commerce_ministry_title',
      'descriptionKey': 'commerce_ministry_description',
      'pdfPath': 'assets/pdfs/Ministry of Commerce System.pdf',
    },
    {
      'titleKey': 'standards_title',
      'descriptionKey': 'standards_description',
      'pdfPath':
          'assets/pdfs/Organization of the Saudi Standards, Metrology and Quality.pdf',
    },
    {
      'titleKey': 'labs_title',
      'descriptionKey': 'labs_description',
      'pdfPath': 'assets/pdfs/Private Laboratories System.pdf',
    },
    {
      'titleKey': 'warehouse_title',
      'descriptionKey': 'warehouse_description',
      'pdfPath': 'assets/pdfs/Public warehouse deposit system.pdf',
    },
    {
      'titleKey': 'engineers_title',
      'descriptionKey': 'engineers_description',
      'pdfPath': 'assets/pdfs/Saudi Council of Engineers System.pdf',
    },
    {
      'titleKey': 'trade_names_title',
      'descriptionKey': 'trade_names_description',
      'pdfPath': 'assets/pdfs/Trade Names System.pdf',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D3446),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A4E5F),
        title: LocaleText('saudi_business_laws'),
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
                  context.localeString(law['titleKey']!),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  context.localeString(law['descriptionKey']!),
                  style: const TextStyle(color: Colors.white70, fontSize: 14),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white70,
                  size: 16,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (_) => PdfViewerScreen(
                            title: context.localeString(law['titleKey']!),
                            pdfPath: law['pdfPath']!,
                          ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
