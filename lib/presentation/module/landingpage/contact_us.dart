import 'package:dugasta/presentation/module/enquiry/enquiryform.dart';
import 'package:dugasta/presentation/util/apartmentlist.dart';
import 'package:dugasta/presentation/util/app_colors.dart';
import 'package:dugasta/presentation/util/app_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContactusPage extends StatefulWidget {
  const ContactusPage({super.key});

  @override
  State<ContactusPage> createState() => _ContactusPageState();
}

class _ContactusPageState extends State<ContactusPage> {
  List<ApartmentModel> model = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Contact-Us',
        style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [contactspage1(), contactspage2()],
        ),
      ),
    );
  }

  Widget contactspage1() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Image.asset(
          'assets/images/apartment1.png',
          height: 250,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "DUGASTA -  Real Estate",
                style: TextStyle(
                  fontSize: 20,
                  color:AppColor.primary,
                ),
              ),
              Container(height: 10),
              Text(
                "You can book a virtual Apartment as well as a in - person appointment to get your questions answered",
                style: TextStyle(
                  fontSize: 15,
                    color:AppColor.grey1,
                ),
              ),
              Row(
                children: const <Widget>[
                  Spacer(),
                  //  ElevatedButton.icon(
                  //    style: ElevatedButton.styleFrom(
                  //         backgroundColor: AppColor.primary,
                  //         foregroundColor: AppColor.secondaryColor,
                  //         shape: RoundedRectangleBorder(
                  //           borderRadius: BorderRadius.circular(12),
                  //         ),
                  //         padding: const EdgeInsets.symmetric(
                  //           horizontal: 10,
                  //           vertical: 10,
                  //         ),
                  //       ),
                  //     label: const Text(
                  //         "Get in touch",
                  //         style: TextStyle(fontSize: 16),
                  //       ),
                  //   onPressed: () {
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //           builder: (context) => Enquirypage(
                  //               house: model, position: 0, normaltype: 0)),
                  //     );
                  //   },
                  // ),
                ],
              ),
            ],
          ),
        ),
        Container(height: 20),
      ],
    );
  }

  Widget contactspage2() {
    return const Center(
        child: Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Icon(CupertinoIcons.location_circle, size: 30,color: AppColor.supportColor,),
            title: Text('Office Address', style: TextStyle(color: AppColor.grey1),),
            subtitle: Text(
              'Towers - DIFC, Central Park - 31st Floor - Trade Centre - DIFC - Dubai', style: TextStyle(color: AppColor.primary),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ListTile(
            leading: Icon(CupertinoIcons.calendar, size: 30,color: AppColor.supportColor,),
            title: Text('Hours', style: TextStyle(color: AppColor.grey1),),
            subtitle: Text(
              'We always aim to reply within 24 hours', style: TextStyle(color: AppColor.primary),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ListTile(
            leading: Icon(CupertinoIcons.phone, size: 30,color: AppColor.supportColor,),
            title: Text('Customer Care', style: TextStyle(color: AppColor.grey1),),
            subtitle: Text(
              'Phone: 800 384 2782', style: TextStyle(color: AppColor.primary),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ListTile(
            leading: Icon(CupertinoIcons.mail, size: 30,color: AppColor.supportColor,),
            title: Text('Email Us', style: TextStyle(color: AppColor.grey1),),
            subtitle: Text(
              'sales@dugasta.com', style: TextStyle(color: AppColor.primary),
            ),
          ),
        ],
      ),
    ));
  }

  void onexitpopup() {
    AppUtils.pop(context);
  }
}
