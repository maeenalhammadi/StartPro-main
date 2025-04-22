import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:start_pro/core/theme/palette.dart';
import '../widgets/labeled_input_with_tooltip.dart';
import '../widgets/labeled_dropdown_with_tooltip.dart';

class SalesPredictionScreen extends StatefulWidget {
  static const route = '/sales-prediction';

  @override
  State<SalesPredictionScreen> createState() => _SalesPredictionScreenState();
}

class _SalesPredictionScreenState extends State<SalesPredictionScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController targetMarketSizeController =
      TextEditingController();
  final TextEditingController pricePointController = TextEditingController();
  final TextEditingController marketingBudgetController =
      TextEditingController();
  final TextEditingController projectedReachController =
      TextEditingController();

  String? selectedRegion;
  String? selectedIndustry;
  String? selectedConversionRate;
  String? result;
  String? revenue;
  String? customerAcquisition;
  String? roi;

  final List<String> regions = [
    "Madinah",
    "Makkah",
    "Al Jouf",
    "Hail",
    "Al Baha",
    "Eastern Province",
    "Qassim",
    "Najran",
    "Asir",
    "Northern Borders",
    "Jazan",
    "Tabuk",
    "Riyadh",
  ];

  final List<String> industries = [
    "Finance & FinTech",
    "Tourism & Hospitality",
    "Technology & Software",
    "Real Estate",
    "Food & Beverage",
    "Creative & Design",
    "Health & Wellness",
    "Education",
    "Gaming & Esports",
    "Transportation",
    "E-commerce & Retail",
  ];

  final List<String> conversionRates = ["1", "2", "3", "4", "5"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      appBar: AppBar(
        title: const Text("Sales Prediction"),
        backgroundColor: AppColors.kSurfaceColor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              LabeledInputWithTooltip(
                controller: targetMarketSizeController,
                label: 'Target Market Size',
                tooltip:
                    'Estimated number of people who could be interested in your product.',
                keyboardType: TextInputType.number,
              ),
              LabeledDropdownWithTooltip(
                label: 'Saudi Region',
                tooltip: 'Choose the region your business will target.',
                items: regions,
                selectedValue: selectedRegion,
                onChanged: (val) => setState(() => selectedRegion = val),
              ),
              LabeledDropdownWithTooltip(
                label: 'Industry/Sector',
                tooltip: 'Select the field your business operates in.',
                items: industries,
                selectedValue: selectedIndustry,
                onChanged: (val) => setState(() => selectedIndustry = val),
              ),
              LabeledInputWithTooltip(
                controller: pricePointController,
                label: 'Price Point (SAR)',
                tooltip: 'Price of one product or service unit.',
                keyboardType: TextInputType.number,
              ),
              LabeledInputWithTooltip(
                controller: marketingBudgetController,
                label: 'Marketing Budget (SAR)/month',
                tooltip: 'How much you plan to spend on marketing each month.',
                keyboardType: TextInputType.number,
              ),
              LabeledInputWithTooltip(
                controller: projectedReachController,
                label: 'Projected Customer Reach/month',
                tooltip:
                    'Estimated number of people your marketing could reach monthly.',
                keyboardType: TextInputType.number,
              ),

              LabeledDropdownWithTooltip(
                label: 'Estimated Conversion Rate (%)',
                tooltip:
                    'For new businesses, this rate is typically between 1% to 3%.',
                items: conversionRates,
                selectedValue: selectedConversionRate,
                onChanged:
                    (val) => setState(() => selectedConversionRate = val),
              ),

              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _predictSales,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.kSurfaceColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  "Predict",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              if (result != null) ...[
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.kSurfaceColor.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.white24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 6,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "📈 Predicted Sales: $result SAR / Month",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        "💰 Revenue Estimate: $revenue SAR / Month",
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "👥 Customer Acquisition Estimate: $customerAcquisition customers / Month",
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "📊 ROI (Return on Investment): $roi%",
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNumberField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))],
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.kSurfaceColor,
          labelText: label,
          labelStyle: const TextStyle(color: Colors.white),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
        ),
        validator: (value) {
          if (value == null || value.trim().isEmpty) return 'Required';
          if (double.tryParse(value.trim()) == null)
            return 'Enter numbers only';
          return null;
        },
      ),
    );
  }

  Widget _buildDropdown(
    String label,
    List<String> items,
    String? selectedValue,
    void Function(String?) onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: DropdownButtonFormField<String>(
        value: selectedValue,
        dropdownColor: AppColors.kSurfaceColor,
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.kSurfaceColor,
          labelText: label,
          labelStyle: const TextStyle(color: Colors.white),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
        ),
        items:
            items.map((e) {
              return DropdownMenuItem(
                value: e,
                child: Text(e, style: const TextStyle(color: Colors.white)),
              );
            }).toList(),
        onChanged: onChanged,
        validator: (value) => value == null ? 'Please select $label' : null,
      ),
    );
  }

  Future<void> _predictSales() async {
    if (!_formKey.currentState!.validate()) return;

    final url = Uri.parse("http://10.0.2.2:5000/predict");

    final int marketSize = int.parse(targetMarketSizeController.text);
    final int price = int.parse(pricePointController.text);
    final int marketing = int.parse(marketingBudgetController.text);
    final int reach = int.parse(projectedReachController.text);
    final double rate = double.parse(selectedConversionRate!) / 100;

    final body = {
      "Target Market Size": marketSize,
      "Saudi Region": selectedRegion!,
      "Industry/Sector": selectedIndustry!,
      "Price Point (SAR)": price,
      "Marketing Budget (SAR)": marketing,
      "Projected Customer Reach": reach,
      "Estimated Conversion Rate (%)": rate * 100,
    };

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final double predictedSales = double.parse(
          data["predicted_sales"].toString(),
        );

        final double calculatedCustomers = reach * (rate / 0.01);
        final double calculatedRevenue = calculatedCustomers * price;
        final double calculatedROI =
            marketing == 0
                ? 0
                : ((calculatedRevenue - marketing) / marketing) * 100;

        final user = FirebaseAuth.instance.currentUser;
        final userEmail = user?.email ?? "unknown";
        final userId = user?.uid ?? "unknown";

        await FirebaseFirestore.instance.collection("sales_predictions").add({
          "userId": userId,
          "email": userEmail,
          "region": selectedRegion,
          "industry": selectedIndustry,
          "marketSize": marketSize,
          "pricePoint": price,
          "marketingBudget": marketing,
          "reach": reach,
          "conversionRate": rate * 100,
          "predictedSales": predictedSales,
          "calculatedRevenue": calculatedRevenue,
          "customerAcquisition": calculatedCustomers,
          "roi": calculatedROI,
          "timestamp": FieldValue.serverTimestamp(),
        });

        setState(() {
          result = predictedSales.toStringAsFixed(2);
          revenue = calculatedRevenue.toStringAsFixed(2);
          customerAcquisition = calculatedCustomers.toStringAsFixed(0);
          roi = calculatedROI.toStringAsFixed(2);
        });
      } else {
        setState(() => result = "Error: ${response.statusCode}");
      }
    } catch (e) {
      setState(() => result = "Error: $e");
    }
  }
}
