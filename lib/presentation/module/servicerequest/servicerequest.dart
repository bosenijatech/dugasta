import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:dugasta/data/api_service.dart';
import 'package:dugasta/domain/pref.dart';
import 'package:dugasta/presentation/model/categorymodel.dart';
import 'package:dugasta/presentation/model/contractmodel.dart';
import 'package:dugasta/presentation/model/requesttypemodel.dart';
import 'package:dugasta/presentation/model/subcatmodel.dart';
import 'package:dugasta/presentation/util/app_colors.dart';
import 'package:dugasta/presentation/util/app_utils.dart';
import 'package:dugasta/presentation/util/appcontants.dart';
import 'package:dugasta/presentation/util/filemodel.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:dugasta/presentation/utils/permissionmanager.dart';

class ServiceRequestpage extends StatefulWidget {
  const ServiceRequestpage({super.key});

  @override
  State<ServiceRequestpage> createState() => _ServiceRequestpageState();
}

class _ServiceRequestpageState extends State<ServiceRequestpage> {
  TextEditingController attachcontroller = TextEditingController();
  TextEditingController reasoncontroller = TextEditingController();
  TextEditingController mobilenocontroller = TextEditingController();

  List<String> files = [];
  List<File> filelist = [];
  final picker = ImagePicker();
  File? imagefile;
  int? selection = 0;
  List<PlatformFile>? _paths;
  ContractModel contractModel = ContractModel();
  List<ContractModel> activeContracts = [];
  bool loading = false;
  List<MultiLevelString> requestnumberlist = [];
  final myKey = GlobalKey<DropdownSearchState<MultiLevelString>>();
  List<ContractModel> allContracts = [];
  // final myreqKey = GlobalKey<DropdownSearchState<RequestTypeString>>();

  RequestTypeModel requestTypeModel = RequestTypeModel();

  List<CategoryTypeString> categorylist = [];
  final mycatKey = GlobalKey<DropdownSearchState<CategoryTypeString>>();

  CategoryModel categoryModel = CategoryModel();

  final permissionManager = PermissionManager();

  List<SubCategoryTypeString> subcategorylist = [];

  final mysubcatKey = GlobalKey<DropdownSearchState<SubCategoryTypeString>>();
  final mysubcallskey = GlobalKey<DropdownSearchState<CallsType>>();

  SubCategoryModel subCategoryModel = SubCategoryModel();

  String? getcontractno;
  String? getbuilding;
  String? getunit;
  String? getcontractorstartdate;
  String? getcontractorenddate;
  String? getbuildingid;
  String? getunitid;
  String? getErajNo;

  // String? getrequesttypeid;
  // String? getrequesttypename;

  String? getcategoryId;
  String? getcategoryname;

  String? getsubcategoryId;
  String? getsubcategoryname;

  // List<CallsType> calltypelist = [];

  String? getcallstypeid;
  String? getcallstypename;

  List<String> attachmentlist = [];
  String base64format = "";
  List<AttachModel> attachlist = [];
  String filetype = "";
  String filename = "";
  @override
  void initState() {
    // calltypelist = [
    //   CallsType(id: "1", name: "Critical"),
    //   CallsType(id: "2", name: "Major"),
    //   CallsType(id: "3", name: "Minor")
    // ];
    getcallstypeid = "3";
    getcallstypename = "Minor";
    mobilenocontroller.text = Prefs.getMobileNo("MobileNo").toString();
    getContracts();

    super.initState();
  }

