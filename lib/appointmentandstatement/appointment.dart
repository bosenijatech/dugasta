
import 'package:flutter/material.dart';

import '../presentation/util/app_colors.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({super.key});

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  final List<Map<String, dynamic>> items = const [
    {
      "property Name": "Sunshine Residency",
      "unit Name": "A-102",
      "price Level": "Premium",
      "quantity": 2,
      "rate": 25000,
      "amount": 50000,
      "description": "2BHK Flat Rent",
      "department": "Leasing",
      "discount": 2000,
      "discount Percentage": 5,
      "discountAmount": 2000,
      "serviceInvoice": "Yes",
      "propertyService Type": "Residential",
      "generateInvoice": "Yes",
      "generateSchedule": "Monthly",
      "item": "Flat Rent",
      "gross Amount": 52000,
      "unit Segment": "Middle Floor",
      "building Segment": "Tower A",
      "taxCode": "GST18",
      "taxPercentage": 18,
      "taxAmount": 9000,
      "estimatedGross Profit": 15000,
      "estimatedGross Percent": 28.8,
    },
    {
      "property Name": "Ragava Hotel",
      "unit Name": "B-102",
      "price Level": "Standard",
      "quantity": 2,
      "rate": 25000,
      "amount": 50000,
      "description": "1BHK Flat Rent",
      "department": "Leasing",
      "discount": 2000,
      "discount Percentage": 5,
      "discountAmount": 2000,
      "serviceInvoice": "Yes",
      "propertyService Type": "Residential",
      "generateInvoice": "Yes",
      "generateSchedule": "Monthly",
      "item": "Flat Rent",
      "gross Amount": 52000,
      "unit Segment": "First Floor",
      "building Segment": "Tower B",
      "taxCode": "GST18",
      "taxPercentage": 18,
      "taxAmount": 9000,
      "estimatedGross Profit": 15000,
      "estimatedGross Percent": 28.8,
    },
  ];

  Widget _buildRow(String key, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 4,
            child: Text(
              key,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.black54,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Flexible(
            flex: 6,
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.bgColor,
      appBar: AppBar(
        
        title: const Text(
          "Reservation Items",
          style: TextStyle(color: Colors.white),
        ),
       backgroundColor: AppColor.primary,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 3,
            child: Theme(
              data: Theme.of(context).copyWith(
                dividerColor: Colors.transparent, // ❌ hide top/bottom line
              ),
              child: ExpansionTile(
                tilePadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                title: Text(
                  "${item["property Name"]} • ${item["unit Name"]}",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  "${item["building Segment"]} | ${item["unit Segment"]}",
                ),
                trailing: const Icon(Icons.keyboard_arrow_down,
                    color: Colors.teal),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: item.entries
                          .map((e) => _buildRow(e.key, e.value.toString()))
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
