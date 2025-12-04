



import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../data/api_service.dart';
import '../../../model/sales_reservationmodel.dart';
import '../../../util/app_colors.dart';
import '../../../util/app_utils.dart';

// ---------------- List Page ----------------
class Salesreservation extends StatefulWidget {
  const Salesreservation({super.key});

  @override
  State<Salesreservation> createState() => _SalesreservationState();
}

class _SalesreservationState extends State<Salesreservation> {
  bool loading = false;
  List<SalesreservationList> reservationList = [];

  @override
  void initState() {
    super.initState();
    fetchReservations();
  }

  void fetchReservations() async {
    setState(() => loading = true);
    try {
      final response = await Apiservice.getsalesreservation();
      final jsonData = jsonDecode(response.body);

      if (response.statusCode == 200 && jsonData['status'].toString() == "true") {
        final model = SalesreservationModel.fromJson(jsonData);
        setState(() {
          reservationList = model.data;
          loading = false;
        });
      } else {
        setState(() => loading = false);
        AppUtils.showSingleDialogPopup(context, jsonData['message'].toString(), "Ok", () => AppUtils.pop(context));
      }
    } catch (e) {
      setState(() => loading = false);
      AppUtils.showSingleDialogPopup(context, e.toString(), "Ok", () => AppUtils.pop(context));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
         backgroundColor: AppColor.lightCream,
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        title: const Text("Sales Reservations", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white)),
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : reservationList.isEmpty
              ? const Center(child: Text("No Reservations Found", style: TextStyle(color: Colors.grey)))
              : ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: reservationList.length,
                  itemBuilder: (context, index) {
                    final res = reservationList[index];
                    return 
GestureDetector(
  onTap: () {
     Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        SalesReservationDetailPage(reservation: res),
                  ),
                );
  },
  child: Card(
      color: Colors.white,
  
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    elevation: 1,
    child: Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          // Centered Text Section
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  res.customerName ?? "No Name",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 6),
             Row(
  children: [
    Expanded(
         flex: 3,
      child: Text(
        "Estimate ID: ",
        style: TextStyle(
        
      
           color: Colors.grey,
        ),
      ),
    ),
    Expanded(
        flex: 5,
      child: Text(
        res.orderId ?? "-",
        style: TextStyle(
        fontWeight: FontWeight.w600,
        ),
        overflow: TextOverflow.ellipsis, // prevents overflow
      ),
    ),
  ],
)

              ],
            ),
          ),
  
          // Stylish Arrow
          Material(
            color: AppColor.accentColor,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.all(
                                        Radius.circular(5))
            ),
            elevation: 1,
            child: InkWell(
              customBorder: const RoundedRectangleBorder(),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        SalesReservationDetailPage(reservation: res),
                  ),
                );
              },
              child: const Padding(
                padding: EdgeInsets.all(10), // circular size
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

                  },
                ),
    );
  }
}

// ---------------- Detail Page ----------------


class SalesReservationDetailPage extends StatefulWidget {
  final SalesreservationList reservation;
  const SalesReservationDetailPage({super.key, required this.reservation});

  @override
  State<SalesReservationDetailPage> createState() => _SalesReservationDetailPageState();
}

class _SalesReservationDetailPageState extends State<SalesReservationDetailPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget _infoRow(String title, String?value,{Color valueColor = Colors.black}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Expanded(flex: 3, child: Text("$title:", style: const TextStyle(    color: Colors.grey,))),
          Expanded(
            flex: 5,
            child: Text(
              value ?? "-",
              style:  TextStyle(fontWeight: FontWeight.w600,  color: valueColor, ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _overviewTab() {
    final data = widget.reservation;
    final dateFormat = DateFormat('dd MMM yyyy');
    return ListView(
      padding: const EdgeInsets.all(4),
      children: [
        Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              
                _infoRow("Reservation ID", data.orderId ?? "-"),
                _infoRow("Property Name", data.propertyName ?? "-"),
                _infoRow("Unit Type", data.unitType ?? "-"),
                _infoRow("Unit Name", data.unitName ?? "-"),
              
                _infoRow("Agent Name", data.agentName ??"_"),
                _infoRow("Estimate Amount", "AED ${data.total!.toStringAsFixed(2)}" ?? "",valueColor: Colors.blue),
                _infoRow("Pricing Plan Name", data.pricingPlanName ?? "-"),
                _infoRow("Status", data.approvalStatus ?? "-"),
                _infoRow("Created from", data.createdFrom ?? "-"),
             
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _itemsTab() {
    final data = widget.reservation;
    if (data.items == null || data.items!.isEmpty) return const Center(child: Text("No items available"));
    return ListView(
      padding: const EdgeInsets.all(4),
      children: data.items!.map((item) {
        return Card(
           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.item ?? "Item", style: const TextStyle(    fontWeight: FontWeight.w600,fontSize: 16)),
                const SizedBox(height: 6),
                _infoRow("Unit Name", item.unitName.toString() ?? ""),
                _infoRow("Property Name", item.propertyName.toString() ?? ""),
                _infoRow("Tax Percent", "${item.taxPercentage}%"?? "-"),
                _infoRow("Amount", "AED ${item.grossAmount?.toStringAsFixed(2) ?? '0.00'}",valueColor: Colors.blue),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _pricingTab() {
    final data = widget.reservation;
    if (data.pricingSchedule == null || data.pricingSchedule!.isEmpty)
      return const Center(child: Text("No pricing schedule found"));
    return ListView(
      padding: const EdgeInsets.all(4),
      children: data.pricingSchedule!.map((ps) {
        return Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(ps.installmentNumber ?? "Installment", style: const TextStyle(    fontWeight: FontWeight.w600,fontSize: 16)),
                SizedBox(height: 4,),
                _infoRow("Percentage", "${ps.pricingPercent ?? 0}%"),
                _infoRow("Amount", "AED ${ps.amount?.toStringAsFixed(2) ?? '0.00'}",valueColor: Colors.blue),
              
            
                // _infoRow("Stage", ps.stageName?.toString().split('.').last ?? "-"),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
@override
Widget build(BuildContext context) {
  return Scaffold(
      backgroundColor: AppColor.lightCream,
    appBar: AppBar(
      backgroundColor: AppColor.primary,
      title: Text(
        widget.reservation.customerName ?? "Reservation",
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
    ),
    body: Column(
      children: [
        // TabBar inside body
               Container(
            color: AppColor.lightCream,
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: TabBar(
              isScrollable: false,
              controller: _tabController,
              indicator: BoxDecoration(
                color: AppColor.accentColor,
                borderRadius: BorderRadius.circular(12),
              ),
              labelColor: AppColor.white,
              unselectedLabelColor: AppColor.primary,
              indicatorSize: TabBarIndicatorSize.tab,
              dividerColor: Colors.transparent,
              indicatorPadding:
                  const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
              labelPadding: EdgeInsets.zero,
              tabs: const [
                Tab(text: "Overview"),
                Tab(text: "Items"),
                Tab(text: "Pricing"),
              ],
            ),
          ),
        // TabBarView takes remaining space
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              _overviewTab(),
              _itemsTab(),
              _pricingTab(),
            ],
          ),
        ),
      ],
    ),
  );
}
}