  @override
  void dispose() {
    mobilenocontroller.dispose();
    attachcontroller.dispose();
    reasoncontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'New Service Request',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: !loading
          ? SingleChildScrollView(
              child: Column(
                children: [getdetails],
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  Widget get getdetails => Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppUtils.buildNormalText(text: "PROJECT",fontSize: 14,color: Colors.black87),
            const SizedBox(
              height: 10,
            ),
            DropdownSearch<MultiLevelString>(
                key: myKey,
                items: requestnumberlist,
                compareFn: (i1, i2) => i1.contractno == i2.contractno,
                popupProps: PopupProps.bottomSheet(
                    showSelectedItems: true,
                    showSearchBox: true,
                    interceptCallBacks: false, //important line
                    itemBuilder: (ctx, item, isSelected) {
                      return ListTile(
                        selected: isSelected,
                        subtitle: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Contract No:${item.erajNo.toString()}"),
                            SizedBox(
                              height: 3,
                            ),
                            Text("Building:${item.building}"),
                            SizedBox(
                              height: 3,
                            ),
                            Text("Unit:${item.unit}"),
                            SizedBox(
                              height: 3,
                            ),
                          ],
                        ),
                        onTap: () => myKey.currentState?.popupValidate([item]),
                      );
                    }),
                onChanged: (val) {
                  getcontractno = val!.contractno.toString();
                  getbuilding = val.building.toString();
                  getunit = val.unit.toString();
                  getcontractorstartdate = val.contractorstartdate.toString();
                  getcontractorenddate = val.contractorenddate.toString();
                  getunitid = val.unitid.toString();
                  getbuildingid = val.buildingid.toString();

                  getmaincategorymaster();
                },
                selectedItem: MultiLevelString(
                    contractno: getcontractno ?? "",
                    building: getbuilding ?? "",
                    unit: getunit ?? "",
                    contractorstartdate: getcontractorstartdate ?? "",
                    contractorenddate: getcontractorenddate ?? "",
                    buildingid: getbuildingid ?? "-",
                    unitid: getunit ?? "-",
                    erajNo: getErajNo ?? "")),
            const SizedBox(
              height: 10,
            ),
            AppUtils.buildNormalText(text: "UNIT NUMBER",fontSize: 14,color: Colors.black87),
            const SizedBox(
              height: 10,
            ),
            // DropdownSearch<RequestTypeString>(
            //     key: myreqKey,
            //     items: requesttypelist,
            //     compareFn: (i1, i2) => i1.reqtypeid == i2.reqtypeid,
            //     popupProps: PopupProps.bottomSheet(
            //         showSelectedItems: true,
            //         showSearchBox: true,
            //         interceptCallBacks: false, //important line
            //         itemBuilder: (ctx, itemss, isSelected) {
            //           return ListTile(
            //             selected: isSelected,
            //             subtitle: Text(itemss.reqtypename),
            //             onTap: () =>
            //                 myreqKey.currentState?.popupValidate([itemss]),
            //           );
            //         }),
            //     onChanged: (val) {
            //       getrequesttypeid = val!.reqtypeid.toString();
            //       getrequesttypename = val.reqtypename.toString();
            //       getcategorymaster();
            //     },
            //     selectedItem: RequestTypeString(
            //         reqtypeid: getrequesttypeid ?? "",
            //         reqtypename: getrequesttypename ?? "")),
            // const SizedBox(
            //   height: 10,
            // ),
            // AppUtils.buildNormalText(text: "CATEGORY * "),
            // const SizedBox(
            //   height: 10,
            // ),
            DropdownSearch<CategoryTypeString>(
                key: mycatKey,
                items: categorylist,
                compareFn: (i1, i2) => i1.catid == i2.catid,
                popupProps: PopupProps.bottomSheet(
                    showSelectedItems: true,
                    showSearchBox: true,
                    interceptCallBacks: false, //important line
                    itemBuilder: (ctx, itemss, isSelected) {
                      return ListTile(
                        selected: isSelected,
                        subtitle: Text(itemss.catname),
                        onTap: () =>
                            mycatKey.currentState?.popupValidate([itemss]),
                      );
                    }),
                onChanged: (val) {
                  getcategoryId = val!.catid.toString();
                  getcategoryname = val.catname.toString();

                  getgetrequestmaster();
                },
                selectedItem: CategoryTypeString(
                    catid: getcategoryId ?? "",
                    catname: getcategoryname ?? "")),
            const SizedBox(
              height: 10,
            ),
            AppUtils.buildNormalText(text: "COMPANY NAME",fontSize: 14,color: Colors.black87),
            const SizedBox(
              height: 10,
            ),
            DropdownSearch<SubCategoryTypeString>(
                key: mysubcatKey,
                items: subcategorylist,
                compareFn: (i1, i2) => i1.subcatid == i2.subcatid,
                popupProps: PopupProps.bottomSheet(
                    showSelectedItems: true,
                    showSearchBox: true,
                    interceptCallBacks: false, //important line
                    itemBuilder: (ctx, itemss, isSelected) {
                      return ListTile(
                        selected: isSelected,
                        subtitle: Text(itemss.subcatname),
                        onTap: () =>
                            mysubcatKey.currentState?.popupValidate([itemss]),
                      );
                    }),
                onChanged: (val) {
                  getsubcategoryId = val!.subcatid.toString();
                  getsubcategoryname = val.subcatname.toString();
                  print(getsubcategoryId);
                },
                selectedItem: SubCategoryTypeString(
                    subcatid: getsubcategoryId ?? "",
                    subcatname: getsubcategoryname ?? "")),

            //AppUtils.buildNormalText(text: "TICKET TYPE *"),

            const SizedBox(
              height: 10,
            ),
            // DropdownSearch<CallsType>(
            //     key: mysubcallskey,
            //     items: calltypelist,
            //     compareFn: (i1, i2) => i1.id == i2.id,
            //     popupProps: PopupProps.dialog(
            //         showSelectedItems: true,
            //         showSearchBox: true,
            //         interceptCallBacks: false, //important line
            //         itemBuilder: (ctx, itemss, isSelected) {
            //           return ListTile(
            //             selected: isSelected,
            //             subtitle: Text(itemss.name.toString()),
            //             onTap: () =>
            //                 mysubcallskey.currentState?.popupValidate([itemss]),
            //           );
            //         }),
            //     onChanged: (val) {
            //       getcallstypeid = val!.id.toString();
            //       getcallstypename = val.name.toString();
            //     },
            //     selectedItem: CallsType(
            //         id: getcallstypeid ?? "", name: getcallstypename ?? "")),
            // const SizedBox(
            //   height: 10,
            // ),
            AppUtils.buildNormalText(text: "PHONE",fontSize: 14,color: Colors.black87),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: double.infinity,
              child: TextField(
                controller: mobilenocontroller,
                maxLength: 10,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                keyboardType: TextInputType.number,
                onSubmitted: (value) {
                  print(value.toString());
                  AppUtils.hideKeyboard(context);
                  if (value.isEmpty && value.length < 10) {
                    //AppUtils.showSingleDialogPopup(context, "Ok", "Please Enter 10 Digit Mobile No",display);
                  } else {}
                },
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  counterText: "",
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            AppUtils.buildNormalText(text: "EMAIL",fontSize: 14,color: Colors.black87),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: double.infinity,
              child: TextField(
                controller: mobilenocontroller,
                maxLength: 10,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                keyboardType: TextInputType.number,
                onSubmitted: (value) {
                  print(value.toString());
                  AppUtils.hideKeyboard(context);
                  if (value.isEmpty && value.length < 10) {
                    //AppUtils.showSingleDialogPopup(context, "Ok", "Please Enter 10 Digit Mobile No",display);
                  } else {}
                },
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  counterText: "",
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            AppUtils.buildNormalText(text: "SUBJECT",fontSize: 14,color: Colors.black87),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: double.infinity,
              child: TextField(
                controller: mobilenocontroller,
                maxLength: 10,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                keyboardType: TextInputType.number,
                onSubmitted: (value) {
                  print(value.toString());
                  AppUtils.hideKeyboard(context);
                  if (value.isEmpty && value.length < 10) {
                    //AppUtils.showSingleDialogPopup(context, "Ok", "Please Enter 10 Digit Mobile No",display);
                  } else {}
                },
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  counterText: "",
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),

            
            // AppUtils.buildNormalText(text: "ATTACHMENT",fontSize: 14,color: Colors.black87),
            // const SizedBox(
            //   height: 10,
            // ),
            // TextField(
            //   readOnly: true,
            //   controller: attachcontroller,
            //   decoration: InputDecoration(
            //     contentPadding:
            //         EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            //     border: OutlineInputBorder(),
            //     hintText: "Click here to Attach file",
            //     suffixIcon: IconButton(
            //       icon: const Icon(
            //         Icons.attach_file,
            //         color: Colors.black,
            //       ),
            //       onPressed: () async {
            //         // Map<Permission, PermissionStatus> statuses = await [
            //         //   Permission.camera,
            //         // ].request();
            //         // statuses.values.forEach((element) async {
            //         //   if (element.isDenied || element.isPermanentlyDenied) {
            //         //     await openAppSettings();
            //         //   }
            //         // });
            //         // getImageFromCamera();
            //         // // AppUtils.showBottomCupertinoDialog(context,
            //         // //     title: "Choose any one option", btn1function: () async {
            //         // //   AppUtils.pop(context);
            //         // // }, btn2function: () {
            //         // //   AppUtils.pop(context);
            //         // //   pickFile();
            //         // // });
            //         _onCameraFeatureTapped(context);
            //       },
            //     ),
            //   ),
            //   textInputAction: TextInputAction.done,
            // ),

 AppUtils.buildNormalText(text: "CASE TYPE",fontSize: 14,color: Colors.black87),
            const SizedBox(
              height: 10,
            ),
            DropdownSearch<MultiLevelString>(
                // key: myKey,
                items: requestnumberlist,
                compareFn: (i1, i2) => i1.contractno == i2.contractno,
                popupProps: PopupProps.bottomSheet(
                    showSelectedItems: true,
                    showSearchBox: true,
                    interceptCallBacks: false, //important line
                    itemBuilder: (ctx, item, isSelected) {
                      return ListTile(
                        selected: isSelected,
                        subtitle: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Contract No:${item.erajNo.toString()}"),
                            SizedBox(
                              height: 3,
                            ),
                            Text("Building:${item.building}"),
                            SizedBox(
                              height: 3,
                            ),
                            Text("Unit:${item.unit}"),
                            SizedBox(
                              height: 3,
                            ),
                          ],
                        ),
                        onTap: () => myKey.currentState?.popupValidate([item]),
                      );
                    }),
                onChanged: (val) {
                  getcontractno = val!.contractno.toString();
                  getbuilding = val.building.toString();
                  getunit = val.unit.toString();
                  getcontractorstartdate = val.contractorstartdate.toString();
                  getcontractorenddate = val.contractorenddate.toString();
                  getunitid = val.unitid.toString();
                  getbuildingid = val.buildingid.toString();

               
                },
             ),
            const SizedBox(
              height: 10,
            ),

               AppUtils.buildNormalText(text: "CATEGORY",fontSize: 14,color: Colors.black87),
            const SizedBox(
              height: 10,
            ),
            DropdownSearch<MultiLevelString>(
                // key: myKey,
                items: requestnumberlist,
                compareFn: (i1, i2) => i1.contractno == i2.contractno,
                popupProps: PopupProps.bottomSheet(
                    showSelectedItems: true,
                    showSearchBox: true,
                    interceptCallBacks: false, //important line
                    itemBuilder: (ctx, item, isSelected) {
                      return ListTile(
                        selected: isSelected,
                        subtitle: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Contract No:${item.erajNo.toString()}"),
                            SizedBox(
                              height: 3,
                            ),
                            Text("Building:${item.building}"),
                            SizedBox(
                              height: 3,
                            ),
                            Text("Unit:${item.unit}"),
                            SizedBox(
                              height: 3,
                            ),
                          ],
                        ),
                        onTap: () => myKey.currentState?.popupValidate([item]),
                      );
                    }),
                onChanged: (val) {
                  getcontractno = val!.contractno.toString();
                  getbuilding = val.building.toString();
                  getunit = val.unit.toString();
                  getcontractorstartdate = val.contractorstartdate.toString();
                  getcontractorenddate = val.contractorenddate.toString();
                  getunitid = val.unitid.toString();
                  getbuildingid = val.buildingid.toString();

                  getmaincategorymaster();
                },
                selectedItem: MultiLevelString(
                    contractno: getcontractno ?? "",
                    building: getbuilding ?? "",
                    unit: getunit ?? "",
                    contractorstartdate: getcontractorstartdate ?? "",
                    contractorenddate: getcontractorenddate ?? "",
                    buildingid: getbuildingid ?? "-",
                    unitid: getunit ?? "-",
                    erajNo: getErajNo ?? "")),
            const SizedBox(
              height: 10,
            ),
            AppUtils.buildNormalText(text: "SUB-CATEGORY",fontSize: 14,color: Colors.black87),
            const SizedBox(
              height: 10,
            ),
            // DropdownSearch<RequestTypeString>(
            //     key: myreqKey,
            //     items: requesttypelist,
            //     compareFn: (i1, i2) => i1.reqtypeid == i2.reqtypeid,
            //     popupProps: PopupProps.bottomSheet(
            //         showSelectedItems: true,
            //         showSearchBox: true,
            //         interceptCallBacks: false, //important line
            //         itemBuilder: (ctx, itemss, isSelected) {
            //           return ListTile(
            //             selected: isSelected,
            //             subtitle: Text(itemss.reqtypename),
            //             onTap: () =>
            //                 myreqKey.currentState?.popupValidate([itemss]),
            //           );
            //         }),
            //     onChanged: (val) {
            //       getrequesttypeid = val!.reqtypeid.toString();
            //       getrequesttypename = val.reqtypename.toString();
            //       getcategorymaster();
            //     },
            //     selectedItem: RequestTypeString(
            //         reqtypeid: getrequesttypeid ?? "",
            //         reqtypename: getrequesttypename ?? "")),
            // const SizedBox(
            //   height: 10,
            // ),
            // AppUtils.buildNormalText(text: "CATEGORY * "),
            // const SizedBox(
            //   height: 10,
            // ),
            DropdownSearch<CategoryTypeString>(
                // key: mycatKey,
                items: categorylist,
                compareFn: (i1, i2) => i1.catid == i2.catid,
                popupProps: PopupProps.bottomSheet(
                    showSelectedItems: true,
                    showSearchBox: true,
                    interceptCallBacks: false, //important line
                    itemBuilder: (ctx, itemss, isSelected) {
                      return ListTile(
                        selected: isSelected,
                        subtitle: Text(itemss.catname),
                        onTap: () =>
                            mycatKey.currentState?.popupValidate([itemss]),
                      );
                    }),
                onChanged: (val) {
                  getcategoryId = val!.catid.toString();
                  getcategoryname = val.catname.toString();

                  getgetrequestmaster();
                },
                selectedItem: CategoryTypeString(
                    catid: getcategoryId ?? "",
                    catname: getcategoryname ?? "")),
            const SizedBox(
              height: 10,
            ),
        
      
    
 AppUtils.buildNormalText(text: "PRIORITY",fontSize: 14,color: Colors.black87),
            const SizedBox(
              height: 10,
            ),
            DropdownSearch<MultiLevelString>(
                // key: myKey,
                items: requestnumberlist,
                compareFn: (i1, i2) => i1.contractno == i2.contractno,
                popupProps: PopupProps.bottomSheet(
                    showSelectedItems: true,
                    showSearchBox: true,
                    interceptCallBacks: false, //important line
                    itemBuilder: (ctx, item, isSelected) {
                      return ListTile(
                        selected: isSelected,
                        subtitle: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Contract No:${item.erajNo.toString()}"),
                            SizedBox(
                              height: 3,
                            ),
                            Text("Building:${item.building}"),
                            SizedBox(
                              height: 3,
                            ),
                            Text("Unit:${item.unit}"),
                            SizedBox(
                              height: 3,
                            ),
                          ],
                        ),
                        onTap: () => myKey.currentState?.popupValidate([item]),
                      );
                    }),
                onChanged: (val) {
                  getcontractno = val!.contractno.toString();
                  getbuilding = val.building.toString();
                  getunit = val.unit.toString();
                  getcontractorstartdate = val.contractorstartdate.toString();
                  getcontractorenddate = val.contractorenddate.toString();
                  getunitid = val.unitid.toString();
                  getbuildingid = val.buildingid.toString();

               
                },
             ),
            const SizedBox(
              height: 10,
            ),
            AppUtils.buildNormalText(text: "MESSAGE",fontSize: 14,color: Colors.black87),
            const SizedBox(
              height: 10,
            ),
            Container(
                //padding: EdgeInsets.all(20),
                child: TextField(
              controller: reasoncontroller,
              keyboardType: TextInputType.multiline,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: "Enter Message here",
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.grey)),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(color: Colors.black26, width: 1),
                ),
              ),
            )),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                    child: TextButton(
                        style: ButtonStyle(
                            padding: WidgetStateProperty.all<EdgeInsets>(
                                EdgeInsets.all(15)),
                            foregroundColor: WidgetStateProperty.all<Color>(
                                AppColor.primaryColor),
                            shape:
                                WidgetStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                        side: BorderSide(
                                            color: AppColor.primaryColor)))),
                        onPressed: () {},
                        child: Text("Clear".toUpperCase(),
                            style: TextStyle(fontSize: 14)))),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                    child: ElevatedButton(
                  onPressed: () {
                    if (getcontractno.toString().isEmpty ||
                        getcontractno.toString() == "null") {
                      AppUtils.showSingleDialogPopup(
                          context, "Please Choose Contrator", "Ok", exitpopup);
                    } else if (getsubcategoryId.toString().isEmpty ||
                        getsubcategoryId.toString() == "null") {
                      AppUtils.showSingleDialogPopup(
                          context, "Please Choose Category", "Ok", exitpopup);
                    } else if (getcallstypeid.toString().isEmpty ||
                        getcallstypeid.toString() == "null") {
                      AppUtils.showSingleDialogPopup(context,
                          "Please Choose Ticket Type", "Ok", exitpopup);
                    } else if (attachlist.isEmpty) {
                      //postrequestdetails(0, "");
                      AppUtils.showSingleDialogPopup(
                          context,
                          "Please Make you sure Attachment is Missing",
                          "Ok",
                          exitpopup);
                    } else {
                      uploadimagetonetsuite();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                  ),
                  child: Text("Submit"),
                ))
              ],
            )
          ],
        ),
      );
  void _onCameraFeatureTapped(BuildContext context) async {
    bool granted =
        await permissionManager.checkAndRequestCameraPermission(context);

    if (granted) {
      getImageFromCamera();
    } else {
      AppUtils.showconfirmDialog(
          context,
          "You have denied camera access. To use this feature, please allow camera permission in your device settings.",
          "Ok",
          "Cancel", () {
        openAppSettings();
        Navigator.of(context).pop();
      }, () {
        Navigator.of(context).pop();
      });
    }
  }

  void postrequestdetails(attachmentid, url) {
    setState(() {
      loading = true;
    });
    //String datetime = DateTime.now().toString();
    String datetime = DateFormat("yyyy-MM-dd hh:mm:ss").format(DateTime.now());
    String date = DateFormat("yyyy-MM-dd").format(DateTime.now());

    var body = {
      "company": Prefs.getCustomerId("CustomerID").toString(),
      "category": getcategoryId,
      "subject": "",
      "contract": getcontractno,
      "buildingId": getbuildingid ?? 0,
      "unit": getunitid ?? 0,
      "email": Prefs.getEmail("Email").toString(),
      "phone": Prefs.getMobileNo("MobileNo").toString(),
      // "contractStartDate": getcontractorstartdate,
      // "contractEndDate": getcontractorenddate,
      "priority": getcallstypeid,
      "mainCatagory": getcategoryId,
      "subCategory": getsubcategoryId,
      attachlist.isEmpty ? "" : "attachment": attachmentid,
      "remarks": reasoncontroller.text.toString(),
      // "unitName": getunit,
      // "customerName": Prefs.getName("Name").toString(),
      // "categoryId": getsubcategoryId,
      // "categoryName": getsubcategoryname,
      //"sr_attachment": url,
    };
    print(jsonEncode(body));
    Apiservice.postrequest(body).then((response) {
      setState(() {
        loading = false;
      });
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (jsonDecode(response.body)['status'].toString() == "true") {
          AppUtils.showSingleDialogPopup(
              context,
              jsonDecode(response.body)['message'].toString(),
              "Ok",
              refreshscreen);
        } else {
          AppUtils.showSingleDialogPopup(context,
              jsonDecode(response.body)['message'].toString(), "Ok", exitpopup);
        }
      } else {
        AppUtils.showSingleDialogPopup(context,
            jsonDecode(response.body)['message'].toString(), "Ok", exitpopup);
      }
    }).catchError((e) {
      setState(() {
        loading = false;
      });
      print(e.toString());
      AppUtils.showSingleDialogPopup(context, e.toString(), "Ok", exitpopup);
    });
  }

  Future getImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      imagefile = File(pickedFile.path);

      final bytes = imagefile!.readAsBytesSync().lengthInBytes;
      final kb = bytes / 1024;
      final mb = kb / 1024;

      File imageFile = File(pickedFile.path);

      Uint8List bytes0 = await imageFile.readAsBytes();
      String base64String1 = base64Encode(bytes0);
      attachcontroller.text = pickedFile.path.toString().split("/").last;
      attachlist.clear();

      var filetypes =
          AppConstants.getFileTypeExtension(pickedFile.path.toString());
      print("filetypes$filetypes");

      final DateTime now = DateTime.now();

      filename = "$now-${pickedFile.path.toString().split("/").last}";
      base64format = base64String1;
      print(filetype);

      attachlist.add(AttachModel(
          filetype, pickedFile.path.toString().split("/").last, base64String1));

      filetype = "image/$filetype";
      setState(() {});
    } else {
      attachlist.clear();
      print('No image selected.');
    }
  }

  void pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowMultiple: false,
      allowedExtensions: [
        'png',
        'jpg',
        'jpeg',
        //'pdf',
        // 'doc',
        // 'docx',
        // 'xls',
      ],
    );

    if (result != null && result.files.single.path != null) {
      PlatformFile file = result.files.first;

      File file0 = File(result.files.single.path!);
      String file64 = "";
      setState(() async {
        if (file.extension.toString() == "pdf") {
          attachcontroller.text = file.name;
          final bytes = File(file0.path).readAsBytesSync();
          file64 = base64Encode(bytes);
        } else {
          //Image
          attachcontroller.text = file.name.toString();
          Uint8List bytes0 = await file0.readAsBytes();
          file64 = base64Encode(bytes0);
        }

        attachlist.clear();
        // print(file.name);
        // print(file64);
        // print(file.size);
        // print(file.extension);
        // print(file.path);
        filename = file.name;
        base64format = file64;
        filetype = 'image/png';
        attachlist.add(AttachModel('image/png', file.name, file64));
      });
    } else {
      /// User canceled the picker
    }
  }

  void getContracts() async {
    setState(() {
      loading = true;
    });

    try {
      final response = await Apiservice.getcontracts();

      setState(() {
        loading = false;
      });

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);

        if (jsonData['status'].toString() == "true") {
          List contractsJsonList = jsonData['message'] ?? [];

          allContracts =
              contractsJsonList.map((c) => ContractModel.fromJson(c)).toList();

          // Categorize contracts by status
          activeContracts =
              allContracts.where((c) => c.contractStatus == "ACTIVE").toList();
          requestnumberlist.clear();

          requestnumberlist.addAll(
            activeContracts.map(
              (c) => MultiLevelString(
                contractno: c.contractNo ?? '',
                building: c.contractBuilding ?? '',
                unit: c.contractUnitno ?? '',
                contractorstartdate: c.contractStartdate ?? '',
                contractorenddate: c.contractEnddate ?? '',
                buildingid: c.buildingid ?? '',
                unitid: c.unitid ?? '',
                erajNo: c.contractErajno ?? '',
              ),
            ),
          );
        } else {
          activeContracts.clear();
          requestnumberlist.clear();
          AppUtils.showSingleDialogPopup(
              context, jsonData['message'].toString(), "Ok", exitpopup);
        }
      } else {
        throw Exception('Failed to load contracts: ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        loading = false;
      });

      AppUtils.showSingleDialogPopup(context, e.toString(), "Ok", exitpopup);
    }
  }

  void exitpopup() {
    AppUtils.pop(context);
  }

  void uploadimagetonetsuite() async {
    setState(() {
      loading = true;
    });
    Apiservice.postimages("image/jpeg", filename, base64format)
        .then((response) {
      setState(() {
        loading = false;
      });
      if (response.statusCode == 200) {
        if (jsonDecode(response.body)['status'] == true) {
          postrequestdetails(jsonDecode(response.body)['message'],
              jsonDecode(response.body)['url'].toString());
        } else {
          AppUtils.showSingleDialogPopup(context,
              jsonDecode(response.body)['message'].toString(), "Ok", exitpopup);
        }
      } else {
        throw Exception(jsonDecode(response.body)['message']);
      }
    }).catchError((e) {
      setState(() {
        loading = false;
      });
      AppUtils.showSingleDialogPopup(context, e.toString(), "Ok", exitpopup);
    });
  }

  void getgetrequestmaster() async {
    setState(() {
      loading = true;
    });
    var body = {"headerid": getcategoryId};
    Apiservice.getrequesttypemaster(body).then((response) {
      setState(() {
        loading = false;
      });
      if (response.statusCode == 200) {
        if (jsonDecode(response.body)['status'].toString() == "true") {
          requestTypeModel =
              RequestTypeModel.fromJson(jsonDecode(response.body));

          subcategorylist.clear();
          for (int i = 0; i < requestTypeModel.message!.length; i++) {
            subcategorylist.add(SubCategoryTypeString(
                subcatid: requestTypeModel.message![i].internalid.toString(),
                subcatname: requestTypeModel.message![i].name.toString()));
          }
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

  void getmaincategorymaster() async {
    setState(() {
      loading = true;
    });
    Apiservice.getmaincategorymaster().then((response) {
      setState(() {
        loading = false;
      });
      if (response.statusCode == 200) {
        if (jsonDecode(response.body)['status'].toString() == "true") {
          requestTypeModel =
              RequestTypeModel.fromJson(jsonDecode(response.body));

          categorylist.clear();
          for (int i = 0; i < requestTypeModel.message!.length; i++) {
            categorylist.add(CategoryTypeString(
                catid: requestTypeModel.message![i].internalid.toString(),
                catname: requestTypeModel.message![i].name.toString()));
          }
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

  void refreshscreen() {
    AppUtils.pop(context);
    AppUtils.pop(context);
  }
}

class MultiLevelString {
  String? contractno;
  String? building;
  String? unit;
  String? contractorstartdate;
  String?contractorenddate;
  String? buildingid;
  String? unitid;
  String? erajNo;
  MultiLevelString(
      { this.contractno,
       this.building,
       this.unit,
       this.contractorstartdate,
       this.contractorenddate,
       this.buildingid,
       this.unitid,
       this.erajNo});

  @override
  String toString() => contractno!;
}

// class RequestTypeString {
//   String reqtypeid;
//   String reqtypename;

//   RequestTypeString({
//     required this.reqtypeid,
//     required this.reqtypename,
//   });

//   @override
//   String toString() => '$reqtypeid - $reqtypename ';
// }

class CategoryTypeString {
  String catid;
  String catname;

  CategoryTypeString({
    required this.catid,
    required this.catname,
  });

  @override
  String toString() => '$catid - $catname ';
}

class SubCategoryTypeString {
  String subcatid;
  String subcatname;

  SubCategoryTypeString({
    required this.subcatid,
    required this.subcatname,
  });

  @override
  String toString() => '$subcatid - $subcatname ';
}

class CallsType {
  String? id;
  String? name;

  CallsType({this.id, this.name});

  @override
  String toString() {
    return '$name';
  }
}
