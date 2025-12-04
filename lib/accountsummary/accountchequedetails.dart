import 'package:dugasta/presentation/util/app_colors.dart';
import 'package:dugasta/presentation/util/app_utils.dart';
import 'package:flutter/material.dart';

class AccountChequeDetailsPage extends StatelessWidget {
  const AccountChequeDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppUtils.buildNormalText(
            text: "Account Statement", fontSize: 18, color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppUtils.buildNormalText(text: "Cheque Details!", fontSize: 18),
              accountdetails(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget accountdetails(context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) {
            return _buildPlayerModelList(index);
          }),
    );
  }

  Widget _buildPlayerModelList(index) {
    return Card(
      child: Theme(
        data: ThemeData().copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          title: Text(
            "25 / ${02 + index + 1} / 2024",
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
          ),
          children: [
            Container(
                margin: EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: AppColor.greyShade3, width: 1),
                ),
                child: Column(
                  children: [
                    // Header
                    Container(
                      padding: EdgeInsets.all(5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppUtils.buildNormalText(text: "Receipt No"),
                              AppUtils.buildNormalText(text: "Payment Token")
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              AppUtils.buildNormalText(text: "Z93/0300/5126"),
                              AppUtils.buildNormalText(text: "9900900113052626")
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppUtils.buildNormalText(text: "Due Date"),
                              AppUtils.buildNormalText(text: "25/06/2024")
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              AppUtils.buildNormalText(text: "Status"),
                              AppUtils.buildNormalText(text: "Pending")
                            ],
                          ),
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
                              AppUtils.buildNormalText(text: "Unleash Amount"),
                              AppUtils.buildNormalText(text: "397884.00")
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              AppUtils.buildNormalText(text: "Other Amount"),
                              AppUtils.buildNormalText(text: "0.00")
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
