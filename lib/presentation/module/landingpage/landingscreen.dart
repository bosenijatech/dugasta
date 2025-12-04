import 'dart:convert';

import 'package:dugasta/data/api_service.dart';
import 'package:dugasta/domain/pref.dart';
import 'package:dugasta/presentation/module/chatbot/chatbot.dart';
import 'package:dugasta/presentation/module/chatpage.dart';
import 'package:dugasta/presentation/module/homepage/homepage.dart';
import 'package:dugasta/presentation/module/landingpage/contact_us.dart';
import 'package:dugasta/presentation/module/profilepage/profilepage.dart';
import 'package:dugasta/presentation/module/sales_app/profile/salesprofile.dart';
import 'package:dugasta/presentation/module/servicedashboard/servicedashboard.dart';
import 'package:dugasta/presentation/util/app_colors.dart';
import 'package:dugasta/presentation/util/app_utils.dart';
import 'package:dugasta/presentation/util/appcontants.dart';
import 'package:dugasta/presentation/util/custom_bottom_bar.dart';
import 'package:dugasta/presentation/util/new_version.dart';
import 'package:dugasta/presentation/utils/notification_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../util/app_style.dart';
import '../sales_app/customerfeedbackform/customerfeedbackform.dart';

class LandingScreenPage extends StatefulWidget {
  const LandingScreenPage({super.key});

  @override
  State<LandingScreenPage> createState() => _LandingScreenPageState();
}

class _LandingScreenPageState extends State<LandingScreenPage> {
  var _currentIndex = 0;
  bool loading = false;
  String version = "";
  String buildNumber = "";
  final List<Widget> pages = [
    HomePage(),
   
    ContactusPage(),
    Customerfeedbackform(),
    SalesProfileScreen(),
    //  ProfileScreen(),
    //  ServiceDashboard(),
    
    
   
    
    
  ];
  @override
  void initState() {
    setState(() {
      _currentIndex = 0;
    });

    //getnotification();
    getpackageversion();
    checkForUpdates();
    super.initState();
  }

