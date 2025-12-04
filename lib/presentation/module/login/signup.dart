import 'dart:convert';
import 'dart:io';

import 'package:dugasta/data/api_service.dart';
import 'package:dugasta/presentation/module/login/login.dart';
import 'package:dugasta/presentation/util/app_style.dart';
import 'package:dugasta/presentation/util/app_utils.dart';
import 'package:dugasta/presentation/utils/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  late List<String> countryCodes;
  final String _countryCode = "+1";
  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController countrycode = TextEditingController();
  TextEditingController mobilenumber = TextEditingController();
  TextEditingController userpassword = TextEditingController();
  TextEditingController consfirmpassword = TextEditingController();
  bool loading = false;
  @override
  void initState() {
    // countryCodes = [];
    // for (int i = 0; i < 100; i++) {
    //   countryCodes.add("+$i");
    // }
    super.initState();
  }

  @override
  void dispose() {
    firstname.dispose();
    lastname.dispose();
    email.dispose();
    countrycode.dispose();
    mobilenumber.dispose();
    userpassword.dispose();
    consfirmpassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: AppUtils.buildNormalText(
            text: "Register", fontSize: 20, color: Colors.white),
      ),
      body: !loading
          ? SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                child: Column(
                  children: [layoutdesign(size)],
                ),
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  Widget layoutdesign(size) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Image.asset(
            'assets/images/app_icon.png',
            width: 300,
            height: 150,
          ),
        ),
        AppUtils.buildNormalText(text: "First Name", fontSize: 14),
        SizedBox(height: size.height * 0.010),
        TextField(
          controller: firstname,
          style: const TextStyle(color: kLightTextColor),
          decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              hintText: "First Name",
              prefixIcon: IconButton(
                onPressed: null,
                icon: SvgPicture.asset(userIcon),
              ),
              border: OutlineInputBorder()),
        ),
        SizedBox(height: size.height * 0.010),
        AppUtils.buildNormalText(text: "Last Name", fontSize: 14),
        SizedBox(height: size.height * 0.010),
        TextField(
          controller: lastname,
          style: const TextStyle(color: kLightTextColor),
          decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              hintText: "Last Name",
              prefixIcon: IconButton(
                onPressed: null,
                icon: SvgPicture.asset(userIcon),
              ),
              border: OutlineInputBorder()),
        ),
        SizedBox(height: size.height * 0.010),
        AppUtils.buildNormalText(text: "Email", fontSize: 14),
        SizedBox(height: size.height * 0.010),
        TextField(
          controller: email,
          style: const TextStyle(color: kLightTextColor),
          decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              hintText: "Email",
              prefixIcon: IconButton(
                onPressed: null,
                icon: SvgPicture.asset(emailIcon),
              ),
              border: OutlineInputBorder()),
        ),
        SizedBox(height: size.height * 0.010),
        AppUtils.buildNormalText(text: "Phone Number", fontSize: 14),
        SizedBox(height: size.height * 0.010),
        Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: TextField(
              controller: mobilenumber,
              style: const TextStyle(color: kLightTextColor),
              decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  hintText: "Phone number",
                  prefixIcon: IconButton(
                    onPressed: null,
                    icon: SvgPicture.asset(userIcon),
                  ),
                  border: OutlineInputBorder()),
            )),
        SizedBox(height: size.height * 0.010),
        AppUtils.buildNormalText(text: "Password", fontSize: 14),
        SizedBox(height: size.height * 0.010),
        TextField(
          controller: userpassword,
          obscureText: true,
          style: const TextStyle(color: kLightTextColor),
          decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              hintText: "Password",
              prefixIcon: IconButton(
                onPressed: null,
                icon: SvgPicture.asset(lockIcon),
              ),
              border: OutlineInputBorder()),
        ),
        SizedBox(height: size.height * 0.010),
        AppUtils.buildNormalText(text: "Confirm Password", fontSize: 14),
        SizedBox(height: size.height * 0.010),
        TextField(
          controller: consfirmpassword,
          obscureText: true,
          style: const TextStyle(color: kLightTextColor),
          decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              hintText: "Confirm Password",
              prefixIcon: IconButton(
                onPressed: null,
                icon: SvgPicture.asset(lockIcon),
              ),
              border: OutlineInputBorder()),
        ),
        SizedBox(height: size.height * 0.025),
        CustomButton(
          onPressed: () {
            if (firstname.text.isEmpty) {
              AppUtils.showSingleDialogPopup(
                  context, "First Name is Empty", "Ok", exitpopup);
            } else if (lastname.text.isEmpty) {
              AppUtils.showSingleDialogPopup(
                  context, "Last Name is Empty", "Ok", exitpopup);
            } else if (mobilenumber.text.isEmpty) {
              AppUtils.showSingleDialogPopup(
                  context, "Mobile Number is Empty", "Ok", exitpopup);
            } else if (email.text.isEmpty) {
              AppUtils.showSingleDialogPopup(
                  context, "Email is Empty", "Ok", exitpopup);
            } else if (userpassword.text.isEmpty) {
              AppUtils.showSingleDialogPopup(
                  context, "User Password is Empty", "Ok", exitpopup);
            } else {
              callsignup();
            }
          },
          name: "SignUp",
          circularvalue: 30,
          fontSize: 16,
        ),
        SizedBox(height: size.height * 0.034),
        SizedBox(height: size.height * 0.041),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Already member ?\t",
              style: Theme.of(context).textTheme.titleSmall,
            ),
            CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                    (Route<dynamic> route) => false);
              },
              child: Text(
                "Sign In",
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(color: kTextColor),
              ),
            )
          ],
        )
      ],
    );
  }

  void callsignup() async {
    var body = {
      "firstName": firstname.text,
      "lastName": lastname.text,
      "email": email.text,
      "phone": mobilenumber.text,
      "subsidiary": 1,
      "userName": email.text,
      "password": userpassword.text,
    };
    setState(() {
      loading = true;
    });

    Apiservice.registerpage(body).then((response) {
      setState(() {
        loading = false;
      });

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (jsonDecode(response.body)['success'].toString() == "true") {
          AppUtils.showSingleDialogPopup(context,
              jsonDecode(response.body)['message'].toString(), "Ok", onrefresh);
        } else {
          //  print(response.body);
          AppUtils.showSingleDialogPopup(context,
              jsonDecode(response.body)['message'].toString(), "Ok", exitpopup);
        }
      } else {
        //print(jsonDecode(response.body)['message']);
        throw Exception(jsonDecode(response.body)['message'].toString());
      }
    }).catchError((e) {
      setState(() {
        loading = false;
      });
      if (e is SocketException) {
        AppUtils.showSingleDialogPopup(
            context,
            "Server Not connected or please Check your Internet Connections!",
            "Ok",
            exitpopup);
      } else {
        AppUtils.showSingleDialogPopup(context, e.toString(), "Ok", exitpopup);
      }
    });
  }

  void onrefresh() {
    Navigator.canPop(context);
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => LoginScreen()),
        (Route<dynamic> route) => false);
    // Navigator.of(context)
    //     .push(MaterialPageRoute(builder: (context) => OtpVerifyScreen()));
  }

  void exitpopup() {
    Navigator.of(context).pop();
  }
}
