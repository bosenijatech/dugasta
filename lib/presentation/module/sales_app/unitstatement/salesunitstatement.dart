import 'dart:convert';
import 'package:flutter/material.dart';
import '../../../../data/api_service.dart';
import '../../../model/sales_estimatemodel.dart';
import '../../../util/app_colors.dart';
import '../../../util/app_utils.dart';

// ---------------------------------------------------------
//                 MAIN UNIT STATEMENT SCREEN
// ---------------------------------------------------------
class SalesUnitstatement extends StatefulWidget {
  const SalesUnitstatement({super.key});

  @override
  State<SalesUnitstatement> createState() => _SalesUnitstatementState();
}

class _SalesUnitstatementState extends State<SalesUnitstatement> {
  bool loading = false;
  List<SalesestimateList> estimateList = [];

  @override
  void initState() {
    super.initState();
    getsestimate();
  }

  void getsestimate() async {
    setState(() => loading = true);
    try {
      final response = await Apiservice.getsalesestimate();
      final jsonData = jsonDecode(response.body);

      if (response.statusCode == 200 &&
          jsonData['status'].toString() == "true") {
        SalesestimateModel model = SalesestimateModel.fromJson(jsonData);
        setState(() {
          estimateList = model.data;
          loading = false;
        });
      } else {
        setState(() => loading = false);
        AppUtils.showSingleDialogPopup(
          context,
          jsonData['message'],
          "Ok",
          () => AppUtils.pop(context),
        );
      }
    } catch (e) {
      setState(() => loading = false);
      AppUtils.showSingleDialogPopup(
        context,
        e.toString(),
        "Ok",
        () => AppUtils.pop(context),
      );
    }
  }

  // reusable row widget
  Widget _infoRow(String title, String? value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              "$title:",
              style: const TextStyle(color: Colors.grey),
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(
              value ?? "-",
              style: const TextStyle(fontWeight: FontWeight.w600),
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
        title: const Text(
          "Unit Statement",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : estimateList.isEmpty
              ? const Center(child: Text("No estimate data"))
              : 
            ListView.builder(
  padding: const EdgeInsets.all(10),
  itemCount: estimateList.length,
  itemBuilder: (context, index) {
    final est = estimateList[index];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (est.items == null || est.items!.isEmpty)
          const Text("No items available")
        else
          Column(
            children: est.items!.map((item) {
              return 
              GestureDetector(
                    onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => SalesUnitstatementDetails(
                                    reservation: est,
                                  ),
                                ),
                              );
                            },
                child: Card(
                      color: Colors.white,
                  elevation: 1,
                             
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,

                      children: [
                        // Text column
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _infoRow("Unit Name", item.unitName),
                              _infoRow("Unit Type", item.propertyName),
                              _infoRow(
                                "Status",
                                "₹${item.amount?.toString() ?? "-"}",
                              ),
                              _infoRow(
                                "Amount",
                                item.propertyServiceType ?? "-",
                              ),
                            ],
                          ),
                        ),
                        // Arrow icon
                        Material(
                          color: AppColor.accentColor,
                           shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          elevation: 1,
                          child: InkWell(
                            customBorder: const RoundedRectangleBorder(),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => SalesUnitstatementDetails(
                                    reservation: est,
                                  ),
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
            }).toList(),
          ),
      ],
    );
  },
)

    );
  }
}

// ---------------------------------------------------------
//                 DETAILS PAGE SCREEN
// ---------------------------------------------------------

class SalesUnitstatementDetails extends StatelessWidget {
  final SalesestimateList reservation;

  const SalesUnitstatementDetails({super.key, required this.reservation});

  Widget _row(String title, String? value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              "$title:",
              style: const TextStyle(color: Colors.grey),
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(
              value ?? "-",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
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
        title: const Text(
          "Unit Statement Overview",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(4),
        children: reservation.items!.map((item) {
          return Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _row("Customer", item.unitName),
                  _row("Property", item.propertyName),
                  _row("Amount", "₹${item.amount.toString()}"),
                  _row("Date", item.item),
                  _row("Description", item.item ?? "-"),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
