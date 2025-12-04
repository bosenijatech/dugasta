import 'dart:convert';
import 'package:dugasta/presentation/module/landingpage/landingscreen.dart';
import 'package:flutter/material.dart';
import '../../../../data/api_service.dart';
import '../../../model/sales_estimatemodel.dart';
import '../../../util/app_colors.dart';
import '../../../util/app_utils.dart';
import '../../homepage/homepage.dart';
import 'addservicerequest.dart';

class SalesSevicerequest extends StatefulWidget {
  const SalesSevicerequest({super.key});

  @override
  State<SalesSevicerequest> createState() => _SalesSevicerequestState();
}

class _SalesSevicerequestState extends State<SalesSevicerequest> {
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
            context, jsonData['message'], "Ok", () => AppUtils.pop(context));
      }
    } catch (e) {
      setState(() => loading = false);
      AppUtils.showSingleDialogPopup(
          context, e.toString(), "Ok", () => AppUtils.pop(context));
    }
  }

  // 🔥 Reusable Text Row
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
    return WillPopScope(
       onWillPop: () async {
  Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => LandingScreenPage()),
);

    return false; 
  },
      child: Scaffold(
        backgroundColor: AppColor.lightCream,
        appBar: AppBar(
        backgroundColor: AppColor.primary,
        title: const Text(
      "Service Request",
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
        ),
           leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () {
          Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => LandingScreenPage()),
);

        },
      ),
        actions: [
      IconButton(
        icon: const Icon(
          Icons.add,   // 🔥 you can change this icon
          color: Colors.white,
        ),
        onPressed: () {
         
           Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>  Addservicerequest(),
                  ),
                );
        },
      ),
        ],
      ),
      
        body: loading
            ? const Center(child: CircularProgressIndicator())
            : estimateList.isEmpty
                ? const Center(child: Text("No estimate data"))
                : ListView.builder(
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: est.items!.map((item) {
                                return Card(
                                  color: Colors.white,
                                  elevation: 2,
                                  margin: const EdgeInsets.only(bottom: 12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // 🔥 Heading with Completed + Tick on right
                                        Row(
                                          children: const [
                                             Text(
                                              "Sales Support",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                             Spacer(),
                                             Icon(
                                              Icons.check_circle,
                                              color: Colors.green,
                                              size: 20,
                                            ),
                                             SizedBox(width: 5),
                                             Text(
                                              "Completed",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                                color: Colors.green,
                                              ),
                                            ),
                                          ],
                                        ),
      
                                        const SizedBox(height: 12),
      
                                        // 🔥 Info rows
                                        _infoRow("Customer", item.unitName),
                                        _infoRow("Property Name", item.propertyName),
                                    
                                        _infoRow("Date", "₹${item.amount ?? 0}"),
                                      ],
                                    ),
                                  ),
                                );
                              }).toList(),
                            )
                        ],
                      );
                    },
                  ),
      ),
    );
  }
}
