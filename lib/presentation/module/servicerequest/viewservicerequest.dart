import 'dart:convert';

import 'package:dugasta/data/api_service.dart';
import 'package:dugasta/presentation/model/viewrequestmodel.dart';
import 'package:dugasta/presentation/module/servicerequest/servicerequest.dart';
import 'package:dugasta/presentation/module/servicerequest/ticketdetailsview.dart';
import 'package:dugasta/presentation/util/app_colors.dart';
import 'package:dugasta/presentation/util/app_utils.dart';
import 'package:dugasta/presentation/util/calendarpopview.dart';
import 'package:dugasta/presentation/utils/custom_button.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ViewServiceRequestPage extends StatefulWidget {
  const ViewServiceRequestPage({super.key});

  @override
  State<ViewServiceRequestPage> createState() => _ViewServiceRequestPageState();
}

class _ViewServiceRequestPageState extends State<ViewServiceRequestPage> {
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(const Duration(days: 5));

  bool loading = false;
  String? filter;
  ViewReqModel viewReqModel = ViewReqModel();
  TextEditingController searchcontroller = TextEditingController();
  @override
  void initState() {
    getdetails();
    super.initState();
  }

  @override
  void dispose() {
    searchcontroller.dispose();
    super.dispose();
  }
  //status clr

  Color getStatusColor(String status) {
  switch (status) {
    
    case "Job Completed":
      return Colors.green;
    case "Not Started":
      return Colors.red;
    case "In Progress":
      return Colors.orange;
    default:
      return Colors.black;
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
 
      appBar: AppBar(
        title: Text(
          'Service Request',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: !loading
          ? SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [getSearchBarUI(), loaddetails()],
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
      persistentFooterButtons: [
        
        Padding(
          padding: EdgeInsets.only(left: 15, right: 15),
          child: CustomButton(
            onPressed: () {
              Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ServiceRequestpage()))
                  .then((_) => getdetails());
            },
            name: "Create New Request",
            circularvalue: 20,
            fontSize: 14,

          ),
        )
      ],
    );
  }