  void getpackageversion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      version = packageInfo.version;
      buildNumber = packageInfo.buildNumber;
      print("version$version");
      print("buildNumber$buildNumber");
    });
  }

  Future<void> checkForUpdates() async {
    final newVersion = NewVersionPlus(
      androidId: AppConstants
          .androidAppPackageName, // Replace with your Android app package name
      iOSId: AppConstants.iOSAppID,
      androidHtmlReleaseNotes: true,
      // Replace with your iOS app ID
    );

    final status = await newVersion.getVersionStatus();
    print(status);
    if (status?.canUpdate == true) {
      showUpdateDialog(status!, context);
    }
  }

  void showUpdateDialog(VersionStatus status, BuildContext context1) {
    showDialog(
      barrierDismissible: false,
      context: context1,
      builder: (context1) => AlertDialog(
        title: Text('Update Available'),
        content: Text(
          'A new version of the app is available!\n\n'
          'Current Version: ${status.localVersion}\n'
          'Latest Version: ${status.storeVersion}',
        ),
        actions: [
          TextButton(
            onPressed: () {
              print(Uri.parse(status.appStoreLink));
              status.appStoreLink != "null"
                  ? launchUrl(Uri.parse(status.appStoreLink))
                  : print('App Store link not available');
            },
            child: Text('Update Now'),
          ),
        ],
      ),
    );
  }

  void getnotification() async {
    await NotificationService.instance.initialize();
    final messaging = FirebaseMessaging.instance;
    final token = await messaging.getToken();
    print('FCM Token1: $token');
    if (token == null || token == "") {
    } else {
      Prefs.setFirebaseToken("FirebaseToken", token.toString());
    }
    updatetokens();
  }

  void onResumed() {
    checkForUpdates();
  }

    // SVG icon with active/inactive color
 Widget _buildSvgIcon(String activeAsset, String inactiveAsset, bool isActive) {
    return SvgPicture.asset(
      isActive ? activeAsset : inactiveAsset,
      color: isActive? AppColor.accentColor:AppColor.textGray ,
      height: 24,
      width: 24,
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool confirm = await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Confirm Exit'),
              content: Text('Are you sure you want to exit?'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text('Yes'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text('No'),
                ),
              ],
            );
          },
        );

        // Return true if the user confirms, otherwise return false
        return confirm ?? false;
      },
      child: Scaffold(
        backgroundColor: AppColor.bgColor,
        body: pages[_currentIndex],
          bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        selectedItemColor: AppColor.accentColor,
        unselectedItemColor: AppColor.textGray,
         backgroundColor:  AppColor.appBarColor,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
             BottomNavigationBarItem(
            icon: _buildSvgIcon(AppAssets.home_full, AppAssets.home,  _currentIndex == 0),
            label: "Home",
          ),
          //    BottomNavigationBarItem(
          //   icon: _buildSvgIcon(AppAssets.feedback_full,AppAssets.feedback, _currentIndex == 1),
          //   label: "Feedback",
          // ),
          BottomNavigationBarItem(
            icon:  _buildSvgIcon(AppAssets.call_full,AppAssets.call, _currentIndex == 1),
            label: "Contact Us",
          ),
          BottomNavigationBarItem(
            icon:  _buildSvgIcon(AppAssets.feedback_full,AppAssets.feedback, _currentIndex == 2),
            label: "Feedback",
          ),
          BottomNavigationBarItem(
            icon: _buildSvgIcon(AppAssets.profile_full,AppAssets.profile, _currentIndex == 3),
            label: "Profile",
          ),
       
       
        ],
      ),
        // bottomNavigationBar: SingleChildScrollView(
        //   scrollDirection: Axis.horizontal,
        //   child: 
        //   SalomonBottomBar(
        //     currentIndex: _currentIndex,
        //     // onTap: (i) => setState(() => _currentIndex = i),
        //     onTap: onTabTapped,
        //     items: [
        //       SalomonBottomBarItem(
        //           icon: const Icon(CupertinoIcons.phone),
        //           title: const Text("Contact Us"),
        //           selectedColor: Colors.purple,
        //           unselectedColor: Colors.grey),

        //       /// Likes
        //       SalomonBottomBarItem(
        //           icon: const Icon(CupertinoIcons.settings),
        //           title: const Text("Services"),
        //           selectedColor: Colors.pink,
        //           unselectedColor: Colors.grey),

        //       /// Search
        //       SalomonBottomBarItem(
        //         icon: const Icon(
        //           CupertinoIcons.home,
        //         ),
        //         title: const Text("Home"),
        //         unselectedColor: Colors.grey,
        //         selectedColor: Colors.orange,
        //       ),

        //       /// Profile
        //       SalomonBottomBarItem(
        //           icon: const Icon(CupertinoIcons.chat_bubble_2),
        //           title: const Text("Feedback"),
        //           selectedColor: Colors.teal,
        //           unselectedColor: Colors.grey),
        //       SalomonBottomBarItem(
        //           icon: const Icon(CupertinoIcons.person_circle_fill),
        //           title: const Text("Profile"),
        //           selectedColor: Colors.blue,
        //           unselectedColor: Colors.grey),
        //     ],
        //   ),
        // ),
        //persistentFooterButtons: [alertwidget()],
        // floatingActionButton: FloatingActionButton(
        //    backgroundColor: AppColor.primary,
        //   onPressed: () {
        //     Navigator.push(
        //       context,
        //       MaterialPageRoute(builder: (_) => ChatbotScreen()),
        //     );
        //   },
        //   mini: true,
        //   child: Icon(
        //     Icons.chat_bubble,color: AppColor.secondaryColor
        //   ),
        // ),
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void updatetokens() async {
    setState(() {
      loading = true;
    });
    Apiservice.tokenupdate().then((response) {
      setState(() {
        loading = false;
      });
      if (response.statusCode == 200) {
        // if (jsonDecode(response.body)['status'].toString() == "true") {
        // } else {}
        print(jsonDecode(response.body)['status'].toString());
      } else {
        throw Exception(jsonDecode(response.body)['message'].toString());
      }
    }).catchError((e) {
      setState(() {
        loading = false;
      });
      AppUtils.showSingleDialogPopup(
        context,
        e.toString(),
        "Ok",
        onexitpopup,
      );
    });
  }

  void onexitpopup() {
    Navigator.of(context).pop();
  }

  Widget alertwidget() {
    return Theme(
      data: ThemeData().copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        initiallyExpanded: false,
        title: AppUtils.buildNormalText(
          text: "This is the Prelaunch app!.",
          fontSize: 12,
        ),
        subtitle: Text('App Version Code:$version'),
        children: [
          AppUtils.buildNormalText(
              text:
                  "If you notice any discrepancies or mismatches in the amount or digit displayed, kindly reconfirm with SS Lootah Real Estate Management.",
              fontSize: 12,
              fontStyle: FontStyle.italic),
        ],
      ),
    );
  }
}
