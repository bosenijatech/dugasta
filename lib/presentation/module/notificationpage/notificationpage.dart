import 'dart:convert';

import 'package:dugasta/data/api_service.dart';
import 'package:dugasta/presentation/model/notificationmodel.dart';
import 'package:dugasta/presentation/util/app_utils.dart';
import 'package:dugasta/presentation/util/custom_indicatoronly.dart';
import 'package:flutter/material.dart';

class Notificationpage extends StatefulWidget {
  const Notificationpage({super.key});

  @override
  State<Notificationpage> createState() => _NotificationpageState();
}

class _NotificationpageState extends State<Notificationpage> {
  NotificationModel model = NotificationModel();
  bool loading = false;
  @override
  void initState() {
    getnotificationget();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final message = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: AppUtils.buildNormalText(
            text: "Notification Page", fontSize: 18, color: Colors.white),
      ),
      body: !loading
          ? SingleChildScrollView(
              child: Column(
                children: [notificationdetails()],
              ),
            )
          : Center(
              child: CustomIndicator(),
            ),
    );
  }

  Widget notificationdetails() {
    return model.message != null
        ? ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: model.message!.length,
            itemBuilder: (BuildContext ctxt, int index) {
              return Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: Icon(Icons.notifications),
                    title: AppUtils.buildNormalText(
                        text: '${model.message![index].notificationmessage}',
                        fontSize: 14,
                        maxLines: null),
                    subtitle: AppUtils.buildNormalText(
                        text: '${model.message![index].createddatetime}',
                        color: Colors.black45),
                    trailing: Icon(Icons.mail),
                  ),
                ),
              );
            })
        : Center(
            child: Text('No Notification Found!'),
          );
  }

  void getnotificationget() async {
    setState(() {
      loading = true;
    });
    Apiservice.getnotificationmaster().then((response) {
      setState(() {
        loading = false;
      });
      if (response.statusCode == 200) {
        if (jsonDecode(response.body)['status'].toString() == "true") {
          model = NotificationModel.fromJson(jsonDecode(response.body));
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
