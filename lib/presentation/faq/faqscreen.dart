import 'dart:convert';

import 'package:dugasta/data/api_service.dart';
import 'package:dugasta/presentation/model/faqmodel.dart';
import 'package:dugasta/presentation/util/app_colors.dart';
import 'package:dugasta/presentation/util/app_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({super.key});

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  bool loading = false;
  FAQModel faqModel = FAQModel();
  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppUtils.buildNormalText(
            text: "FAQ", fontSize: 18, color: Colors.white),
      ),
      body: !loading
          ? SingleChildScrollView(
              child: Column(
                children: [listviewitems()],
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  Widget listviewitems() {
    return ListView.builder(
        itemCount: faqModel.message!.length,
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return Container(
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
              child: Theme(
                data: ThemeData(
                  dividerColor: Colors.transparent,
                ),
                child: ExpansionTile(
                  showTrailingIcon: false,
                  leading: Icon(
                    Icons.keyboard_arrow_down_sharp,
                    color: Colors.grey,
                  ),
                  expandedAlignment: Alignment.centerLeft,
                  iconColor: AppColor.primaryColor,
                  initiallyExpanded: false,
                  title: AppUtils.buildNormalText(
                      text: faqModel.message![index].name.toString()),
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 14),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppUtils.buildNormalText(
                            text: faqModel.message![index].ans.toString(),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ));
        });
  }

  void getData() async {
    setState(() {
      loading = true;
    });
    Apiservice.getfaqlist().then((response) {
      setState(() {
        loading = false;
      });
      if (response.statusCode == 200) {
        if (jsonDecode(response.body)['status'].toString() == "true") {
          faqModel = FAQModel.fromJson(jsonDecode(response.body));
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
