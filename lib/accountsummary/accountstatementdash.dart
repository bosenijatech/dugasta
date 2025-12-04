import 'package:dugasta/accountsummary/accountchequedetails.dart';
import 'package:dugasta/accountsummary/accountstandinginstruction.dart';
import 'package:dugasta/accountsummary/accountsummary.dart';
import 'package:dugasta/accountsummary/securitydeposit.dart';
import 'package:dugasta/presentation/util/app_colors.dart';
import 'package:dugasta/presentation/util/app_utils.dart';
import 'package:dugasta/presentation/util/appcontants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AccountstmtDashboard extends StatefulWidget {
  const AccountstmtDashboard({super.key});

  @override
  State<AccountstmtDashboard> createState() => _AccountstmtDashboardState();
}

class _AccountstmtDashboardState extends State<AccountstmtDashboard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.arrowbgColor,
      appBar: AppBar(
        title: AppUtils.buildNormalText(
            text: "Account Statement", fontSize: 18, color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            griditem(context),
          ],
        ),
      ),
    );
  }

  Widget griditem(context) {
    return Padding(
      padding: const EdgeInsets.only(top: 18.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: AppConstants.accountdashiconname.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.7,
        ),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              if (index == 0) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const Accountsummary()),
                );
              }
              if (index == 1) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AccountChequeDetailsPage()),
                );
              }

              if (index == 2) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AccountStandingPage()),
                );
              }
              if (index == 3) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SecurityDepositPage()),
                );
              }
            },
            child: Column(
              children: [
                Container(
                    padding: EdgeInsets.all(16),
                    height: 56,
                    width: 56,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 208, 186, 131),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: SvgPicture.asset(
                      'assets/images/ic_statement.svg',
                      color: Colors.white,
                    )),
                const SizedBox(height: 4),
                Text(AppConstants.names[index].toString(),
                    textAlign: TextAlign.center)
              ],
            ),
          );
        },
      ),
    );
  }
}
