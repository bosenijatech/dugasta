// import 'dart:convert';

// import 'package:dugasta/data/api_service.dart';
// import 'package:dugasta/domain/pref.dart';
// import 'package:dugasta/presentation/model/profilemodel.dart';
// import 'package:dugasta/presentation/module/login/login.dart';
// import 'package:dugasta/presentation/util/app_utils.dart';
// import 'package:dugasta/presentation/util/custom_indicatoronly.dart';
// import 'package:dugasta/presentation/utils/custom_button.dart';
// import 'package:flutter/material.dart';

// class ChangepasswordScreen extends StatefulWidget {
//   ProfileModel model;
//   ChangepasswordScreen({super.key, required this.model});

//   @override
//   State<ChangepasswordScreen> createState() => _ChangepasswordScreenState();
// }

// class _ChangepasswordScreenState extends State<ChangepasswordScreen> {
//   TextEditingController emailcontroller = TextEditingController();
//   TextEditingController passwordcontroller = TextEditingController();
//   TextEditingController confirmpasswordcontroller = TextEditingController();
//   bool passwordVisible = false;
//   bool confirmpasswordVisible = false;
//   bool loading = false;

//   final formKey = GlobalKey<FormState>();
//   @override
//   void initState() {
//     emailcontroller.text = widget.model.message!.tenantEmail.toString();
//     super.initState();
//   }

//   @override
//   void dispose() {
//     emailcontroller.dispose();
//     passwordcontroller.dispose();
//     confirmpasswordcontroller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "Change Password",
//           style: TextStyle(color: Colors.white),
//         ),
//       ),
//       body: !loading
//           ? SingleChildScrollView(
//               child: Form(
//                 key: formKey,
//                 child: Padding(
//                   padding: const EdgeInsets.only(left: 16, right: 16),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       SizedBox(
//                         height: 250,
//                         width: double.infinity,
//                         child: Image.asset("assets/images/changepwd.png"),
//                       ),
//                       AppUtils.buildNormalText(text: "Email", fontSize: 16),
//                       const SizedBox(height: 10),
//                       TextField(
//                         controller: emailcontroller,
//                         readOnly: true,
//                         decoration: InputDecoration(
//                             hintText: "Email",
//                             border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(30),
//                                 borderSide: BorderSide.none),
//                             fillColor: Colors.grey.shade300,
//                             filled: true,
//                             prefixIcon: const Icon(Icons.email)),
//                       ),
//                       const SizedBox(height: 10),
//                       AppUtils.buildNormalText(text: "Password", fontSize: 16),
//                       const SizedBox(height: 10),
//                       TextFormField(
//                         obscureText: passwordVisible,
//                         maxLength: 10,
//                         controller: passwordcontroller,
//                         validator: (value) {
//                           // add your custom validation here.
//                           if (value!.isEmpty) {
//                             return 'Please enter Password';
//                           }
//                           if (value.length < 6) {
//                             return 'Password Must be 6 charater and above';
//                           }
//                           return null;
//                         },
//                         decoration: InputDecoration(
//                           hintText: "Password",
//                           border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(30),
//                               borderSide: BorderSide.none),
//                           filled: true,
//                           fillColor: Colors.grey.shade300,
//                           prefixIcon: const Icon(Icons.lock),
//                           suffixIcon: IconButton(
//                             icon: Icon(
//                                 // Based on passwordVisible state choose the icon
//                                 passwordVisible
//                                     ? Icons.visibility
//                                     : Icons.visibility_off,
//                                 color: Colors.black),
//                             onPressed: () {
//                               // Update the state i.e. toogle the state of passwordVisible variable
//                               setState(() {
//                                 passwordVisible = !passwordVisible;
//                               });
//                             },
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 10),
//                       AppUtils.buildNormalText(
//                           text: "Confirm Password", fontSize: 16),
//                       const SizedBox(height: 10),
//                       TextFormField(
//                         maxLength: 10,
//                         controller: confirmpasswordcontroller,
//                         validator: (values) {
//                           // add your custom validation here.
//                           if (values!.isEmpty) {
//                             return 'Please Enter Confirm Password';
//                           }
//                           if (values.length < 6) {
//                             return 'Confirm Password Must be 6 charater and above';
//                           }
//                           return null;
//                         },
//                         decoration: InputDecoration(
//                           hintText: "Confirm Password",
//                           border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(30),
//                               borderSide: BorderSide.none),
//                           filled: true,
//                           fillColor: Colors.grey.shade300,
//                           prefixIcon: const Icon(Icons.lock),
//                           suffixIcon: IconButton(
//                             icon: Icon(
//                               // Based on passwordVisible state choose the icon
//                               confirmpasswordVisible
//                                   ? Icons.visibility
//                                   : Icons.visibility_off,
//                               color: Colors.black,
//                             ),
//                             onPressed: () {
//                               // Update the state i.e. toogle the state of passwordVisible variable
//                               setState(() {
//                                 confirmpasswordVisible =
//                                     !confirmpasswordVisible;
//                               });
//                             },
//                           ),
//                         ),
//                         obscureText: confirmpasswordVisible,
//                       ),
//                       const SizedBox(height: 10),
//                     ],
//                   ),
//                 ),
//               ),
//             )
//           : Center(
//               child: CustomIndicator(),
//             ),
//       persistentFooterButtons: [
//         CustomButton(
//             onPressed: () {
//               final isValid = formKey.currentState!.validate();
//               if (!isValid) {
//                 return;
//               }
//               formKey.currentState!.save();
//               if (passwordcontroller.text != confirmpasswordcontroller.text) {
//                 AppUtils.showCustomDialog(context,
//                     "Old and Confirm Password Mismatch", "Ok", onexitpopup);
//               } else {
//                 updatelogindetails();
//               }
//             },
//             name: "Submit",
//             circularvalue: 30)
//       ],
//     );
//   }