  Widget getSearchBarUI() {
    return Padding(
     padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color:AppColor.appBarColor,
                borderRadius: const BorderRadius.all(
                  Radius.circular(20.0),
                ),
               
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 16, right: 16, top: 4, bottom: 4),
                child: TextField(
                  controller: searchcontroller,
                  onChanged: (val) {
                    setState(() {
                      filter = val;
                      filter = searchcontroller.text;
                    });
                  },
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                  cursorColor: AppColor.primary,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search...',
                    suffixIcon: InkWell(
                        onTap: () {
                          setState(() {
                            filter = "";
                            searchcontroller.text = "";
                            searchcontroller.clear();
                          });
                        },
                        child: const Icon(Icons.clear)),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getTimeDateUI() {
    return Padding(
      padding: const EdgeInsets.only(left: 18, bottom: 16),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    focusColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    splashColor: Colors.grey.withOpacity(0.2),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(4.0),
                    ),
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      // setState(() {
                      //   isDatePopupOpen = true;
                      // });
                      showDemoDialog(context: context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 8, right: 8, top: 4, bottom: 4),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Choose date',
                            style: TextStyle(
                              fontWeight: FontWeight.w100,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            '${DateFormat("dd, MMM").format(startDate)} - ${DateFormat("dd, MMM").format(endDate)}',
                            style: TextStyle(
                              fontWeight: FontWeight.w100,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Container(
              width: 1,
              height: 42,
              color: Colors.grey.withOpacity(0.8),
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    focusColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    splashColor: Colors.grey.withOpacity(0.2),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(4.0),
                    ),
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      //showbttom();
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 8, right: 8, top: 4, bottom: 4),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Filter',
                            style: TextStyle(
                              fontWeight: FontWeight.w100,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Icon(
                            Icons.sort,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  showbttom() {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusDirectional.only(
          topEnd: Radius.circular(25),
          topStart: Radius.circular(25),
        ),
      ),
      builder: (context) => Container(
        padding: EdgeInsetsDirectional.only(
          start: 20,
          end: 20,
          bottom: 30,
          top: 8,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    DropdownSearch<String>(
                      popupProps: PopupProps.menu(
                        showSelectedItems: true,
                        disabledItemFn: (String s) => s.startsWith('I'),
                      ),
                      items: const [
                        "Brazil",
                        "Italia (Disabled)",
                        "Tunisia",
                        'Canada'
                      ],
                      dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          labelText: "Menu mode",
                          hintText: "country in menu mode",
                        ),
                      ),
                      onChanged: print,
                      selectedItem: "Brazil",
                    ),
                    DropdownSearch<String>(
                      popupProps: PopupProps.menu(
                        showSelectedItems: true,
                        disabledItemFn: (String s) => s.startsWith('I'),
                      ),
                      items: const [
                        "Brazil",
                        "Italia (Disabled)",
                        "Tunisia",
                        'Canada'
                      ],
                      dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          labelText: "Menu mode",
                          hintText: "country in menu mode",
                        ),
                      ),
                      onChanged: print,
                      selectedItem: "Brazil",
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16, right: 16, bottom: 16, top: 8),
                      child: Container(
                        height: 48,
                        decoration: BoxDecoration(
                          color: AppColor.primary,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(24.0)),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.6),
                              blurRadius: 8,
                              offset: const Offset(4, 4),
                            ),
                          ],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(24.0)),
                            highlightColor: Colors.transparent,
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Center(
                              child: Text(
                                'Apply',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showDemoDialog({BuildContext? context}) {
    showDialog<dynamic>(
      context: context!,
      builder: (BuildContext context) => CalendarPopupView(
        barrierDismissible: true,
        minimumDate: DateTime.now(),
        //  maximumDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 10),
        initialEndDate: endDate,
        initialStartDate: startDate,
        onApplyClick: (DateTime startData, DateTime endData) {
          setState(() {
            startDate = startData;
            endDate = endData;
          });
        },
        onCancelClick: () {},
      ),
    );
  }

  Widget loaddetails() {
    return viewReqModel.message != null
        ? ListView.builder(
            itemCount: viewReqModel.message!.length,
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return filter.toString() == "null" || filter.toString() == ""
                  ? InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TicketDetailsView(
                                    model: viewReqModel,
                                    position: index,
                                  )),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: viewReqModel.message![index].srStatus
                                        .toString() ==
                                    "Closed"
                                ? Colors.green.shade100
                                : viewReqModel.message![index].srStatus
                                            .toString() ==
                                        "Open"
                                    ? Colors.white
                                    : viewReqModel.message![index].srStatus
                                                .toString() ==
                                            "Hold"
                                        ? Colors.orange.shade100
                                        : Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: const [
                              BoxShadow(
                                  color: Color(0xFFD4CEFE),
                                  offset: Offset(0, 7),
                                  blurRadius: 15)
                            ]),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                // InkWell(
                                //   onTap: () {},
                                //   child: Container(
                                //     width: 50,
                                //     height: 50,
                                //     decoration: const BoxDecoration(
                                //         color: Color(0xffFFE5F3),
                                //         borderRadius: BorderRadius.all(
                                //             Radius.circular(10))),
                                //     child: const Icon(
                                //       Icons.call,
                                //       color: AppColor.primary,
                                //       size: 25,
                                //     ),
                                //   ),
                                // ),
                                // const SizedBox(
                                //   width: 15,
                                // ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AppUtils.buildNormalText(
                                          text:
                                              "Ticket No :  ${viewReqModel.message![index].srInternalid.toString()}",
                                          color: const Color(0xff5C5C5C),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700),
                                      AppUtils.buildNormalText(
                                          text: viewReqModel
                                              .message![index].srDate
                                              .toString(),
                                          color: const Color(0xff5C5C5C),
                                          fontSize: 14),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                // Column(
                                //   children: [
                                //     AppUtils.buildNormalText(
                                //         text: viewReqModel
                                //             .message![index].srStatus
                                //             .toString(),
                                //         fontSize: 12,
                                //         fontWeight: FontWeight.w700,
                                //         color: viewReqModel
                                //                     .message![index].srStatus
                                //                     .toString() ==
                                //                 "Closed"
                                //             ? Colors.green
                                //             : Colors.black),
                                //     // AppUtils.buildNormalText(
                                //     //   text: viewReqModel
                                //     //       .message![index].srCallstype
                                //     //       .toString(),
                                //     //   fontSize: 14,
                                //     //   fontWeight: FontWeight.w700,
                                //     // ),
                                //   ],
                                // ),
                                Column(
  children: [
    AppUtils.buildNormalText(
      text: viewReqModel.message![index].srStatus.toString(),
      fontSize: 12,
      fontWeight: FontWeight.w700,
      color: getStatusColor(
        viewReqModel.message![index].srStatus.toString(),
      ),
    ),
  ],
),

                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.person_outline,
                                        color: AppColor.primary,
                                        size: 25,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      AppUtils.buildNormalText(
                                        text: viewReqModel
                                            .message![index].srContractname
                                            .toString(),
                                        fontSize: 13,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.location_city,
                                        color: AppColor.primary,
                                        size: 25,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      AppUtils.buildNormalText(
                                        text: viewReqModel
                                            .message![index].srBuilding
                                            .toString(),
                                        fontSize: 13,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.home,
                                        color: AppColor.primary,
                                        size: 25,
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      AppUtils.buildNormalText(
                                        text: viewReqModel
                                            .message![index].srUnitVilla
                                            .toString(),
                                        fontSize: 13,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 4, horizontal: 8),
                                  decoration: BoxDecoration(
                                    color: const Color(0xffFFE5F3),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: AppUtils.buildNormalText(
                                    text: viewReqModel
                                        .message![index].srRequesttype
                                        .toString(),
                                    fontSize: 12,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                       Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 8),
                              decoration: BoxDecoration(
                                color: const Color(0xffFFE5F3),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: AppUtils.buildNormalText(
                                text: viewReqModel.message![index].srRemarks ??
                                    "-",
                                color: Colors.black,
                                fontSize: 12,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            )
                              ],
                            ),
                           
                     
                          ],
                        ),
                      ),
                    )
                  : viewReqModel.message![index].srInternalid
                              .toString()
                              .toLowerCase()
                              .contains(filter.toString().toLowerCase()) ||
                          viewReqModel.message![index].srDate
                              .toString()
                              .toLowerCase()
                              .contains(filter.toString().toLowerCase()) ||
                          viewReqModel.message![index].srCallstype
                              .toString()
                              .toLowerCase()
                              .contains(filter.toString().toLowerCase()) ||
                          viewReqModel.message![index].srRemarks
                              .toString()
                              .toLowerCase()
                              .contains(filter.toString().toLowerCase()) ||
                          viewReqModel.message![index].srRequesttype
                              .toString()
                              .toLowerCase()
                              .contains(filter.toString().toLowerCase()) ||
                          viewReqModel.message![index].srBuilding
                              .toString()
                              .toLowerCase()
                              .contains(filter.toString().toLowerCase()) ||
                          viewReqModel.message![index].srUnitVilla
                              .toString()
                              .toLowerCase()
                              .contains(filter.toString().toLowerCase()) ||
                          viewReqModel.message![index].srStatus
                              .toString()
                              .toLowerCase()
                              .contains(filter.toString().toLowerCase())
                      ? InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TicketDetailsView(
                                        model: viewReqModel,
                                        position: index,
                                      )),
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: viewReqModel.message![index].srStatus
                                            .toString() ==
                                        "Closed"
                                    ? Colors.green.shade100
                                    : viewReqModel.message![index].srStatus
                                                .toString() ==
                                            "Open"
                                        ? Colors.white
                                        : viewReqModel.message![index].srStatus
                                                    .toString() ==
                                                "Hold"
                                            ? Colors.orange.shade100
                                            : Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: const [
                                  BoxShadow(
                                      color: Color(0xFFD4CEFE),
                                      offset: Offset(0, 7),
                                      blurRadius: 15)
                                ]),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () {},
                                      child: Container(
                                        width: 50,
                                        height: 50,
                                        decoration: const BoxDecoration(
                                            color: Color(0xffFFE5F3),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                        child: const Icon(
                                          Icons.call,
                                          color: AppColor.primary,
                                          size: 25,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          AppUtils.buildNormalText(
                                              text:
                                                  "Ticket No :  ${viewReqModel.message![index].srCasenumber.toString()}",
                                              color: AppColor.primary,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700),
                                          AppUtils.buildNormalText(
                                              text: viewReqModel
                                                  .message![index].srDate
                                                  .toString(),
                                              color: const Color(0xff5C5C5C),
                                              fontSize: 14),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Column(
                                      children: [
                                        AppUtils.buildNormalText(
                                            text: viewReqModel
                                                .message![index].srStatus
                                                .toString(),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700,
                                            color: viewReqModel.message![index]
                                                        .srStatus
                                                        .toString() ==
                                                    "Closed"
                                                ? Colors.green
                                                : Colors.black),
                                        // AppUtils.buildNormalText(
                                        //   text: viewReqModel
                                        //       .message![index].srCallstype
                                        //       .toString(),
                                        //   fontSize: 14,
                                        //   fontWeight: FontWeight.w700,
                                        // ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.person_outline,
                                            color: AppColor.primary,
                                            size: 25,
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          AppUtils.buildNormalText(
                                            text: viewReqModel
                                                .message![index].srContractname
                                                .toString(),
                                            fontSize: 13,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.location_city,
                                            color: AppColor.primary,
                                            size: 25,
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          AppUtils.buildNormalText(
                                            text: viewReqModel
                                                .message![index].srBuilding
                                                .toString(),
                                            fontSize: 13,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.home,
                                            color: AppColor.primary,
                                            size: 25,
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          AppUtils.buildNormalText(
                                            text: viewReqModel
                                                .message![index].srUnitVilla
                                                .toString(),
                                            fontSize: 13,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4, horizontal: 8),
                                      decoration: BoxDecoration(
                                        color: const Color(0xffFFE5F3),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: AppUtils.buildNormalText(
                                        text: viewReqModel
                                            .message![index].srRequesttype
                                            .toString(),
                                        fontSize: 13,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 4, horizontal: 8),
                                  decoration: BoxDecoration(
                                    color: const Color(0xffFFE5F3),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: AppUtils.buildNormalText(
                                    text: viewReqModel.message![index].srRemarks
                                        .toString(),
                                    color: Colors.black,
                                    fontSize: 13,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : Container();
            })
        : Container(
            child: Center(
              child: AppUtils.buildNormalText(text: "No Tickets Found!!"),
            ),
          );
    // return ListView.builder(
    //     itemCount: 2,
    //     shrinkWrap: true,
    //     physics: NeverScrollableScrollPhysics(),
    //     itemBuilder: (BuildContext context, int index) {
    //       return InkWell(
    //         onTap: () {
    //           Navigator.push(
    //             context,
    //             MaterialPageRoute(
    //                 builder: (context) => TicketDetailsView(
    //                     position: index, model: viewReqModel)),
    //           );
    //         },
    //         child: Padding(
    //           padding: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
    //           child: Column(
    //             //mainAxisSize: MainAxisSize.min,
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             mainAxisAlignment: MainAxisAlignment.start,
    //             children: [
    //               Container(
    //                 padding: EdgeInsets.all(16),
    //                 decoration: BoxDecoration(
    //                     color: Colors.white,
    //                     borderRadius: BorderRadius.only(
    //                         topLeft: Radius.circular(10),
    //                         topRight: Radius.circular(10))),
    //                 child: Column(
    //                   children: [
    //                     Row(
    //                       mainAxisAlignment: MainAxisAlignment.start,
    //                       children: const [
    //                         Text(
    //                           "Ticket No : 1009",
    //                           style: TextStyle(
    //                               fontSize: 16,
    //                               fontWeight: FontWeight.bold,
    //                               color: Colors.black),
    //                         ),
    //                       ],
    //                     ),
    //                     SizedBox(
    //                       height: 10,
    //                     ),
    //                     Row(
    //                       mainAxisAlignment: MainAxisAlignment.start,
    //                       children: const [
    //                         Text(
    //                           "Contractor Name : Test",
    //                           style: TextStyle(
    //                               fontSize: 16,
    //                               fontWeight: FontWeight.bold,
    //                               color: Colors.black),
    //                         ),
    //                       ],
    //                     ),
    //                     SizedBox(
    //                       height: 10,
    //                     ),
    //                     Row(
    //                       mainAxisAlignment: MainAxisAlignment.start,
    //                       children: const [
    //                         Text(
    //                           "Building",
    //                           style: TextStyle(
    //                               fontSize: 16,
    //                               fontWeight: FontWeight.bold,
    //                               color: Colors.black),
    //                         ),
    //                       ],
    //                     ),
    //                     SizedBox(
    //                       height: 16,
    //                     ),
    //                     Row(
    //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                       children: [
    //                         AppUtils.buildNormalText(
    //                             text: "Date", color: Colors.grey, fontSize: 12),
    //                         AppUtils.buildNormalText(
    //                             text: "Status",
    //                             color: Colors.grey,
    //                             fontSize: 12),
    //                       ],
    //                     ),
    //                     SizedBox(height: 5),
    //                     Row(
    //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                       children: [
    //                         AppUtils.buildNormalText(
    //                             text: "20/04/2024",
    //                             color: Colors.black,
    //                             fontWeight: FontWeight.w400,
    //                             fontSize: 12),
    //                         AppUtils.buildNormalText(
    //                             text: "Open",
    //                             color: Colors.black,
    //                             fontWeight: FontWeight.w400,
    //                             fontSize: 12),
    //                       ],
    //                     ),
    //                     SizedBox(height: 5),
    //                     Row(
    //                       mainAxisAlignment: MainAxisAlignment.start,
    //                       children: const [
    //                         Text(
    //                           "For Testing",
    //                           style: TextStyle(
    //                               fontSize: 12,
    //                               fontWeight: FontWeight.bold,
    //                               color: Colors.black),
    //                         ),
    //                       ],
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //               Container(
    //                 color: Colors.white,
    //                 child: Row(
    //                   children: [
    //                     SizedBox(
    //                       height: 20,
    //                       width: 10,
    //                       child: DecoratedBox(
    //                         decoration: BoxDecoration(
    //                             borderRadius: BorderRadius.only(
    //                                 topRight: Radius.circular(10),
    //                                 bottomRight: Radius.circular(10)),
    //                             color: Colors.grey.shade200),
    //                       ),
    //                     ),
    //                     Expanded(
    //                       child: Padding(
    //                         padding: const EdgeInsets.all(8.0),
    //                         child: LayoutBuilder(
    //                           builder: (context, constraints) {
    //                             return Flex(
    //                               direction: Axis.horizontal,
    //                               mainAxisSize: MainAxisSize.max,
    //                               mainAxisAlignment:
    //                                   MainAxisAlignment.spaceBetween,
    //                               children: List.generate(
    //                                   (constraints.constrainWidth() / 10)
    //                                       .floor(),
    //                                   (index) => SizedBox(
    //                                         height: 1,
    //                                         width: 5,
    //                                         child: DecoratedBox(
    //                                           decoration: BoxDecoration(
    //                                               color: Colors.grey.shade400),
    //                                         ),
    //                                       )),
    //                             );
    //                           },
    //                         ),
    //                       ),
    //                     ),
    //                     SizedBox(
    //                       height: 20,
    //                       width: 10,
    //                       child: DecoratedBox(
    //                         decoration: BoxDecoration(
    //                             borderRadius: BorderRadius.only(
    //                                 topLeft: Radius.circular(10),
    //                                 bottomLeft: Radius.circular(10)),
    //                             color: Colors.grey.shade200),
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //               Container(
    //                 padding: EdgeInsets.only(left: 16, right: 16, bottom: 12),
    //                 decoration: BoxDecoration(
    //                     color: Colors.white,
    //                     borderRadius: BorderRadius.only(
    //                         bottomLeft: Radius.circular(24),
    //                         bottomRight: Radius.circular(24))),
    //                 child: Row(
    //                   children: const [
    //                     Text("Request Type",
    //                         style: TextStyle(
    //                             fontSize: 12,
    //                             fontWeight: FontWeight.w500,
    //                             color: Colors.black)),
    //                     Expanded(
    //                         child: Text("Critical",
    //                             textAlign: TextAlign.end,
    //                             style: TextStyle(
    //                                 fontSize: 14,
    //                                 fontWeight: FontWeight.bold,
    //                                 color: Colors.black))),
    //                   ],
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //       );
    //     });
  }

  void getdetails() async {
    setState(() {
      loading = true;
    });
    Apiservice.getviewservicelist().then((response) {
      setState(() {
        loading = false;
      });
      if (response.statusCode == 200) {
        if (jsonDecode(response.body)['status'].toString() == "true") {
          viewReqModel = ViewReqModel.fromJson(jsonDecode(response.body));
        } else {
          AppUtils.showSingleDialogPopup(context,
              jsonDecode(response.body)['message'].toString(), "Ok", exitpopup);
        }
        //return response;
      } else {
        throw Exception(jsonDecode(response.body)['message'].toString());
      }
    }).catchError((e) {
      setState(() {
        loading = false;
      });
      AppUtils.showSingleDialogPopup(context, e.toString(), "Ok", exitpopup);
    });
  }

  void exitpopup() {
    AppUtils.pop(context);
  }
}
