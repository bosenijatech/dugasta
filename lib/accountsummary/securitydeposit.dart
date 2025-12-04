import 'package:dugasta/presentation/util/app_colors.dart';
import 'package:dugasta/presentation/util/app_utils.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class SecurityDepositPage extends StatelessWidget {
  const SecurityDepositPage({super.key});

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
              AppUtils.buildNormalText(text: "Security Deposit!", fontSize: 18),
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
          itemCount: 1,
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
          backgroundColor: Colors.grey.shade300,
          title: Text(
            "25 / ${02 + index + 1} / 2024",
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
          ),
          children: [
            Container(
                margin: EdgeInsets.only(top: 10, bottom: 30, right: 5, left: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
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
                              AppUtils.buildNormalText(text: "Unit No"),
                              AppUtils.buildNormalText(text: "")
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              AppUtils.buildNormalText(text: "Building No"),
                              AppUtils.buildNormalText(text: "")
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
                              AppUtils.buildNormalText(text: "Contract No"),
                              AppUtils.buildNormalText(text: "00934334343")
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              AppUtils.buildNormalText(text: "Description"),
                              AppUtils.buildNormalText(text: "Security Deposit")
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.grey.shade200,
                      padding: EdgeInsets.all(5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppUtils.buildNormalText(text: "Hold"),
                              AppUtils.buildNormalText(text: "Refund")
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              AppUtils.buildNormalText(text: "397884.00"),
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
