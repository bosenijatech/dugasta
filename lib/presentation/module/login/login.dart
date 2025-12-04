import 'dart:convert';

import 'package:dugasta/data/api_service.dart';
import 'package:dugasta/domain/pref.dart';
import 'package:dugasta/presentation/forgotpassword/forgotpassword.dart';
import 'package:dugasta/presentation/model/loginmodel.dart';
import 'package:dugasta/presentation/module/landingpage/landingscreen.dart';
import 'package:dugasta/presentation/module/login/otpverify.dart';
import 'package:dugasta/presentation/module/login/registerpage.dart';
import 'package:dugasta/presentation/module/login/signup.dart';
import 'package:dugasta/presentation/util/app_colors.dart';
import 'package:dugasta/presentation/util/app_utils.dart';
import 'package:dugasta/presentation/utils/apptheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

import 'package:package_info_plus/package_info_plus.dart';

import '../../model/loginmodel.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  TextEditingController usernamecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  bool loading = false;
  LoginModel loginModel = LoginModel();
  bool passwordVisible = false;
  String version = "";
  String buildNumber = "";
  @override
  void initState() {
    getpackage();
    checkLoggedInStatus();
    super.initState();
  }

  void getpackage() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      version = packageInfo.version;
      buildNumber = packageInfo.buildNumber;
    });
  }

  @override
  void dispose() {
    usernamecontroller.dispose();
    passwordcontroller.dispose();
    super.dispose();
  }

  void checkLoggedInStatus() async {
  bool? isLoggedIn = await Prefs.getLoggedIn("IsLoggedIn");
  if (isLoggedIn == true) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => LandingScreenPage()),
      (route) => false,
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: !loading
          ? Container(
              decoration: BoxDecoration(
                  // image: DecorationImage(
                  //   image: AssetImage("assets/images/backgroundimage.png"),
                  //   fit: BoxFit.cover,
                  // ),
                  ),
              child: Padding(
                padding: const EdgeInsets.only(top: 100),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Image(
                        image: AssetImage("assets/images/logo.png"),
                        //height: 100,
                        fit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    // _topBar,
                    _bottomBar
                  ],
                ),
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
      persistentFooterButtons: [
        Center(child: Text("App Version Code : $version"))
      ],
    );
  }

  // Widget get _topBar => Center(
  //       child: Padding(
  //         padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
  //         child: Image.asset(
  //           'assets/images/header.png',
  //         ),
  //       ),
  //     );
  Widget get _bottomBar => Expanded(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(60), topRight: Radius.circular(60))),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    "DUGASTA - Real Estate",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColor.primary,
                        letterSpacing: 1),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Use your tenant email and password to sign in.",
                    style: TextStyle(
                      color: AppTheme.textGray,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  usernametextfield("Email ID", false, usernamecontroller),
                  passwordtextfield('Password', true, passwordcontroller),

                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(),
                      forgotpassword,
                    ],
                  ),
                  _loginButton,

                  // _loginwithotp,
                  // Container(
                  //   margin: EdgeInsets.only(bottom: 10),
                  //   child: CustomButton(
                  //     onPressed: () {},
                  //     name: "Login With OTP",
                  //     circularvalue: 40,
                  //     fontSize: 18,
                  //   ),
                  // ),

                  // _registerpage,
                  // SizedBox(
                  //   height: 10,
                  // ),
                ],
              ),
            ),
          ),
        ),
      );

  Widget usernametextfield(String text, bool obscure, usernamecontroller) =>
      Padding(
        padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
        child: TextFormField(
          style: const TextStyle(color: Colors.black),
          textAlign: TextAlign.left,
          controller: usernamecontroller,
          obscureText: obscure,
          autocorrect: false,
          cursorColor: Colors.grey,
          maxLines: 1,
          decoration: InputDecoration(
            // hintText: "Email ID",
            labelText: "Email ID",
            labelStyle: TextStyle(color: AppColor.textGray),
            floatingLabelStyle: TextStyle(color: AppColor.primary),
            border: myinputborder(), //normal border
            enabledBorder: myinputborder(), //enabled border
            focusedBorder: myfocusborder(),
          ),
        ),
      );
  Widget passwordtextfield(String text, bool obscure, passwordcontroller) =>
      Padding(
          padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
          child: TextField(
            style: const TextStyle(color: Colors.black),
            textAlign: TextAlign.left,
            obscureText: passwordVisible,
            autocorrect: false,
            controller: passwordcontroller,
            cursorColor: Colors.grey,
            maxLines: 1,
            decoration: InputDecoration(
              labelText: "Password",
              labelStyle: TextStyle(color: AppColor.textGray),
              floatingLabelStyle: TextStyle(color: AppColor.primary),
              border: myinputborder(), //normal border
              enabledBorder: myinputborder(), //enabled border
              focusedBorder: myfocusborder(),
              suffixIcon: IconButton(
                icon: Icon(
                  passwordVisible ? Icons.visibility : Icons.visibility_off,
                  color: Colors.black,
                ),
                onPressed: () {
                  // Update the state i.e. toogle the state of passwordVisible variable
                  setState(() {
                    passwordVisible = !passwordVisible;
                  });
                },
              ),
            ),
          ));

  Widget get _loginButton => Center(
        child: Padding(
            padding: const EdgeInsets.only(top: 30),
            child: SizedBox(
              height: 50,
              width: double.infinity,
              child: Container(
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: AppColor.kwhite,
                      blurRadius:
                          10.0, // has the effect of softening the shadow
                      spreadRadius:
                          1.0, // has the effect of extending the shadow
                      offset: Offset(
                        0.0,
                        5.0,
                      ),
                    ),
                  ],
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: AppColor.accentColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  onPressed: () {
                    if (usernamecontroller.text.isEmpty) {
                      AppUtils.showSingleDialogPopup(
                          context, "Enter User Name!", "Ok", exitpopup);
                    } else if (passwordcontroller.text.isEmpty) {
                      AppUtils.showSingleDialogPopup(
                          context, "Enter User Name!", "Ok", exitpopup);
                    } else {
                      getlogin();
                    }
                  },
                  child: const Text(
                    "Sign In",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
            )),
      );

  Widget get _loginwithotp => InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const RegisterPage()),
          );
        },
        child: Center(
          child: AppUtils.buildNormalText(text: "Login With OTP", fontSize: 16),
        ),
      );

  Widget get _registerpage => Container(
        padding: EdgeInsets.all(20.0),
        alignment: Alignment.center,
        child: RichText(
          text: TextSpan(
            text: "Don't have account? ",
            style: TextStyle(
              fontSize: 15.0,
              color: Colors.black,
            ),
            children: [
              TextSpan(
                  text: "Register here",
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.w500,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Signup()),
                      );
                    })
            ],
          ),
        ),
      );

  Widget get forgotpassword => Container(
        // padding: EdgeInsets.all(20.0),
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
                  text: "Forgot password?",
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.red,
                    fontWeight: FontWeight.w500,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ResetPasswordPage()),
                      );
                    })
            ],
          ),
        ),
      );
  // Widget get _registerpage => InkWell(
  //       onTap: () {
  //         Navigator.push(
  //           context,
  //           MaterialPageRoute(builder: (context) => const Signup()),
  //         );
  //       },
  //       child: Center(
  //         child: AppUtils.buildNormalText(
  //             text: "Don't have account? Register!.", fontSize: 16),
  //       ),
  //     );

  // void getlogin() async {
  //   setState(() {
  //     loading = true;
  //   });
  //   Apiservice.getlogin(usernamecontroller.text, passwordcontroller.text)
  //       .then((response) {
  //     setState(() {
  //       loading = false;
  //     });
  //     if (response.statusCode == 200) {
  //       if (jsonDecode(response.body)['status'].toString() == "true") {
  //         loginModel = LoginModel.fromJson(jsonDecode(response.body));
  //         addsharedpref(loginModel);
  //       } else {
  //         loginModel.message = null;
  //         AppUtils.showSingleDialogPopup(context,
  //             jsonDecode(response.body)['message'].toString(), "Ok", exitpopup);
  //       }
  //       //return response;
  //     } else {
  //       throw Exception(jsonDecode(response.body)['message'].toString());
  //     }
  //   }).catchError((e) {
  //     setState(() {
  //       loading = false;
  //     });
  //     AppUtils.showSingleDialogPopup(context, e.toString(), "Ok", exitpopup);
  //   });
  // }


