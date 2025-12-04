import 'package:dugasta/presentation/module/login/login.dart';
import 'package:dugasta/presentation/module/login/otpverify.dart';
import 'package:dugasta/presentation/util/app_colors.dart';
import 'package:dugasta/presentation/utils/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final password_textfield = TextEditingController();

  final confirm_password_textfield = TextEditingController();

  late List<String> countryCodes;
  final String _countryCode = "+1";

  final bool _passwordVisible = false;

  final bool _confirmpasswordVisible = false;

  @override
  void initState() {
    countryCodes = [];
    for (int i = 0; i < 100; i++) {
      countryCodes.add("+$i");
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('Sign up',
            style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w600)),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: SvgPicture.asset('assets/icons/Arrow-left.svg'),
        ),
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      bottomNavigationBar: Container(
        width: MediaQuery.of(context).size.width,
        height: 48,
        alignment: Alignment.center,
        child: TextButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => LoginScreen()));
          },
          style: TextButton.styleFrom(
            foregroundColor: AppColor.secondaryColor.withOpacity(0.1),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Already have an account?',
                style: TextStyle(
                  color: AppColor.secondaryColor.withOpacity(0.7),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                ' Sign in',
                style: TextStyle(
                  color: AppColor.primary,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(horizontal: 24),
        physics: BouncingScrollPhysics(),
        children: [
          // Section 1 - Header
          Container(
            margin: EdgeInsets.only(top: 20, bottom: 12),
            child: Text(
              'Welcome to MarketKy  👋',
              style: TextStyle(
                color: AppColor.secondaryColor,
                fontWeight: FontWeight.w700,
                fontFamily: 'poppins',
                fontSize: 20,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 32),
            child: Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing \nelit, sed do eiusmod ',
              style: TextStyle(
                  color: AppColor.secondaryColor.withOpacity(0.7),
                  fontSize: 12,
                  height: 150 / 100),
            ),
          ),
          // Section 2  - Form
          // Full Name
          TextField(
            autofocus: false,
            decoration: InputDecoration(
              hintText: 'Full Name',
              prefixIcon: Container(
                padding: EdgeInsets.all(12),
                child: SvgPicture.asset('assets/icons/Profile.svg',
                    color: AppColor.primary),
              ),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10, horizontal: 14),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColor.primary, width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              fillColor: AppColor.primary,
              filled: true,
            ),
          ),
          SizedBox(height: 16),
          // Username
          TextField(
            autofocus: false,
            decoration: InputDecoration(
              hintText: 'Username',
              prefixIcon: Container(
                padding: EdgeInsets.all(12),
                child: Text('@',
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: AppColor.primary)),
              ),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10, horizontal: 14),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColor.primary, width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              fillColor: AppColor.kSecondaryColor,
              filled: true,
            ),
          ),
          SizedBox(height: 16),
          // Email
          TextField(
            autofocus: false,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: 'youremail@email.com',
              prefixIcon: Container(
                padding: EdgeInsets.all(12),
                child: SvgPicture.asset('assets/icons/Message.svg',
                    color: AppColor.primary),
              ),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10, horizontal: 14),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColor.primary, width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              fillColor: AppColor.kSecondaryColor,
              filled: true,
            ),
          ),
          SizedBox(height: 16),
          // Password
          TextField(
            autofocus: false,
            obscureText: true,
            decoration: InputDecoration(
              hintText: 'Password',
              prefixIcon: Container(
                padding: EdgeInsets.all(12),
                child: SvgPicture.asset('assets/icons/Lock.svg',
                    color: AppColor.primary),
              ),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10, horizontal: 14),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColor.primary, width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              fillColor: AppColor.primary,
              filled: true,
              //
              suffixIcon: IconButton(
                onPressed: () {},
                icon: SvgPicture.asset('assets/icons/Hide.svg',
                    color: AppColor.primary),
              ),
            ),
          ),
          SizedBox(height: 16),
          // Repeat Password
          TextField(
            autofocus: false,
            obscureText: true,
            decoration: InputDecoration(
              hintText: 'Repeat Password',
              prefixIcon: Container(
                padding: EdgeInsets.all(12),
                child: SvgPicture.asset('assets/icons/Lock.svg',
                    color: AppColor.primary),
              ),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10, horizontal: 14),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColor.primary, width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              fillColor: AppColor.primaryColor,
              filled: true,
              //
              suffixIcon: IconButton(
                onPressed: () {},
                icon: SvgPicture.asset('assets/icons/Hide.svg',
                    color: AppColor.primary),
              ),
            ),
          ),
          SizedBox(height: 24),
          // Sign Up Button
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => OtpVerifyScreen()));
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 36, vertical: 18),
              backgroundColor: AppColor.primary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              elevation: 0,
              shadowColor: Colors.transparent,
            ),
            child: Text(
              'Sign up',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  fontFamily: 'poppins'),
            ),
          ),
          // Container(
          //   alignment: Alignment.center,
          //   margin: EdgeInsets.symmetric(vertical: 16),
          //   child: Text(
          //     'or continue with',
          //     style: TextStyle(fontSize: 12, color: Colors.grey[600]),
          //   ),
          // ),
          // SIgn in With Google
          // ElevatedButton(
          //   onPressed: () {},
          //   style: ElevatedButton.styleFrom(
          //     foregroundColor: AppColor.primary,
          //     padding: EdgeInsets.symmetric(horizontal: 36, vertical: 12),
          //     backgroundColor: AppColor.primary,
          //     shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(16)),
          //     elevation: 0,
          //     shadowColor: Colors.transparent,
          //   ),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       SvgPicture.asset(
          //         'assets/icons/Google.svg',
          //       ),
          //       Container(
          //         margin: EdgeInsets.only(left: 16),
          //         child: Text(
          //           'Continue with Google',
          //           style: TextStyle(
          //             color: AppColor.secondary,
          //             fontWeight: FontWeight.w600,
          //           ),
          //         ),
          //       )
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
