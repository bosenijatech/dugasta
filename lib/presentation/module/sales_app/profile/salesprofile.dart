// import 'dart:convert';

// import 'package:dugasta/data/api_service.dart';
// import 'package:dugasta/domain/pref.dart';
// import 'package:dugasta/presentation/model/profilemodel.dart';
// import 'package:dugasta/presentation/module/changepassword.dart';
// import 'package:dugasta/presentation/module/login/login.dart';
// import 'package:dugasta/presentation/module/profilepage/edit_profile.dart';
// import 'package:dugasta/presentation/util/app_colors.dart';
// import 'package:dugasta/presentation/util/app_utils.dart';
// import 'package:dugasta/presentation/util/appcontants.dart';
// import 'package:dugasta/presentation/utils/custom_button.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// import '../../../model/sales_profilemodel.dart';

// class SalesProfileScreen extends StatefulWidget {
//   const SalesProfileScreen({Key? key}) : super(key: key);

//   @override
//   State<SalesProfileScreen> createState() => _SalesProfileScreenState();
// }

// class _SalesProfileScreenState extends State<SalesProfileScreen> {
//   bool Active = false;
//   bool loading = false;
//   SalesprofileModel model = SalesprofileModel();
//   @override
//   void initState() {
   
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         centerTitle: false,
//         title: AppUtils.buildNormalText(
//             text: "Profile Page", fontSize: 20, color: Colors.white),
//         actions: [
//           PopupMenuButton(
//             onSelected: (item) => handleClick(item as int),
//             itemBuilder: (ctx) => [
//               _buildPopupMenuItem("Change Password", Icons.lock, 1),
//               _buildPopupMenuItem("Logout", Icons.exit_to_app, 2)
//             ],
//           )
//         ],
       
