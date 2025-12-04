import 'package:dugasta/presentation/model/requesttypemodel.dart';
import 'package:dugasta/presentation/model/viewrequestmodel.dart';
import 'package:dugasta/presentation/util/app_colors.dart';
import 'package:dugasta/presentation/util/app_utils.dart';
import 'package:dugasta/presentation/util/appcontants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TicketDetailsView extends StatefulWidget {
  ViewReqModel model;
  final int? position;
  TicketDetailsView({super.key, required this.position, required this.model});

  @override
  State<TicketDetailsView> createState() => _TicketDetailsViewState();
}

class _TicketDetailsViewState extends State<TicketDetailsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        title: Text(
          'Ticket Details',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            widget.model.message != null
                ? getticketdetailsview()
                : Center(
                    child: Text('No Data!'),
                  ),
            getattachment()
            // Container(
            //   color: AppColor.greyShade1,
            //   padding: EdgeInsets.all(5),
            //   child: AppUtils.buildNormalText(
            //       text: "Response", fontSize: 16, fontWeight: FontWeight.bold),
            // ),
            //getticketresponseview()
          ],
        ),
      ),
    );
  }

  Widget getticketdetailsview() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
          margin: const EdgeInsets.all(5),
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey.shade400,
              width: 0.5,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Header

              Padding(
                padding: const EdgeInsets.all(16),
                child: AppUtils.buildNormalText(
                  text:
                      'Ticket No. ${widget.model.message![widget.position!.toInt()].srInternalid.toString()} ',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColor.primary
                ),
              ),
              Divider(
                color: AppColor.greyShade1,
                height: 1,
              ),
              const SizedBox(
                height: 5,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          AppUtils.buildNormalText(
                              text: "Date", fontSize: 12, color: Colors.black54),
                          const SizedBox(height: 8),
                          AppUtils.buildNormalText(
                              text: "Contract",
                              fontSize: 12,
                              color: Colors.black54),
                       const SizedBox(height: 8),
                          AppUtils.buildNormalText(
                              text: "Building",
                              fontSize: 12,
                              color: Colors.black54),
                   const SizedBox(height: 8),
                          AppUtils.buildNormalText(
                              text: "Unit", fontSize: 12, color: Colors.black54),
                           const SizedBox(height: 8),
                          AppUtils.buildNormalText(
                              text: "Request Type",
                              fontSize: 12,
                              color: Colors.black54),
                           const SizedBox(height: 8),
                          AppUtils.buildNormalText(
                              text: "Category",
                              fontSize: 12,
                              color: Colors.black54),
                         const SizedBox(height: 8),
                          AppUtils.buildNormalText(
                              text: "Sub Category",
                              fontSize: 12,
                              color: Colors.black54),
                          const SizedBox(height: 8),
                          AppUtils.buildNormalText(
                              text: "Status", fontSize: 12, color: Colors.black54),
                          const SizedBox(height: 8),
                          AppUtils.buildNormalText(
                              text: "Remarks", fontSize: 12, color: Colors.black54),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          AppUtils.buildNormalText(
                              text: widget
                                  .model.message![widget.position!.toInt()].srDate
                                  .toString(),
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                           const SizedBox(height: 8),
                          AppUtils.buildNormalText(
                              text: widget.model.message![widget.position!.toInt()]
                                  .srContractname
                                  .toString(),
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                    const SizedBox(height: 8),
                          AppUtils.buildNormalText(
                              text: widget.model.message![widget.position!.toInt()]
                                  .srBuilding
                                  .toString(),
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                      const SizedBox(height: 8),
                          AppUtils.buildNormalText(
                              text: widget.model.message![widget.position!.toInt()]
                                  .srUnitVilla
                                  .toString(),
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                            const SizedBox(height: 8),
                          AppUtils.buildNormalText(
                              text: widget.model.message![widget.position!.toInt()]
                                  .srRequesttype
                                  .toString(),
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                       const SizedBox(height: 8),
                          AppUtils.buildNormalText(
                              text: widget.model.message![widget.position!.toInt()]
                                  .srMaincategoryName
                                  .toString(),
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                           const SizedBox(height: 8),
                          AppUtils.buildNormalText(
                            text: widget.model.message![widget.position!.toInt()]
                                .srSubcategoryName
                                .toString(),
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.ellipsis,
                          ),
                           const SizedBox(height: 8),
                          AppUtils.buildNormalText(
                              text: widget
                                  .model.message![widget.position!.toInt()].srStatus
                                  .toString(),
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.green),
                         const SizedBox(height: 8),
                          AppUtils.buildNormalText(
                              text: widget.model.message![widget.position!.toInt()]
                                  .srRemarks
                                  .toString(),
                              fontWeight: FontWeight.bold,
                              fontSize: 12)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          )),
    );
  }

  Widget getattachment() {
    return widget.model.message![widget.position!.toInt()].srAttachment
            .toString()
            .isNotEmpty
        ? Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              margin: const EdgeInsets.all(5),
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey.shade400,
                  width: 0.5,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Image.network(
                AppConstants.attachmentURL +
                    widget.model.message![widget.position!.toInt()].srAttachment
                        .toString(),
                fit: BoxFit.cover,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
              ),
            ),
          )
        : Container();
  }

  Widget getticketresponseview() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ListView.builder(
          itemCount: 1,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {},
              child: Container(
                  margin: const EdgeInsets.all(5),
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey.shade400,
                      width: 0.5,
                    ),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              AppUtils.buildNormalText(
                                  text: "Date:", color: Colors.black54),
                              const SizedBox(height: 1),
                              AppUtils.buildNormalText(text: "29/01/2024"),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              AppUtils.buildNormalText(
                                  text: "Time:", color: Colors.black54),
                              const SizedBox(height: 1),
                              AppUtils.buildNormalText(
                                text: "18:05:27",
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      AppUtils.buildNormalText(text: "Message : "),
                      AppUtils.buildNormalText(
                          text:
                              "Kitech Sink block and betroom washbasion is block"),
                      AppUtils.buildNormalText(text: "Company Code : 3000"),
                    ],
                  )),
            );
          }),
    );
  }
}
