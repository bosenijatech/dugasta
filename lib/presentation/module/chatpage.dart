import 'dart:convert';

import 'package:dugasta/data/api_service.dart';
import 'package:dugasta/domain/pref.dart';
import 'package:dugasta/presentation/model/chequemodel.dart';
import 'package:dugasta/presentation/model/feedbackmodel.dart';
import 'package:dugasta/presentation/module/landingpage/landingscreen.dart';
import 'package:dugasta/presentation/util/app_colors.dart';
import 'package:dugasta/presentation/util/app_utils.dart';
import 'package:dugasta/presentation/utils/custom_button.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController datecontroller = TextEditingController();
  bool loading = false;
  bool holddate = false;
  TextEditingController memocontroller = TextEditingController();
  String type = "";
  final myKey1 = GlobalKey<DropdownSearchState<FeedbackListModel>>();
  List<FeedbackListModel> feedbacklist = [];
  String strfeedbackcode = "";
  String strfeedbackname = "";
  FeedbackModel model = FeedbackModel();

  @override
  void initState() {
    getfeedback();
    super.initState();
  }

  @override
  void dispose() {
    datecontroller.dispose();
    memocontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Feedback ',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: !loading
          ? SingleChildScrollView(
              child: Column(
                children: [details()],
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  Widget details() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      margin: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // AppUtils.buildNormalText(text: "Choose Feedback", fontSize: 14),
          SizedBox(
            height: 10,
          ),
          DropdownSearch<FeedbackListModel>(
              key: myKey1,
              compareFn: (i1, i2) => i1.feedbackcode == i2.feedbackcode,
              items: feedbacklist,
              dropdownDecoratorProps: DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  labelText: 'Select Feedback *',
                
                  
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.black, width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.black, width: 1),
                  ),
                ),
              ),
              popupProps: PopupProps.menu(
                showSelectedItems: true,
                interceptCallBacks: true, //important line
                itemBuilder: (ctx, item, isSelected) {
                  return ListTile(
                      selected: isSelected,
                      title: AppUtils.buildNormalText(
                        text: item.feedbackname.toString(),
                      ),
                      onTap: () {
                        myKey1.currentState?.popupValidate([item]);
                        strfeedbackcode = item.feedbackcode.toString();
                        strfeedbackname = item.feedbackname.toString();

                        setState(() {});
                      });
                },
                showSearchBox: true,
              ),
              selectedItem: FeedbackListModel(
                  feedbackcode: strfeedbackcode,
                  feedbackname: strfeedbackname)),
          const SizedBox(
            height: 15,
          ),
          SizedBox(
            height: 10,
          ),
          Visibility(
            visible: holddate,
            child: Text('Cheque Hold Up to'),
          ),
          SizedBox(
            height: 10,
          ),
        
          // AppUtils.buildNormalText(text: "Remarks", fontSize: 14),
      
          TextField(
            controller: memocontroller,
            keyboardType: TextInputType.multiline,
            maxLines: 4,
            decoration: InputDecoration(
              counterText: "",
              labelText: "Remarks",
              floatingLabelStyle: TextStyle(color: AppColor.primaryText),
              focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: Colors.grey)),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(color: Colors.black26, width: 1),
              ),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          CustomButton(
            onPressed: () {
              if (strfeedbackcode.isEmpty) {
                AppUtils.showSingleDialogPopup(
                    context, "Choose any one feedback", "Ok", exitpopup);
              } else if (memocontroller.text.isEmpty) {
                AppUtils.showSingleDialogPopup(
                    context, "Enter Remarks", "Ok", exitpopup);
              } else {
                postfeedback();
              }
            },
            name: "Submit",
            circularvalue: 10,
            fontSize: 16,
          )
        ],
      ),
    );
  }

  void postfeedback() {
    setState(() {
      loading = true;
    });

    var body = {
      "code": strfeedbackcode,
      "name": strfeedbackname,
      "remarks": memocontroller.text,
      "createdbyid": Prefs.getId("Id").toString(),
      "createdbyname": Prefs.getName("Name").toString(),
    };

    Apiservice.postfeedbacktransaction(body).then((response) {
      setState(() {
        loading = false;
      });
      if (response.statusCode == 200) {
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
        throw Exception(jsonDecode(response.body)['message'].toString());
      }
    }).catchError((e) {
      setState(() {
        loading = false;
      });
      print(e.toString());
      AppUtils.showSingleDialogPopup(context, e.toString(), "Ok", exitpopup);
    });
  }

  void exitpopup() {
    AppUtils.pop(context);
  }

  void refreshscreen() {
    AppUtils.pop(context);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LandingScreenPage()),
    );
  }

  void getfeedback() async {
    setState(() {
      loading = true;
    });
    Apiservice.getfeedbacklist().then((response) {
      setState(() {
        loading = false;
      });
      if (response.statusCode == 200) {
        if (jsonDecode(response.body)['status'].toString() == "true") {
          model = FeedbackModel.fromJson(jsonDecode(response.body));
          feedbacklist.clear();
          for (var element in model.message!) {
            feedbacklist.add(FeedbackListModel(
                feedbackcode: element.code.toString(),
                feedbackname: element.name.toString()));
          }
        } else {
          model.message = null;
          feedbacklist.clear();
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
}

class FeedbackListModel {
  String feedbackcode;
  String feedbackname;
  FeedbackListModel({required this.feedbackcode, required this.feedbackname});
  @override
  String toString() => feedbackname;
}
