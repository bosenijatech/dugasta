import 'package:dugasta/presentation/util/app_colors.dart';
import 'package:dugasta/presentation/util/app_utils.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class Accountsummary extends StatelessWidget {
  const Accountsummary({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppUtils.buildNormalText(
            text: "Account Statement", fontSize: 18, color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [accountdetails(context)],
        ),
      ),
    );
  }

  Widget accountdetails(context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          DropdownSearch<String>(
            popupProps: PopupProps.menu(
              showSelectedItems: true,
            ),
            items: const [
              "Account Summary",
              "Cheque Details",
              "Standing Instruction",
              'Security Deposit'
            ],
            onChanged: print,
            selectedItem: "",
          ),
          SizedBox(
            height: 10,
          ),
          AppUtils.buildNormalText(text: "Time Period", fontSize: 16),
          SizedBox(
            height: 5,
          ),
          DropdownSearch<String>(
            popupProps: PopupProps.menu(
              showSelectedItems: true,
            ),
            items: const ["Last Year", "Last 3 months", "Last Month", 'Custom'],
            onChanged: print,
            selectedItem: "",
          ),
          SizedBox(
            height: 10,
          ),
          Container(
              margin: EdgeInsets.only(top: 24),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColor.greyShade3, width: 1),
              ),
              child: Column(
                children: [
                  // Header
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    decoration: BoxDecoration(
                      color: AppColor.greyShade1,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10)),
                    ),
                    // Content
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: const [
                        Text('Account Summary (AED)',
                            style: TextStyle(
                              color: AppColor.black,
                              fontWeight: FontWeight.w600,
                            )),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppUtils.buildNormalText(
                                text: "Opening Balance", fontSize: 16),
                            AppUtils.buildNormalText(
                                text: "Closing Balance", fontSize: 16)
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppUtils.buildNormalText(
                                text: "36,600.00",
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                            AppUtils.buildNormalText(
                                text: "0.00",
                                fontSize: 16,
                                fontWeight: FontWeight.bold)
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