void getlogin() async {
  setState(() {
    loading = true;
  });
print("🔹 Login started with username: '${usernamecontroller.text}' and password: '${passwordcontroller.text}'");


  Apiservice.getlogin(usernamecontroller.text, passwordcontroller.text)
      .then((response) {
    setState(() {
      loading = false;
    });
    print("🔹 Response received: ${response.body}");
    print("🔹 Status code: ${response.statusCode}");

    if (response.statusCode == 200) {
      var responseJson = jsonDecode(response.body);
      print("🔹 Response JSON: $responseJson");

      if (responseJson['status'].toString() == "true") {
        loginModel = LoginModel.fromJson(responseJson);
        print("✅ Login successful, user: ${loginModel.data ?? 'N/A'}");
        addsharedpref(loginModel);
      } else {
        loginModel.message = null;
        print("❌ Login failed: ${responseJson['message']}");
        AppUtils.showSingleDialogPopup(
            context, responseJson['message'].toString(), "Ok", exitpopup);
      }
    } else {
      print("❌ HTTP Error: ${jsonDecode(response.body)['message']}");
      throw Exception(jsonDecode(response.body)['message'].toString());
    }
  }).catchError((e) {
    setState(() {
      loading = false;
    });
    print("⚠️ Exception caught: $e");
    AppUtils.showSingleDialogPopup(context, e.toString(), "Ok", exitpopup);
  });
}

  void exitpopup() {
    AppUtils.pop(context);
  }

  Future addsharedpref(LoginModel model) async {
    await Prefs.setId("Id", model.data!.id.toString());
   // await Prefs.setCustomerName(
     //   "CusName", model.data!.firstName.toString());
    await Prefs.setTenantId("TenantId", model.data!.internalId.toString());
    await Prefs.setActive("active", model.data!.isactive.toString());
   await Prefs.setRole("customerType", model.data!.customerType.toString());
await Prefs.setToken("token", model.token.toString());
await Prefs.setcompanyName("companyName", model.data!.companyName.toString());
await Prefs.setMobileNo("MobileNo", model.data!.phone.toString());
await Prefs.setEmail("Email", model.data!.email.toString());
print("✅ Token saved: ${model.token}");


print("🟩 Token from Prefs: ${Prefs.getToken("token")}");



    await Prefs.setcompanyName(
       "companyName", model.data!.companyName.toString());
 
    await Prefs.setName("Name",
        '${model.data!.firstName.toString()} ${model.data!.lastName.toString()}');

    await Prefs.setFirstName(
        "FirstName", model.data!.firstName.toString());

    await Prefs.setMobileNo(
        "MobileNo", model.data!.phone.toString());

    await Prefs.setEmail("Email", model.data!.email.toString());
    await Prefs.setCustomerId(
        "CustomerID", model.data!.customerId.toString());

    //await Prefs.setPassportNo(
   //     "PassportNo",
// model.message!.tenantPassportno.toString() != "null"
    //        ? model.message!.tenantPassportno.toString()
    //        : "");

   // await Prefs.setPassportExpDate(
    //    "PassportExpDate",
    //    model.message!.tenantPassportexpdate.toString() != "null"
     //       ? model.message!.tenantPassportexpdate.toString()
      //      : "");

   // await Prefs.setEmiratesNo(
    //    "EmiratesNo", model.message!.tenantEmirtesid.toString());

  //  await Prefs.setEmiratsExpDate(
    //    "EmiratesExpDate",
    //    model.message!.tenantEmirtesexpdate.toString() != "null"
     //       ? model.message!.tenantEmirtesexpdate.toString()
    //        : "");

    await Prefs.setSubSidiary(
        "subsidiary", model.data!.subsidiary.toString());

 //   await Prefs.setincharge("incharge", model.message!.incharge.toString());

    // if (model.data!.isactive.toString() == "N" &&
    //     model.message!.toString() == "Lead") {
    //   Navigator.of(context)
    //       .push(MaterialPageRoute(builder: (context) => OtpVerifyScreen()));
    // } else if (model.data!.isactive.toString() == "N" &&
    //     model.message!.toString() == "Customer") {
    //   forcelogout();
    // } else {
    //   Prefs.setLoggedIn("IsLoggedIn", true);

    //   if (Prefs.getIncharge("incharge").toString() == "null" ||
    //       Prefs.getIncharge("incharge").toString() == "0") {
    //     updatelogindetails();
    //   } else {
    //     Navigator.of(context).pushAndRemoveUntil(
    //         MaterialPageRoute(builder: (context) => LandingScreenPage()),
    //         (Route<dynamic> route) => false);
    //   }
    // }

//     if (model.data!.isactive.toString() == "N") {
//   // User is not active, handle accordingly
//   forcelogout(); // or show OTP if needed
// } else {
//   // User is active, go to landing page
//   Prefs.setLoggedIn("IsLoggedIn", true);

//   if (Prefs.getIncharge("incharge").toString() == "null" ||
//       Prefs.getIncharge("incharge").toString() == "0") {
//     updatelogindetails();
//   } else {
//     Navigator.of(context).pushAndRemoveUntil(
//       MaterialPageRoute(builder: (context) => LandingScreenPage()),
//       (Route<dynamic> route) => false,
//     );
//   }
// }
 await Prefs.setLoggedIn("IsLoggedIn", true);
Navigator.of(context).pushAndRemoveUntil(
  MaterialPageRoute(builder: (context) => LandingScreenPage()),
  (Route<dynamic> route) => false,
);


   }

  OutlineInputBorder myinputborder() {
    //return type is OutlineInputBorder
    return OutlineInputBorder(
        //Outline border type for TextFeild
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(
          color: Colors.grey,
          width: 1,
        ));
  }

  OutlineInputBorder myfocusborder() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(
          color: Colors.grey,
          width: 1,
        ));
  }

  void updatelogindetails() async {
    setState(() {
      loading = true;
    });
    Apiservice.loginupdate().then((response) {
      setState(() {
        loading = false;
      });
      if (response.statusCode == 200) {
        if (jsonDecode(response.body)['status'].toString() == "true") {
          Prefs.setincharge("incharge", "1");
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => LandingScreenPage()),
              (Route<dynamic> route) => false);
        } else {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => LandingScreenPage()),
              (Route<dynamic> route) => false);
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

  forcelogout() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            title: const Text(
                "Your account has been Inactive. please contact your SAS realestate!."),
            titleTextStyle: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black, fontSize: 14),
            actionsOverflowButtonSpacing: 10,
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Prefs.clear();
                    Prefs.remove("remove");
                    Prefs.setLoggedIn("IsLoggedIn", false);
                    Navigator.pushAndRemoveUntil<void>(
                      context,
                      MaterialPageRoute<void>(
                          builder: (BuildContext context) =>
                              const LoginScreen()),
                      ModalRoute.withName('/'),
                    );
                  },
                  child: const Text("Ok")),
            ],
          ),
        );
      },
    );
  }
}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}



