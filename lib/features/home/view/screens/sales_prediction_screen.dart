// 📄 File: sales_prediction_screen.dart
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:start_pro/core/theme/palette.dart';
import '../widgets/labeled_input_with_tooltip.dart';
import '../widgets/labeled_dropdown_with_tooltip.dart';
import 'package:flutter_locales/flutter_locales.dart';

class SalesPredictionScreen extends StatefulWidget {
  static const route = '/sales-prediction';

  @override
  State<SalesPredictionScreen> createState() => _SalesPredictionScreenState();
}

class _SalesPredictionScreenState extends State<SalesPredictionScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController targetMarketSizeController = TextEditingController();
  final TextEditingController pricePointController = TextEditingController();
  final TextEditingController marketingBudgetController = TextEditingController();
  final TextEditingController projectedReachController = TextEditingController();

  String? selectedRegion;
  String? selectedIndustry;
  String? selectedConversionRate;
  String? result;
  String? revenue;
  String? customerAcquisition;
  String? roi;

  final List<String> regionKeys = [
    "madinah", "makkah", "al_jouf", "hail", "al_baha", "eastern_province",
    "qassim", "najran", "asir", "northern_borders", "jazan", "tabuk", "riyadh"
  ];

  final List<String> industryKeys = [
    "finance_and_fintech", "tourism_and_hospitality", "technology_and_software", "real_estate",
    "food_and_beverage", "creative_and_design", "health_and_wellness", "education",
    "gaming_and_esports", "transportation", "ecommerce_and_retail"
  ];

  final List<String> conversionRates = ["1", "2", "3", "4", "5"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      appBar: AppBar(
        title: LocaleText("sales_prediction"),
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
                label: context.localeString("target_market_size"),
                tooltip: context.localeString("target_market_size_tooltip"),
                keyboardType: TextInputType.number,
              ),
              LabeledDropdownWithTooltip(
                label: context.localeString("saudi_region"),
                tooltip: context.localeString("saudi_region_tooltip"),
                items: regionKeys.map((key) => context.localeString(key)).toList(),
                selectedValue: selectedRegion,
                onChanged: (val) => setState(() => selectedRegion = val),
              ),
              LabeledDropdownWithTooltip(
                label: context.localeString("industry_sector"),
                tooltip: context.localeString("industry_sector_tooltip"),
                items: industryKeys.map((key) => context.localeString(key)).toList(),
                selectedValue: selectedIndustry,
                onChanged: (val) => setState(() => selectedIndustry = val),
              ),
              LabeledInputWithTooltip(
                controller: pricePointController,
                label: context.localeString("price_point_sar"),
                tooltip: context.localeString("price_point_sar_tooltip"),
                keyboardType: TextInputType.number,
              ),
              LabeledInputWithTooltip(
                controller: marketingBudgetController,
                label: context.localeString("marketing_budget_sar_per_month"),
                tooltip: context.localeString("marketing_budget_sar_per_month_tooltip"),
                keyboardType: TextInputType.number,
              ),
              LabeledInputWithTooltip(
                controller: projectedReachController,
                label: context.localeString("projected_customer_reach_per_month"),
                tooltip: context.localeString("projected_customer_reach_per_month_tooltip"),
                keyboardType: TextInputType.number,
              ),
              LabeledDropdownWithTooltip(
                label: context.localeString("estimated_conversion_rate"),
                tooltip: context.localeString("estimated_conversion_rate_tooltip"),
                items: conversionRates.map((rate) => "$rate%").toList(),
                selectedValue: selectedConversionRate,
                onChanged: (val) => setState(() => selectedConversionRate = val),
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
                child: Text(
                  context.localeString("predict"),
                  style: const TextStyle(
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
                        context.localeString("predicted_sales_label").replaceAll("{amount}", result!),
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        context.localeString("revenue_estimate_label").replaceAll("{amount}", revenue!),
                        style: const TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        context.localeString("customer_acquisition_estimate_label").replaceAll("{amount}", customerAcquisition!),
                        style: const TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        context.localeString("roi_label").replaceAll("{amount}", roi!),
                        style: const TextStyle(fontSize: 16, color: Colors.white),
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

  Future<void> _predictSales() async {
    if (!_formKey.currentState!.validate()) return;

    final url = Uri.parse("http://10.0.2.2:5000/predict");

    final int marketSize = int.parse(targetMarketSizeController.text);
    final int price = int.parse(pricePointController.text);
    final int marketing = int.parse(marketingBudgetController.text);
    final int reach = int.parse(projectedReachController.text);
    final double rate = double.parse(selectedConversionRate!.replaceAll('%', '')) / 100;

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
        final double predictedSales = double.parse(data["predicted_sales"].toString());

        final double calculatedCustomers = reach * (rate / 0.01);
        final double calculatedRevenue = calculatedCustomers * price;
        final double calculatedROI = marketing == 0 ? 0 : ((calculatedRevenue - marketing) / marketing) * 100;

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
