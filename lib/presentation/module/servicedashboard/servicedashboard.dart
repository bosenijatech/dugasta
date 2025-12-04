import 'package:dugasta/appointmentandstatement/appointment.dart';
import 'package:dugasta/appointmentandstatement/statement.dart';
import 'package:dugasta/domain/pref.dart';
import 'package:dugasta/presentation/faq/faqscreen.dart';
import 'package:dugasta/presentation/module/apartmentview/apartmentview.dart';
import 'package:dugasta/presentation/module/cheque/chequepayment.dart';
import 'package:dugasta/presentation/module/contracts/contracts.dart';
import 'package:dugasta/presentation/module/servicerequest/viewservicerequest.dart';
import 'package:dugasta/presentation/util/app_colors.dart';
import 'package:dugasta/presentation/util/appcontants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ServiceDashboard extends StatefulWidget {
  const ServiceDashboard({super.key});

  @override
  State<ServiceDashboard> createState() => _ServiceDashboardState();
}

class _ServiceDashboardState extends State<ServiceDashboard> {
  @override
  void initState() {
    print(Prefs.getRole('Role'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Service Dashboard',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: Column(
          children: [
            (Prefs.getRole("Role").toString() == "Customer" ||
                    Prefs.getRole("Role").toString() == "Tenant")
                ? griditem(context)
                : gettenantitem(context),
          ],
        ),
      ),
    );
  }

  Widget gettenantitem(context) {
    return Padding(
        padding: const EdgeInsets.only(top: 18.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, childAspectRatio: 1.8),
          itemCount: AppConstants.tenantnames.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                if (index == 0) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ApartmentView()),
                  );
                } else if (index == 1) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const FaqScreen()),
                  );
                }
                //  else if (index == 2) {
                //   Navigator.push(
                //     context,
                //     MaterialPageRoute(builder: (context) => const NewsPage()),
                //   );
                // }
              },
              child: Column(
                children: [
                  Container(
                      padding: EdgeInsets.all(16),
                      height: 56,
                      width: 56,
                      decoration: BoxDecoration(
                        color: AppColor.primary,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: SvgPicture.asset(
                          'assets/images/${AppConstants.tenanticonname[index]}',
                          color: Colors.white)),
                  const SizedBox(height: 4),
                  Text(AppConstants.tenantnames[index].toString(),
                      textAlign: TextAlign.center)
                ],
              ),
            );
          },
        ));
  }
}

Widget griditem(context) {
  return Padding(
      padding: const EdgeInsets.only(top: 18.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 1.8),
        itemCount: AppConstants.names.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              if (index == 0) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const Contractspage()),
                );
              } else if (index == 1) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ChequePaymentPage()),
                );
              } else if (index == 2) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ViewServiceRequestPage()),
                );
              } else if (index == 3) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ApartmentView()),
                );
              } else if (index == 4) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FaqScreen()),
                );
              } else if (index == 5) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AppointmentScreen()),
                );
              } else if (index == 6) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const StatementScreen()),
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
                      color: AppColor.primary,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: SvgPicture.asset(
                      'assets/images/${AppConstants.iconname[index]}',
                      color: Colors.white,
                    )),
                const SizedBox(height: 4),
                Text(AppConstants.names[index].toString(),
                    textAlign: TextAlign.center)
              ],
            ),
          );
        },
      ));
}
