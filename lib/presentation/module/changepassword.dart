import 'dart:convert';

import 'package:dugasta/data/api_service.dart';
import 'package:dugasta/domain/pref.dart';
import 'package:dugasta/presentation/model/profilemodel.dart';
import 'package:dugasta/presentation/module/login/login.dart';
import 'package:dugasta/presentation/util/app_utils.dart';
import 'package:dugasta/presentation/util/custom_indicatoronly.dart';
import 'package:dugasta/presentation/utils/custom_button.dart';
import 'package:flutter/material.dart';

class ChangepasswordScreen extends StatefulWidget {
  ProfileModel model;
  ChangepasswordScreen({super.key, required this.model});

  @override
  State<ChangepasswordScreen> createState() => _ChangepasswordScreenState();
}

class _ChangepasswordScreenState extends State<ChangepasswordScreen> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController confirmpasswordcontroller = TextEditingController();
  bool passwordVisible = false;
  bool confirmpasswordVisible = false;
  bool loading = false;

  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    emailcontroller.text = widget.model.message!.tenantEmail.toString();
    super.initState();
  }

  @override
  void dispose() {
    emailcontroller.dispose();
    passwordcontroller.dispose();
    confirmpasswordcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Change Password",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: !loading
          ? SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 250,
                        width: double.infinity,
                        child: Image.asset("assets/images/changepwd.png"),
                      ),
                      AppUtils.buildNormalText(text: "Email", fontSize: 16),
                      const SizedBox(height: 10),
                      TextField(
                        controller: emailcontroller,
                        readOnly: true,
                        decoration: InputDecoration(
                            hintText: "Email",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide.none),
                            fillColor: Colors.grey.shade300,
                            filled: true,
                            prefixIcon: const Icon(Icons.email)),
                      ),
                      const SizedBox(height: 10),
                      AppUtils.buildNormalText(text: "Password", fontSize: 16),
                      const SizedBox(height: 10),
                      TextFormField(
                        obscureText: passwordVisible,
                        maxLength: 10,
                        controller: passwordcontroller,
                        validator: (value) {
                          // add your custom validation here.
                          if (value!.isEmpty) {
                            return 'Please enter Password';
                          }
                          if (value.length < 6) {
                            return 'Password Must be 6 charater and above';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "Password",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none),
                          filled: true,
                          fillColor: Colors.grey.shade300,
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: IconButton(
                            icon: Icon(
                                // Based on passwordVisible state choose the icon
                                passwordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.black),
                            onPressed: () {
                              // Update the state i.e. toogle the state of passwordVisible variable
                              setState(() {
                                passwordVisible = !passwordVisible;
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      AppUtils.buildNormalText(
                          text: "Confirm Password", fontSize: 16),
                      const SizedBox(height: 10),
                      TextFormField(
                        maxLength: 10,
                        controller: confirmpasswordcontroller,
                        validator: (values) {
                          // add your custom validation here.
                          if (values!.isEmpty) {
                            return 'Please Enter Confirm Password';
                          }
                          if (values.length < 6) {
                            return 'Confirm Password Must be 6 charater and above';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "Confirm Password",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none),
                          filled: true,
                          fillColor: Colors.grey.shade300,
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: IconButton(
                            icon: Icon(
                              // Based on passwordVisible state choose the icon
                              confirmpasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              // Update the state i.e. toogle the state of passwordVisible variable
                              setState(() {
                                confirmpasswordVisible =
                                    !confirmpasswordVisible;
                              });
                            },
                          ),
                        ),
                        obscureText: confirmpasswordVisible,
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            )
          : Center(
              child: CustomIndicator(),
            ),
      persistentFooterButtons: [
        CustomButton(
            onPressed: () {
              final isValid = formKey.currentState!.validate();
              if (!isValid) {
                return;
              }
              formKey.currentState!.save();
              if (passwordcontroller.text != confirmpasswordcontroller.text) {
                AppUtils.showCustomDialog(context,
                    "Old and Confirm Password Mismatch", "Ok", onexitpopup);
              } else {
                updatelogindetails();
              }
            },
            name: "Submit",
            circularvalue: 30)
      ],
    );
  }

  void updatelogindetails() async {
    var body = {
      "tenant_email": widget.model.message!.tenantEmail.toString(),
      "tenant_password": confirmpasswordcontroller.text,
      "customerId": Prefs.getCustomerId('CustomerID')
    };
    setState(() {
      loading = true;
    });
    Apiservice.passwordupdate(body).then((response) {
      setState(() {
        loading = false;
      });
      if (response.statusCode == 200) {
        if (jsonDecode(response.body)['status'].toString() == "true") {
          AppUtils.showCustomDialog(
              context, jsonDecode(response.body)['message'], "ok", onrefresh);
        } else {
          AppUtils.showCustomDialog(
              context, jsonDecode(response.body)['message'], "ok", onexitpopup);
        }
        //return response;
      } else {
        throw Exception(jsonDecode(response.body)['message'].toString());
      }
    }).catchError((e) {
      setState(() {
        loading = false;
      });
      AppUtils.showSingleDialogPopup(context, e.toString(), "Ok", onexitpopup);
    });
  }

  void onexitpopup() {
    AppUtils.pop(context);
  }

  void onrefresh() {
    AppUtils.pop(context);
    Prefs.clear();
    Prefs.remove("remove");
    Prefs.setLoggedIn("IsLoggedIn", false);
    Navigator.pushAndRemoveUntil<void>(
      context,
      MaterialPageRoute<void>(
          builder: (BuildContext context) => const LoginScreen()),
      ModalRoute.withName('/'),
    );
  }
}
