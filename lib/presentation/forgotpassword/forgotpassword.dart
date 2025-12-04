import 'dart:convert';

import 'package:dugasta/data/api_service.dart';
import 'package:dugasta/presentation/util/app_utils.dart';
import 'package:dugasta/presentation/util/custom_indicatoronly.dart';
import 'package:dugasta/presentation/utils/custom_button.dart';
import 'package:flutter/material.dart';

import '../util/app_colors.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  TextEditingController emailcontroller = TextEditingController();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Forgot Password',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
      body: !loading
          ? SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Image.asset("assets/images/forgetimage.png"),
                      ),
                      const SizedBox(height: 10),
                      // const Text.rich(
                      //   textAlign: TextAlign.center,
                      //   TextSpan(
                      //     children: [
                      //       TextSpan(
                      //         text: "We will send you an ",
                      //         style: TextStyle(
                      //           color:AppColor.textGray,
                      //         ),
                      //       ),
                      //       TextSpan(
                      //         text: "Password in respective Mail id",
                      //         style: TextStyle(
                      //           color: AppColor.primary,
                      //           fontSize: 16,
                      //           fontWeight: FontWeight.bold,
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      Text(
                        "We will send you an ",
                        style: TextStyle(
                          color: AppColor.textGray,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 10,),
                      Text(
                        "Password in respective Mail id",
                        style: TextStyle(
                          color: AppColor.primary,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      )
,
                      const SizedBox(height: 15),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: TextFormField(
                          controller: emailcontroller,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Enter your email id",
                             labelStyle: TextStyle(color: AppColor.textGray),
             floatingLabelStyle: TextStyle(color: AppColor.primary),
              focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColor.primary),
    ),
                          ),
                          
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.emailAddress,
                          validator: (input) => input!.isValidEmail()
                              ? null
                              : "Enter your email id",
                        ),
                      ),
                      const SizedBox(height: 30),
                      CustomButton(
                          onPressed: () {
                            if (emailcontroller.text.isEmpty) {
                              AppUtils.showCustomDialog(context,
                                  "Please Enter Mail id", "Ok", exitpopup);
                            } else {
                              postmail();
                            }
                          },
                          name: "Submit",
                          circularvalue: 20)
                    ],
                  ),
                ),
              ),
            )
          : Center(
              child: CustomIndicator(),
            ),
    );
  }

  void postmail() async {
    setState(() {
      loading = true;
    });
    Apiservice.sendforgeotpassword(emailcontroller.text).then((response) {
      setState(() {
        loading = false;
      });
      if (response.statusCode == 200) {
        if (jsonDecode(response.body)['status'].toString() == "true") {
          AppUtils.showSingleDialogPopup(context,
              jsonDecode(response.body)['message'].toString(), "Ok", refresh);
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

  void refresh() {
    AppUtils.pop(context);
    AppUtils.pop(context);
  }
}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}
