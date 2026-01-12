



import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../../../../data/api_service.dart';
import '../../../../domain/pref.dart';
import '../../../../widgets/custom_dropdown.dart';
import '../../../model/sales_unitnumbermodel.dart';
import '../../../model/viewunitstatementmodel.dart';
import '../../../util/app_colors.dart';
import '../../../util/app_utils.dart';

class SalesUnitstatement extends StatefulWidget {
  const SalesUnitstatement({super.key});

  @override
  State<SalesUnitstatement> createState() => _SalesUnitstatementState();
}

class _SalesUnitstatementState extends State<SalesUnitstatement> {
  bool loading = false;

  Unitnumlist? selectedUnitnumber;
  List<Unitnumlist> unitList = [];

  @override
  void initState() {
    super.initState();
    fetchunitnumber();
  }

  // ------------------ VIEW UNIT STATEMENT ------------------
  Future<void> viewunitstatement() async {
    var body = {
      "customerId": Prefs.getCustomerId("CustomerID").toString(),
      "unitId": selectedUnitnumber?.value,
      "subsidiaryId": Prefs.getSubsidiary("subsidiary").toString(),
    };

    setState(() => loading = true);

    try {
      final response = await Apiservice.viewunitstatement(body);

      setState(() => loading = false);

      if (response.statusCode != 200) {
        AppUtils.showSingleDialogPopup(
          context,
          "Server Error",
          "Ok",
          () => Navigator.pop(context),
        );
        return;
      }

      final decoded = jsonDecode(response.body);
      final model = Viewunitstatementmodel.fromJson(decoded);

      if (model.success != true) {
        AppUtils.showSnackbar(
          context: context,
          message: "No data found",
          backgroundColor: Colors.red,
        );
        return;
      }

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => SalesUnitstatementDetails(data: model.message),
        ),
      );
    } catch (e) {
      setState(() => loading = false);

      AppUtils.showSingleDialogPopup(
        context,
        "Something went wrong",
        "Ok",
        () => Navigator.pop(context),
      );
    }
  }

  // ------------------ FETCH UNIT NUMBERS ------------------
  Future<void> fetchunitnumber() async {
    final result = await Apiservice.getunitnum();
    if (result != null && result.success) {
      setState(() {
        unitList = result.payload;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.lightCream,
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        title: const Text(
          "Unit Statement",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Stack(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomDropdownWidget<Unitnumlist>(
                    valArr: unitList,
                    labelText: "Unit Number",
                    selectedItem: selectedUnitnumber,
                    labelField: (item) => item.text ?? "",
                    onChanged: (value) {
                      setState(() {
                        selectedUnitnumber = value;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  Material(
                    color: AppColor.accentColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: InkWell(
                      onTap: loading
                          ? null
                          : () {
                              if (selectedUnitnumber == null) {
                                AppUtils.showSnackbar(
                                  context: context,
                                  message: Text("Choose Unit Number"),
                                  backgroundColor: Colors.red,
                                );

                                return;
                              }
                              viewunitstatement();
                            },
                      child: const Padding(
                        padding: EdgeInsets.all(12),
                        child: Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ------------------ LOADING ------------------
          if (loading)
            Container(
              color: Colors.black.withOpacity(0.3),
              child: const Center(
                child: CircularProgressIndicator(color: Colors.white),
              ),
            ),
        ],
      ),
    );
  }
}

////////////////////////////////////////////////////////////////
/// DETAILS SCREEN WITH PDF DOWNLOAD
////////////////////////////////////////////////////////////////

class SalesUnitstatementDetails extends StatelessWidget {
  final Message data;

  const SalesUnitstatementDetails({
    super.key,
    required this.data,
  });

  // ------------------ PDF GENERATION ------------------



// Future<void> generatePdf() async {
//   final pdf = pw.Document();

//   final roboto = pw.Font.ttf(await rootBundle.load("assets/fonts/Roboto-Regular.ttf"));
//   final robotoBold = pw.Font.ttf(await rootBundle.load("assets/fonts/Roboto-Bold.ttf"));

//   pdf.addPage(
//     pw.MultiPage(
//       pageFormat: PdfPageFormat.a4,
//       build: (context) => [
//         pw.Text("STATEMENT OF ACCCOUNT", style: pw.TextStyle(font: robotoBold, fontSize: 22,), textAlign: pw.TextAlign.right, ),
       
//         pw.SizedBox(height: 10),
//           pw.Text("Building Name: ${data.property?.buildingName ?? '-'}", style: pw.TextStyle(font: roboto)),
//         pw.Text("Location: ${data.property?.location}", style: pw.TextStyle(font: roboto)),
//                 pw.Text("Apartment No: ${data.property?.apartmentNo ?? '-'}", style: pw.TextStyle(font: roboto)),
//                 pw.Text("Apartment Type: ${data.property?.apartmentType ?? '-'}", style: pw.TextStyle(font: roboto)),
//         pw.Text("Buyer(s) Name: ${data.buyerName}", style: pw.TextStyle(font: roboto)),
      

//         pw.SizedBox(height: 20),
        
//         pw.Table.fromTextArray(
//           headers: [ "S.No","Item", "Invoice No", "Date", "Amount", "Received", "Balance"],
//           data: data.transactions!.map((txn) => [
//             txn.item ?? "-",
//             txn.transactionnumber ?? "-",
//             txn.trandate ?? "-",
//             txn.amount?.toStringAsFixed(2) ?? "0.00",
//             txn.received?.toStringAsFixed(2) ?? "0.00",
//             txn.rtotal?.toStringAsFixed(2) ?? "0.00",
//           ]).toList(),
//           headerStyle: pw.TextStyle(font: robotoBold),
//           cellStyle: pw.TextStyle(font: roboto),
//         ),
//       ],
//     ),
//   );

//   await Printing.layoutPdf(onLayout: (format) => pdf.save());
// }



Future<void> generatePdf() async {
  final pdf = pw.Document();

  final roboto =
      pw.Font.ttf(await rootBundle.load("assets/fonts/Roboto-Regular.ttf"));
  final robotoBold =
      pw.Font.ttf(await rootBundle.load("assets/fonts/Roboto-Bold.ttf"));

  double totalAmount = 0;
  double totalReceived = 0;
  double totalBalance = 0;

  final List<pw.TableRow> rows = [];

  // ================= HEADER ROW =================
  rows.add(
    pw.TableRow(
      decoration: const pw.BoxDecoration(color: PdfColors.grey300),
      children: [
        headerCell("S.No", robotoBold),
        headerCell("Item", robotoBold),
        headerCell("Invoice No", robotoBold),
        headerCell("Date", robotoBold),
        headerCell("Amount", robotoBold),
        headerCell("Received", robotoBold),
        headerCell("Balance", robotoBold),
      ],
    ),
  );

  // ================= DATA ROWS =================
  for (int i = 0; i < data.transactions!.length; i++) {
    final txn = data.transactions![i];

    final amount = txn.amount ?? 0;
    final received = txn.received ?? 0;
    final balance = txn.rtotal ?? 0;

    totalAmount += amount;
    totalReceived += received;
    totalBalance += balance;

    rows.add(
      pw.TableRow(
        children: [
          cell((i + 1).toString(), roboto),
          cell(txn.item ?? "-", roboto),
          cell(txn.transactionnumber ?? "-", roboto),
          cell(txn.trandate ?? "-", roboto),
          cell(amount.toStringAsFixed(2), roboto),
          cell(received.toStringAsFixed(2), roboto),
          cell(balance.toStringAsFixed(2), roboto),
        ],
      ),
    );
  }

  // ================= TOTAL ROW =================
  rows.add(
    pw.TableRow(
      decoration: const pw.BoxDecoration(color: PdfColors.grey200),
      children: [
        cell("", roboto),
        cell("", roboto),
        cell("", roboto),
        cell("Total Balance To Received", robotoBold),
        cell(totalAmount.toStringAsFixed(2), robotoBold),
        cell(totalReceived.toStringAsFixed(2), robotoBold),
        cell(totalBalance.toStringAsFixed(2), robotoBold),
      ],
    ),
  );

  // ================= PDF PAGE =================
  pdf.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.all(24),
      build: (context) => [
        pw.Center(
          child: pw.Text(
            "STATEMENT OF ACCOUNT",
            style: pw.TextStyle(font: robotoBold, fontSize: 22),
          ),
        ),

        pw.SizedBox(height: 20),

        pw.Text(
            "Building Name: ${data.property?.buildingName ?? '-'}",
            style: pw.TextStyle(font: roboto)),
             pw.SizedBox(height: 2),
        pw.Text(
            "Location: ${data.property?.location ?? '-'}",
            style: pw.TextStyle(font: roboto)),
             pw.SizedBox(height: 2),
        pw.Text(
            "Apartment No: ${data.property?.apartmentNo ?? '-'}",
            style: pw.TextStyle(font: roboto)),
             pw.SizedBox(height: 2),
        pw.Text(
            "Apartment Type: ${data.property?.apartmentType ?? '-'}",
            style: pw.TextStyle(font: roboto)),
             pw.SizedBox(height: 2),
        pw.Text(
            "Buyer(s) Name: ${data.buyerName ?? '-'}",
            style: pw.TextStyle(font: roboto)),

        pw.SizedBox(height: 20),

        // ================= TABLE =================
        pw.Table(
          border: pw.TableBorder.all(color: PdfColors.grey),
          columnWidths: {
            0: const pw.FixedColumnWidth(35),
            1: const pw.FlexColumnWidth(2),
            2: const pw.FlexColumnWidth(2),
            3: const pw.FixedColumnWidth(70),
            4: const pw.FixedColumnWidth(65),
            5: const pw.FixedColumnWidth(65),
            6: const pw.FixedColumnWidth(65),
          },
          children: rows,
        ),
        pw.SizedBox(height: 8),
 pw.Align(
  alignment: pw.Alignment.centerLeft,
  child: pw.Text(
    "Note: Penalties, if applicable, will be applied in accordance with the agreed terms and conditions.",
    style: pw.TextStyle(
      font: roboto,
      fontSize: 12,
    ),
  ),
),
        pw.SizedBox(height: 50),
 pw.Align(
  alignment: pw.Alignment.centerLeft,
  child: pw.Text(
    "Prepared By",
    style: pw.TextStyle(
      font: robotoBold,
      fontSize: 16,
    ),
  ),
),

      ],
    ),
  );

  await Printing.layoutPdf(
    onLayout: (PdfPageFormat format) async => pdf.save(),
  );
}

// ================= CELL HELPERS =================

pw.Widget headerCell(String text, pw.Font font) {
  return pw.Padding(
    padding: const pw.EdgeInsets.all(6),
    child: pw.Text(
      text,
      style: pw.TextStyle(font: font, fontSize: 10),
      textAlign: pw.TextAlign.center,
      maxLines: 1,
    ),
  );
}

pw.Widget cell(String text, pw.Font font) {
  return pw.Padding(
    padding: const pw.EdgeInsets.all(6),
    child: pw.Text(
      text,
      style: pw.TextStyle(font: font, fontSize: 10),
      textAlign: pw.TextAlign.center,
      maxLines: 1, // ✅ NO second line
      overflow: pw.TextOverflow.clip,
    ),
  );
}


  Widget _row(String title, String? value, {Color valueColor = Colors.black}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
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
    return Scaffold(
      backgroundColor: AppColor.lightCream,
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        title: const Text(
          "Unit Statement Overview",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.download, color: Colors.white),
            onPressed: generatePdf,
            tooltip: "Download PDF",
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          // ---------------- HEADER ----------------
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  _row("Buyer", data.buyerName),
                  _row("Building", data.property?.buildingName),
                  _row("Apartment No", data.property?.apartmentNo),
                  _row("Location", data.property?.location),
                  _row("Apartment Type", data.property?.apartmentType),
                  _row("Area", data.property?.area),
                  _row("Balance",
                      "AED ${data.summary?.balance!.toStringAsFixed(2)}",
                      valueColor: Colors.blue),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),
          Text(
            "Transactions",
            style: TextStyle(
                fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          // ---------------- TRANSACTIONS ----------------
          ...data.transactions!.map((txn) {
            return Card(
              elevation: 2,
              margin: const EdgeInsets.only(bottom: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    _row("Item", txn.item),
                    _row("Transaction No", txn.transactionnumber),
                    _row("Date", txn.trandate),
                    _row("Amount", "AED ${txn.amount!.toStringAsFixed(2)}", valueColor: Colors.blue),
                    _row("Received", "AED ${txn.received!.toStringAsFixed(2)}", valueColor: Colors.blue),
                    _row("Total", "AED ${txn.rtotal!.toStringAsFixed(2)}", valueColor: Colors.blue),
                  ],
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}


