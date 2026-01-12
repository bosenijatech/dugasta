



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
    if (value == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChangepasswordScreen(model: profile!, ),
        ),
      ).then((_) => fetchProfile());
    } else if (value == 2) {
      AppUtils.showconfirmDialog(
        context,
        "Are you sure you want to logout?",
        "No",
        "Yes",
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

    
      // AppUtils.showconfirmDialog(
      //   context,
      //   "Are you sure you want to logout?",
      //   "Yes",
      //   "No",
        
      //   () {
      //     Prefs.clear();
      //     Navigator.of(context).pushAndRemoveUntil(
      //       MaterialPageRoute(builder: (context) => LoginScreen()),
      //       (Route<dynamic> route) => false,
      //     );
      //   },
      //   () {
      //     AppUtils.pop(context);
      //   },
      // );
    
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
              _buildPopupMenuItem("Change Password", Icons.lock, 1),
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
