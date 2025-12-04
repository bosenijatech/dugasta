import 'package:dugasta/appointmentandstatement/appointment.dart';
import 'package:dugasta/appointmentandstatement/statement.dart';
import 'package:dugasta/domain/pref.dart';
import 'package:dugasta/presentation/faq/faqscreen.dart';
import 'package:dugasta/presentation/module/apartmentview/apartmentview.dart';
import 'package:dugasta/presentation/module/chatbot/chatbot.dart';
import 'package:dugasta/presentation/module/cheque/chequepayment.dart';
import 'package:dugasta/presentation/module/contracts/contracts.dart';
import 'package:dugasta/presentation/module/news/news.dart';
import 'package:dugasta/presentation/module/notificationpage/notificationpage.dart';
import 'package:dugasta/presentation/module/profilepage/profilepage.dart';
import 'package:dugasta/presentation/module/sales_app/paymentdetails/salespaymentdetails.dart';
import 'package:dugasta/presentation/module/sales_app/salesreservation/salesreservation.dart';
import 'package:dugasta/presentation/module/servicerequest/viewservicerequest.dart';
import 'package:dugasta/presentation/util/app_colors.dart';
import 'package:dugasta/presentation/util/appcontants.dart';
import 'package:carousel_slider_plus/carousel_slider_plus.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../util/app_style.dart';
import '../login/login.dart';
import '../sales_app/estimate/salesestimate.dart';
import '../sales_app/faq/salesfaq.dart';
import '../sales_app/profile/salesprofile.dart';
import '../sales_app/salescontract/salescontract.dart';
import '../sales_app/servicerequest/salessevicerequest.dart';
import '../sales_app/unitstatement/salesunitstatement.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final List<String> sliderimgList = [
    'assets/images/community2.png',
    'assets/images/community3.png',
    'assets/images/community4.png',
  ];
  final List<String> images = [
    AppAssets.carousel1,
    AppAssets.carousel2,
    AppAssets.carousel3,
  ];

  final List<String> gridIcons = [
    AppAssets.contracts,
    AppAssets.payment,
    AppAssets.service,
    AppAssets.apartment,
    AppAssets.FAQ,
    AppAssets.statement,
    AppAssets.appointment,
  ];

  final List<String> gridNames = [
    "Your Contracts",
    "Payment Details",
    "Service Request",
    "Apartment List",
    "FAQ",
    "Statement",
    "Appointment",
  ];
  final List<String> salesIcons = [
   
    AppAssets.estimate,
  
     AppAssets.reservation,
       AppAssets.contracts,
       AppAssets.service,
     AppAssets.payment,
        AppAssets.FAQ,
        AppAssets.statement,
         
   
  ];

  final List<String> salesNames = ["Estimate", "Reservation","Contracts","Services Request", "Payment", "Faq", "Unit Statement" ];
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
      backgroundColor: AppColor.lightCream,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 60,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              (Prefs.getRole("customerType") == "Sales")
                  ? Prefs.getcompanyName("companyName").toString()
                  : Prefs.getName("Name").toString(),
              style: const TextStyle(
                color: AppColor.secondaryColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            // Text(Prefs.getCustomerName("CusName").toString(),
            //     style: TextStyle(
            //       color: AppColor.secondaryColor,
            //       fontSize: 14,
            //       fontWeight: FontWeight.bold,
            //     )),
            //     SizedBox(height: 10,),
            // Text(Prefs.getTenantID('TenantId').toString(),
            //     style: TextStyle(
            //         color: AppColor.iconColor,
            //         fontSize: 12,
            //         fontWeight: FontWeight.bold)),
          ],
        ),
        actions: [
          // GestureDetector(
          //   onTap: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(builder: (context) => Notificationpage()),
          //     );
          //   },
          //   child: Container(
          //       width: 28,
          //       height: 28,
          //       decoration: const BoxDecoration(
          //         shape: BoxShape.circle,
          //         color: Colors.white,
          //       ),
          //       child: Icon(Icons.notifications,
          //           size: 20, color: AppColor.supportColor)),
          // ),
          // SizedBox(width: 16),
          // GestureDetector(
          //   onTap: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(builder: (context) => SalesProfileScreen()),
          //     );
          //   },
          //   child: Container(
          //       width: 28,
          //       height: 28,
          //       decoration: const BoxDecoration(
          //         shape: BoxShape.circle,
          //         color: Colors.white,
          //       ),
          //       child:
          //           Icon(Icons.person, size: 20, color: AppColor.supportColor)),
          // ),
GestureDetector(
  onTap: () {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Logout"),
        content: const Text("Are you sure you want to logout?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context); 
              await logout(context);
            },
            child: const Text("Logout"),
          ),
        ],
      ),
    );
  },
  child: const Icon(Icons.logout_rounded),
)
,
          const SizedBox(
            width: 16,
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          children: [
            // (Prefs.getRole("customerType").toString() == "Sales"

            //         )
            //     ? griditem(context)
            //     : gettenantitem(context),

            (Prefs.getRole("customerType").toString() == "Lease")
                ? griditem(context)
                : (Prefs.getRole("customerType").toString() == "Sales")
                    ? getSales(context)
                    : gettenantitem(context),

            SizedBox(
              height: 28,
            ),

            carousalimages(context),
          ],
        ),
      ),
    );
  }

  Widget carousalimages(context) {
    return
        // Container(
        //     padding: EdgeInsets.only(top: 50),
        //     height: 250,
        //     width: MediaQuery.of(context).size.width,
        //     child: ClipRRect(
        //       borderRadius: BorderRadius.circular(16),
        //       child: CarouselSlider(
        //           options: CarouselOptions(
        //             enlargeCenterPage: true,
        //             enableInfiniteScroll: false,
        //             initialPage: 0,
        //             autoPlay: true,
        //           ),
        //           items: sliderimgList
        //               .map((e) => ClipRRect(
        //                     borderRadius: BorderRadius.circular(15),
        //                     child: Stack(
        //                       fit: StackFit.expand,
        //                       children: <Widget>[
        //                         Image.asset(
        //                           e,
        //                           width: 250,
        //                           height: 250,
        //                           fit: BoxFit.cover,
        //                         )
        //                       ],
        //                     ),
        //                   ))
        //               .toList()),
        //     )
        //     );
        CarouselSlider(
      options: CarouselOptions(
        height: 200,
        autoPlay: true,
        enlargeCenterPage: true,
        aspectRatio: 16 / 9,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        viewportFraction: 0.8,
      ),
      items: images.map((img) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Image.asset(
            img,
            fit: BoxFit.cover,
            width: double.infinity,
          ),
        );
      }).toList(),
    );
  }

  Widget griditem(context) {
    return Padding(
      padding: const EdgeInsets.only(top: 0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: AppConstants.names.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
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
                  MaterialPageRoute(builder: (context) => StatementScreen()),
                );
              } else if (index == 6) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AppointmentScreen()),
                );
              }
            },
            child:
                // Container(
                //   decoration: BoxDecoration(
                //     border: Border.all(color: Colors.grey),
                //     borderRadius: BorderRadius.circular(12),
                //   ),
                //   padding: const EdgeInsets.all(8),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.center,
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       SizedBox(
                //         height: 10,
                //       ),
                //       // SvgPicture.asset(
                //       //     'assets/images/${AppConstants.iconname[index]}',
                //       //     width: 20,
                //       //     height: 20,
                //       //     color: AppColor.iconColor),
                //         Image.asset(
                //   gridIcons[index],
                //   width: 40,
                //   height: 40,
                //   color: AppColor.accentColor,
                // ),

                //       const SizedBox(height: 8),
                //       Expanded(
                //         child: Text(AppConstants.names[index].toString(),
                //             style: TextStyle(
                //                 fontSize: 12,
                //                 fontWeight: FontWeight.w600,
                //                 overflow: TextOverflow.ellipsis,
                //                 color: AppColor.iconColor)),
                //       ),
                //     ],
                //   ),
                // ),
                // child: Container(
                //   decoration: BoxDecoration(
                //     border: Border.all(color: Colors.grey.shade500),
                //     borderRadius: BorderRadius.circular(12),
                //   ),
                //   padding: EdgeInsets.all(5),
                //   margin: EdgeInsets.all(5),
                //   child: Column(
                //     children: [
                //       SizedBox(
                //         height: 20,
                //       ),
                //       SvgPicture.asset(
                //         'assets/images/${AppConstants.iconname[index]}',
                //         width: 20,
                //         height: 20,
                //       ),
                //       SizedBox(
                //         height: 5,
                //       ),
                //       Text(
                //         softWrap: true,
                //         overflow: TextOverflow.clip,
                //         AppConstants.names[index].toString(),
                //         textAlign: TextAlign.left,
                //         style: TextStyle(
                //           fontSize: 12,
                //           height: 1.2,
                //         ),
                //       )
                //     ],
                //   ),
                // ),
                Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppColor.appBarColor,
              ),
              child:
               Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    gridIcons[index],
                    width: 40,
                    height: 40,
                    color: AppColor.accentColor,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    gridNames[index],
                    style: const TextStyle(
                      color: AppColor.primary,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget gettenantitem(context) {
    return Padding(
      padding: const EdgeInsets.only(top: 18.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: AppConstants.tenantnames.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.8,
        ),
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
              } else if (index == 2) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const NewsPage()),
                );
              }
            },
            child: Container(
              padding: EdgeInsets.all(5),
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0),
                    topLeft: Radius.circular(10.0),
                    bottomLeft: Radius.circular(10.0)),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  SvgPicture.asset(
                    'assets/images/${AppConstants.tenanticonname[index]}',
                    width: 30,
                    height: 30,
                  ),
                  Text(
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    AppConstants.tenantnames[index].toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.2,
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
//sales
  Widget getSales(context) {
    return Padding(
      padding: const EdgeInsets.only(top: 0.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: salesNames.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
  crossAxisCount: 2,       
  childAspectRatio: 2,   
  crossAxisSpacing: 10.0,  
  mainAxisSpacing: 10.0,    
),

        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              if (index == 0) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const Salesestimate()),
                );
              } else if (index == 1) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const Salesreservation()),
                );
              } 
              else if (index == 2) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const 
                      
                      Salescontract()
                  
                      ),
                );
              }
              else if (index == 3) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SalesSevicerequest()),
                );
              }
              else if (index == 4) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const Salespaymentdetails()),
                );
              }
              else if (index == 5) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SalesFaqPage()),
                );
              }
              else if (index == 6) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SalesUnitstatement()),
                );
              }
            },
            child:
             Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppColor.white,
              ),
              child:
               Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    salesIcons[index],
                    width: 40,
                    height: 40,
                    color: AppColor.accentColor,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    salesNames[index],
                    style: const TextStyle(
                      color: AppColor.primary,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

//

class MenuButton extends StatelessWidget {
  final IconData icon;
  final String label;

  const MenuButton({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.amber.shade800),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Icon(icon, color: Colors.amber.shade800),
          const SizedBox(width: 8),
          Expanded(
            child: Text(label,
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
}
