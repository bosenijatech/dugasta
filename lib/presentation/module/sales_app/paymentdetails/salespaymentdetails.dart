
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import '../../../../data/api_service.dart';
// import '../../../model/sales_paymentmodel.dart';
// import '../../../util/app_colors.dart';
// import '../../../util/app_utils.dart';

// class Salespaymentdetails extends StatefulWidget {
//   const Salespaymentdetails({super.key});

//   @override
//   State<Salespaymentdetails> createState() => _SalespaymentdetailsState();
// }

// class _SalespaymentdetailsState extends State<Salespaymentdetails> with TickerProviderStateMixin {
//   bool loading = false;
//   List<SalespaymentList> paymentList = [];
//   late TabController _tabController;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 2, vsync: this);
//     getPayments();
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }

//   void getPayments() async {
//     setState(() => loading = true);
//     try {
//       final response = await Apiservice.getsalespayment();
//       final jsonData = jsonDecode(response.body);

//       if (response.statusCode == 200 && jsonData['status'].toString() == "true") {
//         SalespaymentdetailsModel model = SalespaymentdetailsModel.fromJson(jsonData);
//         setState(() {
//           paymentList = model.data;
//           loading = false;
//         });
//       } else {
//         setState(() => loading = false);
//         AppUtils.showSingleDialogPopup(context, jsonData['message'].toString(), "Ok", exitPopup);
//       }
//     } catch (e) {
//       setState(() => loading = false);
//       AppUtils.showSingleDialogPopup(context, e.toString(), "Ok", exitPopup);
//     }
//   }

//   void exitPopup() => AppUtils.pop(context);

//   // Info row like reservation screen
//   Widget _infoRow(String title, dynamic value) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 6),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Expanded(
//             child: Text(
//               "$title: ",
//               style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
//             ),
//           ),
//           Expanded(
//             flex: 2,
//             child: Text(
//               value?.toString() ?? "-",
//               style: const TextStyle(fontSize: 13, color: Colors.black87),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // Overview Tab → general payment info per customer
//   Widget _overviewTab() {
//     return ListView.builder(
//       padding: const EdgeInsets.all(16),
//       itemCount: paymentList.length,
//       itemBuilder: (context, index) {
//         final data = paymentList[index];
//         return Card(
//           margin: const EdgeInsets.only(bottom: 16),
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//           elevation: 2,
//           child: Padding(
//             padding: const EdgeInsets.all(12),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(data.customerName ?? "No Name", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
//                 const Divider(),
//                 _infoRow("Building", data.buildingName),
//                 _infoRow("Unit Name", data.unitName),
//                 _infoRow("Contract Value", data.contractValue != null ? "₹${data.contractValue!.toStringAsFixed(2)}" : "-"),
//                 _infoRow("Contract Basis", data.contractBasis),
//                 _infoRow("Payment Type", data.paymentType),
//                 _infoRow("Transaction Type", data.transactionType),
//                 _infoRow("Approval Status", data.approvalStatus),
//                 _infoRow("Date", data.date != null ? data.date!.toLocal().toString().split(' ')[0] : "-"),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// // Details Tab → group by customer, show name once, multiple cards
// Widget _detailsTab() {
//   return ListView.builder(
//     padding: const EdgeInsets.all(16),
//     itemCount: paymentList.length,
//     itemBuilder: (context, index) {
//       final data = paymentList[index];
//       final detailsList = data.detailsInfo ?? [];

//       if (detailsList.isEmpty) {
//         return Card(
//           margin: const EdgeInsets.only(bottom: 16),
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//           elevation: 2,
//           child: Padding(
//             padding: const EdgeInsets.all(12),
//             child: Text(data.customerName ?? "No Name", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
//           ),
//         );
//       }

//       return Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Customer Name Header (displayed once)
//           Padding(
//             padding: const EdgeInsets.only(bottom: 8),
//             child: Text(
//               data.customerName ?? "No Name",
//               style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//           ),

