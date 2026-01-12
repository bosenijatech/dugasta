import 'dart:convert';

import 'package:dugasta/data/api_service.dart';
import 'package:dugasta/domain/pref.dart';
import 'package:dugasta/presentation/model/profilemodel.dart';
import 'package:dugasta/presentation/module/changepassword.dart';
import 'package:dugasta/presentation/module/login/login.dart';
import 'package:dugasta/presentation/module/profilepage/edit_profile.dart';
import 'package:dugasta/presentation/util/app_colors.dart';
import 'package:dugasta/presentation/util/app_utils.dart';
import 'package:dugasta/presentation/util/appcontants.dart';
import 'package:dugasta/presentation/utils/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../model/sales_profilemodel.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
    ProfileList? profile;
  bool Active = false;
  bool loading = false;
  ProfileModel model = ProfileModel();
  @override
  void initState() {
    getprofiledata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: AppUtils.buildNormalText(
            text: "Profile Page", fontSize: 20, color: Colors.white),
        actions: [
          PopupMenuButton(
            onSelected: (item) => handleClick(item as int),
            itemBuilder: (ctx) => [
              _buildPopupMenuItem("Change Password", Icons.lock, 1),
              _buildPopupMenuItem("Logout", Icons.exit_to_app, 2)
            ],
          )
        ],
        // actions: [
        //   IconButton(
        //       onPressed: () {
        //         if (model.message != null) {
        //           Navigator.push(
        //                   context,
        //                   MaterialPageRoute(
        //                       builder: (context) =>
        //                           ChangepasswordScreen(model: model)))
        //               .then((_) => getprofiledata());
        //         } else {
        //           AppUtils.showSingleDialogPopup(
        //               context, "Please Try Later", "Ok", exitpopup);
        //         }
        //       },
        //       icon: Icon(CupertinoIcons.lock))
        // ],
      ),
      body: !loading
          ? Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Image.asset(
                      "assets/images/user.png",
                      fit: BoxFit.fill,
                      width: 100,
                      height: 100,
                    ),
                    SizedBox(height: 10),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        model.message != null
                            ? model.message!.tenantFirstname.toString()
                            : "",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      model.message != null
                          ? model.message!.tenantMobileno.toString()
                          : "",
                    ),
                    Card(
                      elevation: 4,
                      shadowColor: Colors.black12,
                      child: ListTile(
                        leading: Icon(
                          CupertinoIcons.briefcase_fill,
                          color: AppColor.accentColor,
                        ),
                        title: AppUtils.buildNormalText(
                            text: "Customer ID",
                            fontSize: 12,
                            color: Colors.black54),
                        subtitle: AppUtils.buildNormalText(
                          text: model.message != null
                              ? model.message!.customerId.toString()
                              : "",
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Card(
                        elevation: 4,
                        shadowColor: Colors.black12,
                        child: ListTile(
                          leading: Icon(
                            CupertinoIcons.mail,
                            color: AppColor.accentColor,
                          ),
                          title: AppUtils.buildNormalText(
                              text: "Email",
                              fontSize: 12,
                              color: Colors.black54),
                          subtitle: AppUtils.buildNormalText(
                            text: model.message != null
                                ? model.message!.tenantEmail.toString()
                                : "",
                            fontSize: 14,
                          ),
                        )),
                    Card(
                        elevation: 4,
                        shadowColor: Colors.black12,
                        child: ListTile(
                          leading: Icon(
                            CupertinoIcons.phone,
                            color: AppColor.accentColor,
                          ),
                          title: AppUtils.buildNormalText(
                              text: "Mobile No",
                              fontSize: 12,
                              color: Colors.black54),
                          subtitle: AppUtils.buildNormalText(
                            text: model.message != null
                                ? model.message!.tenantMobileno.toString()
                                : "",
                            fontSize: 14,
                          ),
                        )),
                    Card(
                        elevation: 4,
                        shadowColor: Colors.black12,
                        child: ListTile(
                          leading: Icon(
                            CupertinoIcons.airplane,
                            color: AppColor.accentColor,
                          ),
                          title: AppUtils.buildNormalText(
                              text: "Passport No",
                              fontSize: 12,
                              color: Colors.black54),
                          subtitle: AppUtils.buildNormalText(
                            text: model.message != null
                                ? model.message!.tenantPassportno.toString()
                                : "",
                            fontSize: 14,
                          ),
                        )),
                    Card(
                        elevation: 4,
                        shadowColor: Colors.black12,
                        child: ListTile(
                          leading: Icon(
                            CupertinoIcons.calendar_today,
                            color: AppColor.accentColor,
                          ),
                          title: AppUtils.buildNormalText(
                              text: "Passport Exp.Date",
                              fontSize: 12,
                              color: Colors.black54),
                          subtitle: AppUtils.buildNormalText(
                            text: model.message != null
                                ? model.message!.tenantPassportexpdate
                                    .toString()
                                : "",
                            fontSize: 14,
                          ),
                        )),
                    Card(
                        elevation: 4,
                        shadowColor: Colors.black12,
                        child: ListTile(
                          leading: Icon(
                            CupertinoIcons.list_number_rtl,
                            color: AppColor.accentColor,
                          ),
                          title: AppUtils.buildNormalText(
                              text: "Emirates Number",
                              fontSize: 12,
                              color: Colors.black54),
                          subtitle: AppUtils.buildNormalText(
                            text: model.message != null
                                ? model.message!.tenantEmirtesid.toString()
                                : "",
                            fontSize: 14,
                          ),
                        )),
                    Card(
                        elevation: 4,
                        shadowColor: Colors.black12,
                        child: ListTile(
                          leading: Icon(
                            CupertinoIcons.calendar_today,
                            color: AppColor.accentColor,
                          ),
                          title: AppUtils.buildNormalText(
                              text: "Emirates Exp.Date",
                              fontSize: 12,
                              color: Colors.black54),
                          subtitle: AppUtils.buildNormalText(
                            text: model.message != null
                                ? model.message!.tenantEmirtesexpdate.toString()
                                : "",
                            fontSize: 14,
                          ),
                        )),
                    Card(
                        elevation: 4,
                        shadowColor: Colors.black12,
                        child: ListTile(
                          onTap: () {
                            AppUtils.showconfirmDialog(
                                context,
                                "Are you  sure want to logout?",
                                "Yes",
                                "No", () {
                              Prefs.clear();
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => LoginScreen()),
                                  (Route<dynamic> route) => false);
                            }, () {
                              AppUtils.pop(context);
                            });
                          },
                          leading: Icon(
                            CupertinoIcons.arrow_left_right_circle_fill,
                            color: Colors.red,
                          ),
                          title: AppUtils.buildNormalText(
                              text: "Logout", fontSize: 18, color: Colors.red),
                        )),
                  ],
                ),
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  Widget getprofilewidget() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      color: Colors.white30,
      child: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 60,
                child: Padding(
                  padding: const EdgeInsets.all(1), // Border radius
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(60),
                      child: model.message!.tenantimgurl != null ||
                              model.message!.tenantimgurl!.isNotEmpty
                          ? Image.network(AppConstants.liveurl +
                              model.message!.tenantimgurl.toString())
                          : Image.asset(
                              "assets/images/user.png",
                              fit: BoxFit.fill,
                              width: 100,
                              height: 100,
                            )),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            "Rachael Wagner",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text("Junior Product Designer"),
          ListTile(
            leading: Icon(CupertinoIcons.briefcase_fill),
            title: AppUtils.buildNormalText(
                text: "InternalID", fontSize: 12, color: Colors.black54),
            subtitle: AppUtils.buildNormalText(
              text: model.message != null
                  ? model.message!.customerId.toString()
                  : "",
              fontSize: 14,
            ),
          ),
          Divider(
            height: 1,
            thickness: 0.5,
          ),
          ListTile(
            leading: Icon(CupertinoIcons.mail),
            title: AppUtils.buildNormalText(
                text: "Email", fontSize: 12, color: Colors.black54),
            subtitle: AppUtils.buildNormalText(
              text: model.message != null
                  ? model.message!.tenantEmail.toString()
                  : "",
              fontSize: 14,
            ),
          ),
          Divider(
            height: 1,
            thickness: 0.5,
          ),
          ListTile(
            leading: Icon(CupertinoIcons.phone),
            title: AppUtils.buildNormalText(
                text: "Mobile No", fontSize: 12, color: Colors.black54),
            subtitle: AppUtils.buildNormalText(
              text: model.message!.tenantMobileno.toString(),
              fontSize: 14,
            ),
          ),
          Divider(
            height: 1,
            thickness: 0.5,
          ),
          ListTile(
            leading: Icon(CupertinoIcons.airplane),
            title: AppUtils.buildNormalText(
                text: "Passport No", fontSize: 12, color: Colors.black54),
            subtitle: AppUtils.buildNormalText(
              text: model.message != null
                  ? model.message!.tenantPassportno.toString()
                  : "",
              fontSize: 14,
            ),
          ),
          Divider(
            height: 1,
            thickness: 0.5,
          ),
          ListTile(
            leading: Icon(CupertinoIcons.calendar_today),
            title: AppUtils.buildNormalText(
                text: "Passport Exp.Date", fontSize: 12, color: Colors.black54),
            subtitle: AppUtils.buildNormalText(
              text: model.message != null
                  ? model.message!.tenantPassportexpdate.toString()
                  : "",
              fontSize: 14,
            ),
          ),
          Divider(
            height: 1,
            thickness: 0.5,
          ),
          ListTile(
            leading: Icon(CupertinoIcons.list_number_rtl),
            title: AppUtils.buildNormalText(
                text: "Emirates Number", fontSize: 12, color: Colors.black54),
            subtitle: AppUtils.buildNormalText(
              text: model.message != null
                  ? model.message!.tenantEmirtesid.toString()
                  : "",
              fontSize: 14,
            ),
          ),
          Divider(
            height: 1,
            thickness: 0.5,
          ),
          ListTile(
            leading: Icon(CupertinoIcons.calendar_today),
            title: AppUtils.buildNormalText(
                text: "Emirates Exp.Date", fontSize: 12, color: Colors.black54),
            subtitle: AppUtils.buildNormalText(
              text: model.message != null
                  ? model.message!.tenantEmirtesexpdate.toString()
                  : "",
              fontSize: 14,
            ),
          ),
          Divider(
            height: 1,
            thickness: 0.5,
          ),
          SizedBox(
            height: 10,
          ),
          CustomButton(
            onPressed: () {
              Prefs.clear();
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                  (Route<dynamic> route) => false);
            },
            name: "Sign Out",
            circularvalue: 30,
            fontSize: 14,
          )
        ],
      ),
    );
  }

  void getprofiledata() async {
    setState(() {
      loading = true;
    });
    Apiservice.getprofileage().then((response) {
      setState(() {
        loading = false;
      });
      if (response.statusCode == 200) {
        if (jsonDecode(response.body)['status'].toString() == "true") {
          model = ProfileModel.fromJson(jsonDecode(response.body));
        } else {
          model.message = null;
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
    Navigator.of(context).pop();
  }

  PopupMenuItem _buildPopupMenuItem(
      String title, IconData iconData, int position) {
    return PopupMenuItem(
      value: position,
      child: Row(
        children: [
          Icon(
            iconData,
            color: Colors.black,
          ),
          Text(title),
        ],
      ),
    );
  }

  void handleClick(int value) {
    if (value == 1) {
      if (model.message != null) {
        Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChangepasswordScreen(model: profile!)))
            .then((_) => getprofiledata());
      } else {
        AppUtils.showSingleDialogPopup(
            context, "Please Try Later", "Ok", exitpopup);
      }
    }
    if (value == 2) {
      AppUtils.showconfirmDialog(
          context, "Are you  sure want to logout?", "No", "Yes", () {
        Prefs.setLoggedIn("IsLoggedIn", false);
        Prefs.clear();
        AppUtils.pop(context);
      }, () {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => LoginScreen()),
            (Route<dynamic> route) => false);
      });
    }
  }
}
