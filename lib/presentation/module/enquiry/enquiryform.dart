import 'dart:convert';

import 'package:dugasta/data/api_service.dart';
import 'package:dugasta/domain/pref.dart';
import 'package:dugasta/presentation/model/apartmenttypemodel.dart';
import 'package:dugasta/presentation/module/termsandcondition/termsandconditionpage.dart';
import 'package:dugasta/presentation/util/apartmentlist.dart';
import 'package:dugasta/presentation/util/app_utils.dart';
import 'package:dugasta/presentation/utils/custom_button.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter/gestures.dart';

class Enquirypage extends StatefulWidget {
  List<ApartmentModel> house;
  final int position;
  int normaltype = 0;
  Enquirypage(
      {super.key,
      required this.house,
      required this.position,
      required this.normaltype});

  @override
  State<Enquirypage> createState() => _EnquirypageState();
}

class _EnquirypageState extends State<Enquirypage> {
  TextEditingController fullnamecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController mobilenocontroller = TextEditingController();
  TextEditingController remarkscontroller = TextEditingController();
  int groupValue = 1;
  int groupValue1 = 1;
  bool _value = false;
  bool loading = false;
  String selected = "";
  String enquirytype = "";
  final _formKey = GlobalKey<FormState>();
  List<String> apartmentlist = [];
  ApartmentTypeModel model = ApartmentTypeModel();
  String getbuildingname = "";
  String getbuildingid = "";
  @override
  void initState() {
    mobilenocontroller.text = Prefs.getMobileNo("MobileNo").toString();
    fullnamecontroller.text = Prefs.getCustomerName("CusName").toString();
    emailcontroller.text = Prefs.getName("Email").toString();
    getbuildingtype();
    super.initState();
  }