//           // Cards for each detail
//           ...detailsList.map((d) {
//             return Card(
//               margin: const EdgeInsets.only(bottom: 12),
//               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//               elevation: 1,
//               child: Padding(
//                 padding: const EdgeInsets.all(12),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     _infoRow("Installment Type", d.installmentType),
//                     _infoRow("Amount", d.amount != null ? "₹${d.amount}" : "-"),
//                     _infoRow("Payment Mode", d.paymentMode),
//                     _infoRow("Check Status", d.checkStatus),
//                     _infoRow("Unit Segment", d.unitSegment),
//                     _infoRow("Building Segment", d.buildingSegment),
//                     _infoRow("Receipt Created", d.receiptCreated),
//                   ],
//                 ),
//               ),
//             );
//           }).toList(),
//         ],
//       );
//     },
//   );
// }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColor.bgColor,
//       appBar: AppBar(
//         backgroundColor: AppColor.primary,
//         title: const Text("Sales Payment", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
//         bottom: TabBar(
//           controller: _tabController,
//           indicatorColor: Colors.white,
//           labelColor: Colors.white,
//           unselectedLabelColor: Colors.white70,
//           tabs: const [
//             Tab(text: "Overview"),
//             Tab(text: "Details"),
//           ],
//         ),
//       ),
//       body: loading
//           ? const Center(child: CircularProgressIndicator())
//           : paymentList.isEmpty
//               ? const Center(child: Text("No Payment Found", style: TextStyle(color: Colors.grey, fontSize: 15)))
//               : TabBarView(
//                   controller: _tabController,
//                   children: [
//                     _overviewTab(),
//                     _detailsTab(),
//                   ],
//                 ),
//     );
//   }
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import '../../../../data/api_service.dart';
import '../../../model/sales_paymentmodel.dart';
import '../../../util/app_colors.dart';
import '../../../util/app_utils.dart';

class Salespaymentdetails extends StatefulWidget {
  const Salespaymentdetails({super.key});

  @override
  State<Salespaymentdetails> createState() => _SalespaymentdetailsState();
}

class _SalespaymentdetailsState extends State<Salespaymentdetails>
    with TickerProviderStateMixin {
  bool loading = false;
  List<SalespaymentList> paymentList = [];

  @override
  void initState() {
    super.initState();
    getPayments();
  }

  void getPayments() async {
    setState(() => loading = true);
    try {
      final response = await Apiservice.getsalespayment();
      final jsonData = jsonDecode(response.body);

      if (response.statusCode == 200 && jsonData['status'].toString() == "true") {
        SalespaymentdetailsModel model = SalespaymentdetailsModel.fromJson(jsonData);
        setState(() {
          paymentList = model.data;
          loading = false;
        });
      } else {
        setState(() => loading = false);
        AppUtils.showSingleDialogPopup(
            context, jsonData['message'].toString(), "Ok", () => AppUtils.pop(context));
      }
    } catch (e) {
      setState(() => loading = false);
      AppUtils.showSingleDialogPopup(context, e.toString(), "Ok", () => AppUtils.pop(context));
    }
  }

  Widget _infoRow(String title, dynamic value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              flex: 3,
            child: Text(
              
              "$title: ",
              style: const TextStyle( color: Colors.grey,),
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(
              value?.toString() ?? "-",
              style: const TextStyle(   fontWeight: FontWeight.w600,),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: AppColor.lightCream,
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        title: const Text("Sales Payment",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : paymentList.isEmpty
              ? const Center(
                  child: Text("No Payment Found",
                      style: TextStyle(color: Colors.grey, fontSize: 15)))
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: paymentList.length,
                  itemBuilder: (context, index) {
                    final data = paymentList[index];
                    return 
                  GestureDetector(
                    
                    onTap: () {
                       Navigator.push(
                                    context,
                                    MaterialPageRoute(
                    builder: (_) => PaymentDetailPage(payment: data),
                                    ),
                                  );
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      margin: const EdgeInsets.only(bottom: 16),
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          children: [
                            // Centered text section
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data.customerName ?? "No Name",
                                    style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                                  ),
                                  const SizedBox(height: 4),
                                  _infoRow("Building", data.buildingName),
                                ],
                              ),
                            ),
                    
                            // Stylish arrow button
                            Material(
                              color: AppColor.accentColor,
                               shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadiusGeometry.all(
                                        Radius.circular(5))),
                              elevation: 3,
                              child: InkWell(
                                customBorder: const RoundedRectangleBorder(),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                    builder: (_) => PaymentDetailPage(payment: data),
                                    ),
                                  );
                                },
                                child: const Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Icon(
                                    Icons.arrow_forward,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );

                  }),
    );
  }
}

