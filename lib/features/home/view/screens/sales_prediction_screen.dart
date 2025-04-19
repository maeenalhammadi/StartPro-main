import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:start_pro/core/theme/palette.dart';

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
  final TextEditingController conversionRateController =
      TextEditingController();

  String? selectedRegion;
  String? selectedIndustry;
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
              _buildNumberField(
                "Target Market Size",
                targetMarketSizeController,
              ),
              _buildDropdown("Saudi Region", regions, selectedRegion, (val) {
                setState(() => selectedRegion = val);
              }),
              _buildDropdown("Industry/Sector", industries, selectedIndustry, (
                val,
              ) {
                setState(() => selectedIndustry = val);
              }),
              _buildNumberField("Price Point (SAR)", pricePointController),
              _buildNumberField(
                "Marketing Budget (SAR)/month",
                marketingBudgetController,
              ),
              _buildNumberField(
                "Projected Customer Reach/month",
                projectedReachController,
              ),
              _buildNumberField(
                "Estimated Conversion Rate (%)",
                conversionRateController,
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
                Text(
                  "Predicted Sales: $result SAR / Month",
                  style: const TextStyle(fontSize: 18, color: Colors.white),
                ),
                const SizedBox(height: 12),
                Text(
                  "Revenue Estimate: $revenue SAR / Month",
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
                Text(
                  "Customer Acquisition Estimate: $customerAcquisition customers / Month",
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
                Text(
                  "ROI (Return on Investment): $roi%",
                  style: const TextStyle(fontSize: 16, color: Colors.white),
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
            items
                .map(
                  (e) => DropdownMenuItem(
                    value: e,
                    child: Text(e, style: const TextStyle(color: Colors.white)),
                  ),
                )
                .toList(),
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
    final double rate = double.parse(conversionRateController.text) / 100;

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

        final double calculatedRevenue = price * predictedSales;
        final double calculatedCustomers = reach * rate;
        final double profit = predictedSales - marketing;
        final double calculatedROI =
            marketing == 0 ? 0 : (profit / marketing) * 100;

        // Get user info
        final user = FirebaseAuth.instance.currentUser;
        final userEmail = user?.email ?? "unknown";
        final userId = user?.uid ?? "unknown";

        // Save to Firestore
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