//   void updatelogindetails() async {
//     var body = {
//       "tenant_email": widget.model.message!.tenantEmail.toString(),
//       "tenant_password": confirmpasswordcontroller.text,
//       "customerId": Prefs.getCustomerId('CustomerID')
//     };
//     setState(() {
//       loading = true;
//     });
//     Apiservice.passwordupdate(body).then((response) {
//       setState(() {
//         loading = false;
//       });
//       if (response.statusCode == 200) {
//         if (jsonDecode(response.body)['status'].toString() == "true") {
//           AppUtils.showCustomDialog(
//               context, jsonDecode(response.body)['message'], "ok", onrefresh);
//         } else {
//           AppUtils.showCustomDialog(
//               context, jsonDecode(response.body)['message'], "ok", onexitpopup);
//         }
//         //return response;
//       } else {
//         throw Exception(jsonDecode(response.body)['message'].toString());
//       }
//     }).catchError((e) {
//       setState(() {
//         loading = false;
//       });
//       AppUtils.showSingleDialogPopup(context, e.toString(), "Ok", onexitpopup);
//     });
//   }

//   void onexitpopup() {
//     AppUtils.pop(context);
//   }

//   void onrefresh() {
//     AppUtils.pop(context);
//     Prefs.clear();
//     Prefs.remove("remove");
//     Prefs.setLoggedIn("IsLoggedIn", false);
//     Navigator.pushAndRemoveUntil<void>(
//       context,
//       MaterialPageRoute<void>(
//           builder: (BuildContext context) => const LoginScreen()),
//       ModalRoute.withName('/'),
//     );
//   }
// }

import 'dart:convert';
import 'package:dugasta/presentation/util/app_colors.dart';
import 'package:flutter/material.dart';

import 'package:dugasta/data/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/sales_profilemodel.dart';
import '../model/updatepasswordmodel.dart';
import 'login/login.dart'; // your model

class ChangepasswordScreen extends StatefulWidget {
  final ProfileList model;

  const ChangepasswordScreen({Key? key, required this.model}) : super(key: key);

  @override
  State<ChangepasswordScreen> createState() => _ChangepasswordScreenState();
}

class _ChangepasswordScreenState extends State<ChangepasswordScreen> {
  late TextEditingController passwordController;
  bool showPassword = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    // Initialize controller with existing password from ProfileList
    passwordController =
        TextEditingController(text: widget.model.password ?? '');
  }

  @override
  void dispose() {
    passwordController.dispose();
    super.dispose();
  }

  // 🔐 Password Field
  Widget buildPasswordField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25),
      child: 
      TextField(
        controller: passwordController,
        obscureText: !showPassword,
        cursorColor: AppColor.accentColor,
        enableInteractiveSelection: false,

        decoration: InputDecoration(
          labelText: "Password",
          hintText: "••••••",
          
          floatingLabelBehavior: FloatingLabelBehavior.always,
          floatingLabelStyle: TextStyle(color: AppColor.accentColor),

          // Normal border
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey), // normal color
            borderRadius: BorderRadius.circular(8),
          ),
          // Focused border
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: AppColor.accentColor, width: 2), // focus color
            borderRadius: BorderRadius.circular(8),
          ),
          suffixIcon: IconButton(
            icon: Icon(
              showPassword ? Icons.visibility : Icons.visibility_off,
              color: Colors.grey,
            ),
            onPressed: () {
              setState(() {
                showPassword = !showPassword;
              });
            },
          ),
        ),
      ),
    );
  }

  // 🔁 Change Password API
  Future<void> changePassword() async {
    String password = passwordController.text.trim();

    // ✅ Check for empty password
    if (password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Please enter a new password"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // ✅ Check for exact 6 characters
    if (password.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Password must be exactly 6 characters"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final Map<String, dynamic> body = {
        "internalId": widget.model.customerId.toString(),
        "password": password,
      };

      final res = await Apiservice.passwordupdate(body);

      final Map<String, dynamic> jsonResponse = jsonDecode(res.body);
      final ChangePasswordResponse response =
          ChangePasswordResponse.fromJson(jsonResponse);

      if (response.success && response.message.success == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text("Password updated successfully"),
            backgroundColor: Colors.green,
          ),
        );

        await logout(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response.message.message ?? "Password update failed"),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();

    // Clear login data
    await prefs.clear();

    // Navigate to login page and remove all previous screens
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => LoginScreen()),
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Change Password"  ,  style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            buildPasswordField(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50), // full width
                backgroundColor: AppColor.accentColor,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: isLoading ? null : changePassword,
              child: isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text(
                      "Update Password",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