// Payment Detail Page with TabBar


class PaymentDetailPage extends StatefulWidget {
  final SalespaymentList payment;
  const PaymentDetailPage({super.key, required this.payment});

  @override
  State<PaymentDetailPage> createState() => _PaymentDetailPageState();
}

class _PaymentDetailPageState extends State<PaymentDetailPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget _infoRow(String title,  String? value, {Color valueColor = Colors.black}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
             flex: 3,
              child: Text("$title: ",
                  style: const TextStyle(color: Colors.grey))),
        Expanded(
          flex: 5,
          child: Text(
            value ?? '-',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: valueColor, 
            ),
          ),
        ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.payment;
    final detailsList = data.detailsInfo ?? [];

    return Scaffold(
            backgroundColor: AppColor.lightCream,
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        title: Text(
          data.customerName ?? "Payment Detail",
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),

      // ---------------- BODY WITH TABBAR ----------------
      body: Column(
        children: [
          Container(
              padding: const EdgeInsets.symmetric(vertical: 6),
         color: AppColor.lightCream,
            child: TabBar(
              controller: _tabController,
              labelColor: Colors.white,
               unselectedLabelColor: Colors.black,
              indicator: BoxDecoration(
      color: AppColor.accentColor,
      borderRadius: BorderRadius.circular(12),
    ),
      indicatorPadding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
    labelPadding: EdgeInsets.zero,

               indicatorSize: TabBarIndicatorSize.tab,
              dividerColor: Colors.transparent,
              tabs: const [
                Tab(text: "Overview"),
                Tab(text: "Details"),
              ],
            ),
          ),

          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // ---------------- Overview Tab ----------------
                ListView(
                  padding: const EdgeInsets.all(4),
                  children: [
                    Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                 
                      child: Padding(
                        padding: const EdgeInsets.all(14),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _infoRow("Building", data.buildingName),
                            _infoRow("Unit Name", data.unitName.toString().split('.').last),
                            _infoRow(
                                "Contract Value",
                                data.contractValue != null
                                    ? "AED ${data.contractValue!.toStringAsFixed(2)}"
                                    : "", valueColor: AppColor.blue),
                            _infoRow("Contract Basis", data.contractBasis),
                            // _infoRow("Payment Type", data.paymentType),
                            _infoRow("Transaction Type", data.transactionType),
                            _infoRow("Approval Status", data.approvalStatus),
                            _infoRow(
                                "Date",
                                data.date != null
                                    ? data.date!
                                        .toLocal()
                                        .toString()
                                        .split(' ')[0]
                                    : "-"),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                // ---------------- Details Tab ----------------
                detailsList.isEmpty
                    ? const Center(child: Text("No details available"))
                    : ListView(
                        padding: const EdgeInsets.all(4),
                        children: detailsList.map((d) {
                          return Card(
                          color: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            elevation: 1,
                            child: Padding(
                              padding: const EdgeInsets.all(14),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _infoRow(
                                      "Installment Type", d.installmentType),
                                  _infoRow(
                                      "Amount",
                                      d.amount != null
                                          ? "AED ${d.amount!.toStringAsFixed(2)}"
                                          : "-",valueColor: AppColor.blue),
                                  _infoRow("Payment Mode", d.paymentMode),
                                  _infoRow("Check Status", d.checkStatus),
                                  _infoRow("Unit Segment", d.unitSegment.toString().split('.').last),

                                  // _infoRow(
                                  //     "Building Segment", d.buildingSegment),
                                  _infoRow(
                                      "Contract", d.contract.toString().split('.').last),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