//       ),
//       body: !loading
//           ? Center(
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     Image.asset(
//                       "assets/images/user.png",
//                       fit: BoxFit.fill,
//                       width: 100,
//                       height: 100,
//                     ),
//                     SizedBox(height: 10),
//                     Align(
//                       alignment: Alignment.center,
//                       child: Text(
//                         model.message != null
//                             ? model.message!.tenantFirstname.toString()
//                             : "",
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                     Text(
//                       model.message != null
//                           ? model.message!.tenantMobileno.toString()
//                           : "",
//                     ),
//                     Card(
//                       elevation: 4,
//                       shadowColor: Colors.black12,
//                       child: ListTile(
//                         leading: Icon(
//                           CupertinoIcons.briefcase_fill,
//                           color: AppColor.accentColor,
//                         ),
//                         title: AppUtils.buildNormalText(
//                             text: "Customer ID",
//                             fontSize: 12,
//                             color: Colors.black54),
//                         subtitle: AppUtils.buildNormalText(
//                           text: model.message != null
//                               ? model.message!.customerId.toString()
//                               : "",
//                           fontSize: 14,
//                         ),
//                       ),
//                     ),
//                     Card(
//                         elevation: 4,
//                         shadowColor: Colors.black12,
//                         child: ListTile(
//                           leading: Icon(
//                             CupertinoIcons.mail,
//                             color: AppColor.accentColor,
//                           ),
//                           title: AppUtils.buildNormalText(
//                               text: "Email",
//                               fontSize: 12,
//                               color: Colors.black54),
//                           subtitle: AppUtils.buildNormalText(
//                             text: model.message != null
//                                 ? model.message!.tenantEmail.toString()
//                                 : "",
//                             fontSize: 14,
//                           ),
//                         )),
//                     Card(
//                         elevation: 4,
//                         shadowColor: Colors.black12,
//                         child: ListTile(
//                           leading: Icon(
//                             CupertinoIcons.phone,
//                             color: AppColor.accentColor,
//                           ),
//                           title: AppUtils.buildNormalText(
//                               text: "Mobile No",
//                               fontSize: 12,
//                               color: Colors.black54),
//                           subtitle: AppUtils.buildNormalText(
//                             text: model.message != null
//                                 ? model.message!.tenantMobileno.toString()
//                                 : "",
//                             fontSize: 14,
//                           ),
//                         )),
//                     Card(
//                         elevation: 4,
//                         shadowColor: Colors.black12,
//                         child: ListTile(
//                           leading: Icon(
//                             CupertinoIcons.airplane,
//                             color: AppColor.accentColor,
//                           ),
//                           title: AppUtils.buildNormalText(
//                               text: "Passport No",
//                               fontSize: 12,
//                               color: Colors.black54),
//                           subtitle: AppUtils.buildNormalText(
//                             text: model.message != null
//                                 ? model.message!.tenantPassportno.toString()
//                                 : "",
//                             fontSize: 14,
//                           ),
//                         )),
//                     Card(
//                         elevation: 4,
//                         shadowColor: Colors.black12,
//                         child: ListTile(
//                           leading: Icon(
//                             CupertinoIcons.calendar_today,
//                             color: AppColor.accentColor,
//                           ),
//                           title: AppUtils.buildNormalText(
//                               text: "Passport Exp.Date",
//                               fontSize: 12,
//                               color: Colors.black54),
//                           subtitle: AppUtils.buildNormalText(
//                             text: model.message != null
//                                 ? model.message!.tenantPassportexpdate
//                                     .toString()
//                                 : "",
//                             fontSize: 14,
//                           ),
//                         )),
//                     Card(
//                         elevation: 4,
//                         shadowColor: Colors.black12,
//                         child: ListTile(
//                           leading: Icon(
//                             CupertinoIcons.list_number_rtl,
//                             color: AppColor.accentColor,
//                           ),
//                           title: AppUtils.buildNormalText(
//                               text: "Emirates Number",
//                               fontSize: 12,
//                               color: Colors.black54),
//                           subtitle: AppUtils.buildNormalText(
//                             text: model.message != null
//                                 ? model.message!.tenantEmirtesid.toString()
//                                 : "",
//                             fontSize: 14,
//                           ),
//                         )),
//                     Card(
//                         elevation: 4,
//                         shadowColor: Colors.black12,
//                         child: ListTile(
//                           leading: Icon(
//                             CupertinoIcons.calendar_today,
//                             color: AppColor.accentColor,
//                           ),
//                           title: AppUtils.buildNormalText(
//                               text: "Emirates Exp.Date",
//                               fontSize: 12,
//                               color: Colors.black54),
//                           subtitle: AppUtils.buildNormalText(
//                             text: model.message != null
//                                 ? model.message!.tenantEmirtesexpdate.toString()
//                                 : "",
//                             fontSize: 14,
//                           ),
//                         )),
//                     Card(
//                         elevation: 4,
//                         shadowColor: Colors.black12,
//                         child: ListTile(
//                           onTap: () {
//                             AppUtils.showconfirmDialog(
//                                 context,
//                                 "Are you  sure want to logout?",
//                                 "Yes",
//                                 "No", () {
//                               Prefs.clear();
//                               Navigator.of(context).pushAndRemoveUntil(
//                                   MaterialPageRoute(
//                                       builder: (context) => LoginScreen()),
//                                   (Route<dynamic> route) => false);
//                             }, () {
//                               AppUtils.pop(context);
//                             });
//                           },
//                           leading: Icon(
//                             CupertinoIcons.arrow_left_right_circle_fill,
//                             color: Colors.red,
//                           ),
//                           title: AppUtils.buildNormalText(
//                               text: "Logout", fontSize: 18, color: Colors.red),
//                         )),
//                   ],
//                 ),
//               ),
//             )
//           : Center(
//               child: CircularProgressIndicator(),
//             ),
//     );
//   }

//   Widget getprofilewidget() {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 8.0),
//       color: Colors.white30,
//       child: ListView(
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               CircleAvatar(
//                 radius: 60,
//                 child: Padding(
//                   padding: const EdgeInsets.all(1), // Border radius
//                   child: ClipRRect(
//                       borderRadius: BorderRadius.circular(60),
//                       child: model.message!.tenantimgurl != null ||
//                               model.message!.tenantimgurl!.isNotEmpty
//                           ? Image.network(AppConstants.liveurl +
//                               model.message!.tenantimgurl.toString())
//                           : Image.asset(
//                               "assets/images/user.png",
//                               fit: BoxFit.fill,
//                               width: 100,
//                               height: 100,
//                             )),
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 10),
//           Text(
//             "Rachael Wagner",
//             style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           Text("Junior Product Designer"),
//           ListTile(
//             leading: Icon(CupertinoIcons.briefcase_fill),
//             title: AppUtils.buildNormalText(
//                 text: "InternalID", fontSize: 12, color: Colors.black54),
//             subtitle: AppUtils.buildNormalText(
//               text: model.message != null
//                   ? model.message!.customerId.toString()
//                   : "",
//               fontSize: 14,
//             ),
//           ),
//           Divider(
//             height: 1,
//             thickness: 0.5,
//           ),
//           ListTile(
//             leading: Icon(CupertinoIcons.mail),
//             title: AppUtils.buildNormalText(
//                 text: "Email", fontSize: 12, color: Colors.black54),
//             subtitle: AppUtils.buildNormalText(
//               text: model.message != null
//                   ? model.message!.tenantEmail.toString()
//                   : "",
//               fontSize: 14,
//             ),
//           ),
//           Divider(
//             height: 1,
//             thickness: 0.5,
//           ),
//           ListTile(
//             leading: Icon(CupertinoIcons.phone),
//             title: AppUtils.buildNormalText(
//                 text: "Mobile No", fontSize: 12, color: Colors.black54),
//             subtitle: AppUtils.buildNormalText(
//               text: model.message!.tenantMobileno.toString(),
//               fontSize: 14,
//             ),
//           ),
//           Divider(
//             height: 1,
//             thickness: 0.5,
//           ),
//           ListTile(
//             leading: Icon(CupertinoIcons.airplane),
//             title: AppUtils.buildNormalText(
//                 text: "Passport No", fontSize: 12, color: Colors.black54),
//             subtitle: AppUtils.buildNormalText(
//               text: model.message != null
//                   ? model.message!.tenantPassportno.toString()
//                   : "",
//               fontSize: 14,
//             ),
//           ),
//           Divider(
//             height: 1,
//             thickness: 0.5,
//           ),
//           ListTile(
//             leading: Icon(CupertinoIcons.calendar_today),
//             title: AppUtils.buildNormalText(
//                 text: "Passport Exp.Date", fontSize: 12, color: Colors.black54),
//             subtitle: AppUtils.buildNormalText(
//               text: model.message != null
//                   ? model.message!.tenantPassportexpdate.toString()
//                   : "",
//               fontSize: 14,
//             ),
//           ),
//           Divider(
//             height: 1,
//             thickness: 0.5,
//           ),
//           ListTile(
//             leading: Icon(CupertinoIcons.list_number_rtl),
//             title: AppUtils.buildNormalText(
//                 text: "Emirates Number", fontSize: 12, color: Colors.black54),
//             subtitle: AppUtils.buildNormalText(
//               text: model.message != null
//                   ? model.message!.tenantEmirtesid.toString()
//                   : "",
//               fontSize: 14,
//             ),
//           ),
//           Divider(
//             height: 1,
//             thickness: 0.5,
//           ),
//           ListTile(
//             leading: Icon(CupertinoIcons.calendar_today),
//             title: AppUtils.buildNormalText(
//                 text: "Emirates Exp.Date", fontSize: 12, color: Colors.black54),
//             subtitle: AppUtils.buildNormalText(
//               text: model.message != null
//                   ? model.message!.tenantEmirtesexpdate.toString()
//                   : "",
//               fontSize: 14,
//             ),
//           ),
//           Divider(
//             height: 1,
//             thickness: 0.5,
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           CustomButton(
//             onPressed: () {
//               Prefs.clear();
//               Navigator.of(context).pushAndRemoveUntil(
//                   MaterialPageRoute(builder: (context) => LoginScreen()),
//                   (Route<dynamic> route) => false);
//             },
//             name: "Sign Out",
//             circularvalue: 30,
//             fontSize: 14,
//           )
//         ],
//       ),
//     );
//   }


//   void exitpopup() {
//     Navigator.of(context).pop();
//   }

//   PopupMenuItem _buildPopupMenuItem(
//       String title, IconData iconData, int position) {
//     return PopupMenuItem(
//       value: position,
//       child: Row(
//         children: [
//           Icon(
//             iconData,
//             color: Colors.black,
//           ),
//           Text(title),
//         ],
//       ),
//     );
//   }

//   void handleClick(int value) {
//     if (value == 1) {
//       if (model.message != null) {
//         Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) => ChangepasswordScreen(model: model)))
//             .then((_) => getsalesProfile());
//       } else {
//         AppUtils.showSingleDialogPopup(
//             context, "Please Try Later", "Ok", exitpopup);
//       }
//     }
//     if (value == 2) {
//       AppUtils.showconfirmDialog(
//           context, "Are you  sure want to logout?", "No", "Yes", () {
//         Prefs.setLoggedIn("IsLoggedIn", false);
//         Prefs.clear();
//         AppUtils.pop(context);
//       }, () {
//         Navigator.of(context).pushAndRemoveUntil(
//             MaterialPageRoute(builder: (context) => LoginScreen()),
//             (Route<dynamic> route) => false);
//       });
//     }
//   }
// }


import 'package:dugasta/data/api_service.dart' show Apiservice;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dugasta/domain/pref.dart';
import 'package:dugasta/presentation/module/changepassword.dart';
import 'package:dugasta/presentation/module/login/login.dart';
import 'package:dugasta/presentation/util/app_colors.dart';
import 'package:dugasta/presentation/util/app_utils.dart';
import 'package:dugasta/presentation/utils/custom_button.dart';


import '../../../model/sales_profilemodel.dart';

class SalesProfileScreen extends StatefulWidget {
  const SalesProfileScreen({Key? key}) : super(key: key);

  @override
  State<SalesProfileScreen> createState() => _SalesProfileScreenState();
}

class _SalesProfileScreenState extends State<SalesProfileScreen> {
  bool loading = true;
  ProfileList? profile;

  @override
  void initState() {
    super.initState();
    fetchProfile();
  }

  Future<void> fetchProfile() async {
    setState(() => loading = true);
    final response = await Apiservice.getsalesProfile();

    if (response != null && response.data.isNotEmpty) {
      setState(() {
        profile = response.data.first;
        loading = false;
      });
    } else {
      setState(() => loading = false);
    }
  }

  void handleClick(int value) {
    // if (value == 1) {
    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => ChangepasswordScreen(model: ),
    //     ),
    //   ).then((_) => fetchProfile());
    // } else if (value == 2) {
    //   AppUtils.showconfirmDialog(
    //     context,
    //     "Are you sure you want to logout?",
    //     "No",
    //     "Yes",
    //     () {
    //       Prefs.clear();
    //       Navigator.of(context).pushAndRemoveUntil(
    //         MaterialPageRoute(builder: (context) => LoginScreen()),
    //         (Route<dynamic> route) => false,
    //       );
    //     },
    //     () {
    //       AppUtils.pop(context);
    //     },
    //   );
    // }

    
      AppUtils.showconfirmDialog(
        context,
        "Are you sure you want to logout?",
        "Yes",
        "No",
        
        () {
          Prefs.clear();
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => LoginScreen()),
            (Route<dynamic> route) => false,
          );
        },
        () {
          AppUtils.pop(context);
        },
      );
    
  }

  PopupMenuItem _buildPopupMenuItem(String title, IconData icon, int val) {
    return PopupMenuItem(
      value: val,
      child: Row(
        children: [
          Icon(icon, color: Colors.black),
          const SizedBox(width: 8),
          Text(title),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        title: const Text(
          'Profile',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        
        elevation: 0,
         actions: [
          PopupMenuButton(
            onSelected: (item) => handleClick(item as int),
            itemBuilder: (ctx) => [
              // _buildPopupMenuItem("Change Password", Icons.lock, 1),
              _buildPopupMenuItem("Logout", Icons.exit_to_app, 2),
            ],
          ),
        ],
      ),
      
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : profile == null
              ? const Center(child: Text("No profile data found"))
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 80,
                        backgroundImage:
                            const AssetImage("assets/images/user.png"),
                      ),
                      const SizedBox(height:20),
                  
                     
                   
                      _infoTile("Customer ID", profile!.customerId),
                      _infoTile("Customer Name", profile!.companyName),
                         _infoTile("Customer Type", profile!.customerType),
                         _infoTile("POA Type", profile!.customerType),
                           _infoTile("Mobile No", profile!.phone),
                           _infoTile("Passport No", profile!.phone),
                           _infoTile("Emirates Exp Date", profile!.phone),
                           _infoTile("Passport Exp Date", profile!.phone),
                   
                    
                      // _infoTile("Company", profile!.companyName),
                    //  _infoTile("Email", profile!.email),
                      // _infoTile("Subsidiary", profile!.subsidiary),
                      // _infoTile("Active", profile!.active),
                     
                  
                    ],
                  ),
                ),
    );
  }

  Widget _infoTile(String title, String? value) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: const Icon(Icons.info_outline, color: AppColor.accentColor),
        title: Text(title,
            style: const TextStyle(fontSize: 12, color: Colors.black54)),
        subtitle: Text(value ?? "-", style: const TextStyle(fontSize: 14)),
      ),
    );
  }
}
