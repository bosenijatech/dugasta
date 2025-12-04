// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// class StatementScreen extends StatefulWidget {
//   const StatementScreen({super.key});

//   @override
//   State<StatementScreen> createState() => _StatementScreenState();
// }

// class _StatementScreenState extends State<StatementScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Statement',
//           style: TextStyle(color: Colors.white),
//         ),
//       ),
//       body: Center(
//         child: Text('No Data!'),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

import '../presentation/util/app_colors.dart';

class StatementScreen extends StatefulWidget {
  const StatementScreen({super.key});

  @override
  State<StatementScreen> createState() => _StatementScreenState();
}

class _StatementScreenState extends State<StatementScreen> {
  // sample data
  final List<Map<String, dynamic>> items = [
    {
      "propertyName": "Green Residency",
      "unitName": "A101",
      "unitSegment": "Premium",
      "buildingSegment": "Tower 1",
      "priceLevel": "Level 1",
      "rate": 5000,
      "quantity": 10,
      "amount": 50000,
      "discount": 2500,
      "discountPercentage": 5,
      "grossAmount": 56050,
      "taxCode": "GST18",
      "taxPercentage": 18,
      "taxAmount": 8550,
      "description": "Spacious apartment with balcony",
      "department": "Sales",
      "propertyServiceType": "Full Service",
      "generateInvoice": true,
      "generateSchedule": false,
      "item": "Apartment"
    },
    {
      "propertyName": "Blue Heights",
      "unitName": "B202",
      "unitSegment": "Standard",
      "buildingSegment": "Tower 2",
      "priceLevel": "Level 2",
      "rate": 4000,
      "quantity": 5,
      "amount": 20000,
      "discount": 0,
      "discountPercentage": 0,
      "grossAmount": 22400,
      "taxCode": "GST12",
      "taxPercentage": 12,
      "taxAmount": 2400,
      "description": "Comfortable apartment",
      "department": "Sales",
      "propertyServiceType": "Partial Service",
      "generateInvoice": true,
      "generateSchedule": true,
      "item": "Apartment"
    },
  ];

  final List<bool> _expanded = [];

  @override
  void initState() {
    super.initState();
    _expanded.addAll(List.generate(items.length, (index) => false));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      appBar: AppBar(
        title: const Text('Statement',style: TextStyle(color: Colors.white),),
       backgroundColor: AppColor.primary,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 3,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Column(
                children: [
                  // Header with animated arrow
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: const Icon(Icons.home, color:  AppColor.primary),
                    ),
                    title: Text(
                      item['propertyName'] ?? '',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    subtitle: Text(
                        '${item['unitName']} • ${item['unitSegment']} | ${item['buildingSegment']}'),
                    trailing: AnimatedRotation(
                      turns: _expanded[index] ? 0.5 : 0,
                      duration: const Duration(milliseconds: 300),
                      child: Icon(
                        Icons.keyboard_arrow_down,
                        color: AppColor.primary,
                        size: 30,
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        _expanded[index] = !_expanded[index];
                      });
                    },
                  ),
                  // Expandable content
                  AnimatedCrossFade(
                    firstChild: Container(),
                    secondChild: Container(
                      padding: const EdgeInsets.all(16),
                      color: Colors.grey.shade50,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildFinancialRow('Rate',
                              'AED${item['rate']} x ${item['quantity']}'),
                          _buildFinancialRow('Amount', 'AED${item['amount']}'),
                          if (item['discount'] != null && item['discount'] > 0)
                            _buildFinancialRow(
                              'Discount',
                              'AED${item['discount']} (${item['discountPercentage'] ?? 0}%)',
                              valueColor: Colors.green,
                            ),
                          _buildFinancialRow(
                              'Gross', 'AED${item['grossAmount']}',
                              valueColor: Colors.blueAccent,
                              bold: true),
                          _buildFinancialRow(
                              'Tax',
                              '${item['taxCode']} - AED${item['taxAmount']} (${item['taxPercentage']}%)',
                              valueColor: Colors.orange),
                          const SizedBox(height: 10),
                          Text(
                              'Service Type: ${item['propertyServiceType']}'),
                          Text(
                              'Generate Invoice: ${item['generateInvoice']} | Schedule: ${item['generateSchedule']}'),
                          Text('Item Type: ${item['item']}'),
                          const SizedBox(height: 6),
                          Text('Description: ${item['description']}'),
                          Text('Department: ${item['department']}'),
                        ],
                      ),
                    ),
                    crossFadeState: _expanded[index]
                        ? CrossFadeState.showSecond
                        : CrossFadeState.showFirst,
                    duration: const Duration(milliseconds: 300),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFinancialRow(String title, String value,
      {Color valueColor = Colors.black, bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 14, color: Colors.grey)),
          Text(value,
              style: TextStyle(
                  fontSize: 14,
                  color: valueColor,
                  fontWeight: bold ? FontWeight.bold : FontWeight.normal)),
        ],
      ),
    );
  }
}

