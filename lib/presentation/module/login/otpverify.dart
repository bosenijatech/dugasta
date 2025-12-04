import 'dart:convert';

import 'package:dugasta/data/api_service.dart';
import 'package:dugasta/domain/pref.dart';
import 'package:dugasta/presentation/module/landingpage/landingscreen.dart';
import 'package:dugasta/presentation/util/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class OtpVerifyScreen extends StatefulWidget {
  const OtpVerifyScreen({Key? key}) : super(key: key);

  @override
  _OtpVerifyScreenState createState() => _OtpVerifyScreenState();
}

class _OtpVerifyScreenState extends State<OtpVerifyScreen> {
  late List<TextStyle?> otpTextStyles;
  late List<TextEditingController?> controls;
  int numberOfFields = 6;
  bool clearText = false;
  bool loading = false;
  String otpnumber = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xfff7f6fb),
        body: !loading
            ? SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 18, horizontal: 18),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Icon(
                            Icons.arrow_back,
                            size: 32,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          color: Colors.deepPurple.shade50,
                          shape: BoxShape.circle,
                        ),
                        child: Image.asset(
                          'assets/images/illustration-3.png',
                        ),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      Text(
                        'Verification',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Enter your OTP code number",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black38,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 28,
                      ),
                      Container(
                        padding: EdgeInsets.all(15),
                        height: 200,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            OtpTextField(
                              numberOfFields: numberOfFields,
                              borderColor: Colors.purple,
                              focusedBorderColor: Colors.purple,
                              //styles: otpTextStyles,
                              showFieldAsBox: true,
                              borderWidth: 4.0,
                              onCodeChanged: (String code) {
                                print(code);
                              },
                              onSubmit: (String verificationCode) {
                                setState(() {
                                  otpnumber = verificationCode;
                                  print(otpnumber);
                                });
                              }, // end onSubmit
                            ),
                            SizedBox(
                              height: 22,
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (otpnumber.isEmpty ||
                                      otpnumber.length < 6) {
                                    AppUtils.showSingleDialogPopup(context,
                                        "Please Enter OTP", "Ok", exitpopup);
                                  } else {
                                    postotpverify();
                                  }
                                },
                                style: ButtonStyle(
                                  foregroundColor:
                                      WidgetStateProperty.all<Color>(
                                          Colors.white),
                                  backgroundColor:
                                      WidgetStateProperty.all<Color>(
                                          Colors.purple),
                                  shape: WidgetStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(24.0),
                                    ),
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(14.0),
                                  child: Text(
                                    'Verify',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      Text(
                        "Didn't you receive any code?",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black38,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      Text(
                        "Resend New Code",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              )
            : Center(
                child: CircularProgressIndicator(),
              ));
  }

  Widget _textFieldOTP({bool? first, last}) {
    return SizedBox(
      //padding: EdgeInsets.only(bottom: 10),
      height: 80,
      child: AspectRatio(
        aspectRatio: 0.7,
        child: TextField(
          autofocus: true,
          onChanged: (value) {
            if (value.length == 1 && last == false) {
              FocusScope.of(context).nextFocus();
            }
            if (value.isEmpty && first == false) {
              FocusScope.of(context).previousFocus();
            }
          },
          showCursor: false,
          readOnly: false,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: InputDecoration(
            counter: Offstage(),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: Colors.black12),
                borderRadius: BorderRadius.circular(12)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: Colors.purple),
                borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ),
    );
  }

  void postotpverify() async {
    setState(() {
      loading = true;
    });
    Apiservice.postverifyotp(otpnumber).then((response) {
      setState(() {
        loading = false;
      });
      if (response.statusCode == 200) {
        if (jsonDecode(response.body)['status'].toString() == "true") {
          Prefs.setActive("active", "Y");
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => LandingScreenPage()),
              (Route<dynamic> route) => false);
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