  @override
  void dispose() {
    fullnamecontroller.dispose();
    emailcontroller.dispose();
    mobilenocontroller.dispose();
    remarkscontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Enquiry Form',
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
              ));
  }

  Widget get getdetails => Container(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppUtils.buildNormalText(text: "NAME * "),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                readOnly: true,
                enabled: false,
                controller: fullnamecontroller,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  border: OutlineInputBorder(),
                  hintText: "ENTER NAME",
                ),
                textInputAction: TextInputAction.done,
                validator: (val) => val!.isEmpty ? "enter a valid name" : null,
              ),
              const SizedBox(
                height: 10,
              ),
              AppUtils.buildNormalText(text: "EMAIL * "),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                readOnly: true,
                enabled: false,
                controller: emailcontroller,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  border: OutlineInputBorder(),
                  hintText: "EMAIL",
                ),
                textInputAction: TextInputAction.done,
                validator: (val) =>
                    val!.isEmpty || !val.contains("@") || !val.contains('.')
                        ? "enter a valid email"
                        : null,
              ),
              const SizedBox(
                height: 10,
              ),
              AppUtils.buildNormalText(text: "MOBILE NUMBER * "),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: mobilenocontroller,
                maxLength: 10,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                keyboardType: TextInputType.number,
                validator: (val) => val!.isEmpty || val.length < 5
                    ? "enter a valid mobile number"
                    : null,
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
              const SizedBox(
                height: 10,
              ),
              // AppUtils.buildNormalText(text: "VALID EID * "),
              // Row(
              //   children: [
              //     Expanded(
              //       flex: 3,
              //       child: RadioListTile(
              //         groupValue: groupValue,
              //         title: Text("YES"),
              //         value: 1,
              //         onChanged: (newValue) =>
              //             setState(() => groupValue = newValue!.toInt()),
              //       ),
              //     ),
              //     Expanded(
              //       flex: 3,
              //       child: RadioListTile(
              //         groupValue: groupValue,
              //         title: Text("NO"),
              //         value: 2,
              //         onChanged: (newValue) =>
              //             setState(() => groupValue = newValue!.toInt()),
              //       ),
              //     ),
              //   ],
              // ),
              // const SizedBox(
              //   height: 10,
              // ),
              // AppUtils.buildNormalText(text: "MARITIAL STATUS * "),
              // Row(
              //   children: [
              //     Expanded(
              //       flex: 3,
              //       child: RadioListTile(
              //         groupValue: groupValue1,
              //         title: Text("MARRIED"),
              //         value: 1,
              //         onChanged: (newValue) =>
              //             setState(() => groupValue1 = newValue!.toInt()),
              //       ),
              //     ),
              //     Expanded(
              //       flex: 3,
              //       child: RadioListTile(
              //         groupValue: groupValue1,
              //         title: Text("SINGLE"),
              //         value: 2,
              //         onChanged: (newValue) =>
              //             setState(() => groupValue1 = newValue!.toInt()),
              //       ),
              //     ),
              //   ],
              // ),
              // const SizedBox(
              //   height: 10,
              // ),
              AppUtils.buildNormalText(text: "Apartment Type"),
              const SizedBox(
                height: 10,
              ),
              DropdownSearch<String>(
                popupProps: PopupProps.menu(
                  showSearchBox: true,
                  showSelectedItems: true,
                  disabledItemFn: (String s) => s.startsWith('I'),
                ),
                items: apartmentlist,
                onChanged: (val) {
                  enquirytype = val.toString();
                  for (int k = 0; k < model.message!.length; k++) {
                    if (val == model.message![k].name) {
                      getbuildingname = model.message![k].name.toString();
                      getbuildingid = model.message![k].internalid.toString();
                    }
                  }
                },
                selectedItem: "",
              ),
              const SizedBox(
                height: 10,
              ),
              AppUtils.buildNormalText(
                  text: "WHERE DID YOU HEAR ABOUT US ? * "),
              const SizedBox(
                height: 10,
              ),
              DropdownSearch<String>(
                popupProps: PopupProps.menu(
                  showSelectedItems: true,
                  disabledItemFn: (String s) => s.startsWith('I'),
                ),
                items: const [
                  "Property Finder",
                  "News Paper",
                  "Friend / Colleague",
                  'Previous Tenant'
                ],
                onChanged: (val) {
                  selected = val.toString();
                },
                selectedItem: "",
              ),
              const SizedBox(
                height: 10,
              ),
              AppUtils.buildNormalText(text: "MESSAGE * "),
              const SizedBox(
                height: 10,
              ),
              Container(
                  //padding: EdgeInsets.all(20),
                  child: TextField(
                controller: remarkscontroller,
                keyboardType: TextInputType.multiline,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: "Enter Message here",
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.grey)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide:
                        const BorderSide(color: Colors.black26, width: 1),
                  ),
                ),
              )),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Checkbox(
                        value: _value,
                        activeColor: Colors.brown,
                        onChanged: (value) {
                          setState(() {
                            _value = value!;
                          });
                        }),
                    Container(
                      alignment: Alignment.center,
                      child: RichText(
                        text: TextSpan(
                          text: "",
                          style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.black,
                          ),
                          children: [
                            TextSpan(
                                text: "Agree terms and conditions",
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.blueAccent,
                                  fontWeight: FontWeight.w500,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const Termsandconditionpage()),
                                    );
                                  })
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Container(
              //   padding: EdgeInsets.all(20.0),
              //   alignment: Alignment.center,
              //   child: RichText(
              //     text: TextSpan(
              //       text: "",
              //       style: TextStyle(
              //         fontSize: 15.0,
              //         color: Colors.black,
              //       ),
              //       children: const [
              //         TextSpan(
              //           text: "Agree terms and conditions",
              //           style: TextStyle(
              //             fontSize: 15.0,
              //             color: Colors.blueAccent,
              //             fontWeight: FontWeight.w500,
              //           ),
              //         )
              //       ],
              //     ),
              //   ),
              // ),
              // CheckboxListTile(
              //   contentPadding: EdgeInsets.symmetric(horizontal: 0),
              //   controlAffinity: ListTileControlAffinity.leading,
              //   title: AppUtils.buildNormalText(
              //       text: 'I AGREE TERMS AND CONDITIONS', fontSize: 14),
              //   autofocus: false,
              //   activeColor: Colors.green,
              //   checkColor: Colors.white,
              //   selected: _value,
              //   value: _value,
              //   onChanged: (value) {
              //     setState(() {
              //       _value = value!;
              //     });
              //   },
              // ),
              CustomButton(
                onPressed: () {
                  //_createFileFromString();
                  if (_formKey.currentState!.validate()) {
                    if (!_value) {
                      AppUtils.showCustomDialog(context,
                          "Please Tick Terms and Condition", "Ok", exitpopup);
                    } else {
                      postenquiry();
                    }
                  }
                },
                name: "Submit",
                circularvalue: 30,
                fontSize: 14,
              ) //Checkbo
            ],
          ),
        ),
      );

      
  void postenquiry() async {
    var body = {
      "properylocationid": widget.normaltype > 0
          ? widget.house[widget.position].internalid.toString()
          : "0",
      "propertylocationname": widget.normaltype > 0
          ? widget.house[widget.position].propertylocationname
          : "0".toString(),
      "propertyname": "0",
      "buildingname": widget.normaltype > 0
          ? widget.house[widget.position].buildingname.toString()
          : "0",
      "buildingtype": widget.normaltype > 0
          ? widget.house[widget.position].buildingtype.toString()
          : "0",
      "apartmentdescription": "-",
      "fullname": fullnamecontroller.text.toString(),
      "email": emailcontroller.text,
      "countrycode": Prefs.getCounrtryCode("Countrycode").toString(),
      "mobileno": mobilenocontroller.text,
      "isvalidEid": /*groupValue == 1 ? "Yes" :*/ "-",
      "maritialStatus": /* groupValue1 == 1 ? "Married" :*/ "-",
      "wherehereaboutthis": selected,
      "remarks": remarkscontroller.text,
      "createdbyid": Prefs.getCustomerId("CustomerID").toString(),
      "createdbyname": Prefs.getName("Name").toString(),
      "source": "Mob",
      "enquirytype": getbuildingname,
      //"customerId": Prefs.getCustomerId('CustomerID').toString(),
      "enquiryid": getbuildingid,
      "type": widget.normaltype,
      "subsidiary": 2 //Prefs.getSubsidiary("subsidiary"),
    };
    print(jsonEncode(body));
    setState(() {
      loading = true;
    });
    Apiservice.postenquiry(body).then((response) {
      setState(() {
        loading = false;
      });
      if (response.statusCode == 200) {
        if (jsonDecode(response.body)['status'].toString() == "true") {
          AppUtils.showSingleDialogPopup(context,
              jsonDecode(response.body)['message'].toString(), "Ok", onrefresh);
        } else {
          AppUtils.showSingleDialogPopup(context,
              jsonDecode(response.body)['message'].toString(), "Ok", exitpopup);
        }
        //return response;
        print(jsonDecode(response.body));
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

  void onrefresh() {
    AppUtils.pop(context);
    AppUtils.pop(context);
  }

  void getbuildingtype() async {
    setState(() {
      loading = true;
    });
    Apiservice.getbuildinglist().then((response) {
      setState(() {
        loading = false;
      });
      if (response.statusCode == 200) {
        if (jsonDecode(response.body)['status'].toString() == "true") {
          model = ApartmentTypeModel.fromJson(jsonDecode(response.body));
          apartmentlist.clear();
          for (int i = 0; i < model.message!.length; i++) {
            apartmentlist.add(model.message![i].name.toString());
          }
          print(jsonEncode(apartmentlist));
        } else {}
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
}
