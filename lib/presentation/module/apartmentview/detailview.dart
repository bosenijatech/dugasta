import 'package:dugasta/presentation/module/apartmentview/houseinfo.dart';
import 'package:dugasta/presentation/module/enquiry/enquiryform.dart';
import 'package:dugasta/presentation/util/app_utils.dart';
import 'package:dugasta/presentation/util/apartmentlist.dart';
import 'package:dugasta/presentation/util/appcontants.dart';
import 'package:dugasta/presentation/utils/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../util/app_style.dart';

class Details extends StatefulWidget {
  List<ApartmentModel> house;
  int position;

  Details({Key? key, required this.house, required this.position})
      : super(key: key);

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            detailAppbar(widget.house),
            SizedBox(height: 20),
            contentintro(widget.house),
            const SizedBox(height: 20),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Row(
            //     children: [
            //       SvgPicture.asset('assets/icons/bedroom.svg'),
            //       const SizedBox(width: 20),
            //       AppUtils.buildNormalText(
            //           text:
            //               widget.house[widget.position].buildingtype.toString(),
            //           fontSize: 12),
            //     ],
            //   ),
            // ),
            const SizedBox(height: 20),
            description(widget.house),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: CustomButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Enquirypage(
                                    house: widget.house,
                                    position: widget.position,
                                    normaltype: 1)));
                      },
                      name: 'Enquiry Now',
                      circularvalue: 30,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget detailAppbar(house) {
    return SizedBox(
      height: 400,
      child: Stack(
        children: [
          widget.house[widget.position].imageUrl == null ||
                  widget.house[widget.position].imageUrl.toString().isEmpty ||
                  widget.house[widget.position].imageUrl.toString() == ""
              ? Image.asset(
                  // 'assets/images/one.jpg',
                      AppAssets.carousel1,
                  height: 400,
                  fit: BoxFit.cover,
                )
              : Image.network(
                  AppConstants.attachmentURL +
                      widget.house[widget.position].imageUrl.toString(),
                  height: 400,
                  fit: BoxFit.cover,
                ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => _handleNavigateBack(context),
                    child: Container(
                      height: 20,
                      width: 20,
                      padding: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(
                        color: Colors.grey,
                        shape: BoxShape.circle,
                      ),
                      child: SvgPicture.asset('assets/icons/arrow.svg'),
                    ),
                  ),
                  // Container(
                  //   height: 20,
                  //   width: 20,
                  //   padding: const EdgeInsets.all(5),
                  //   decoration: BoxDecoration(
                  //     color: Theme.of(context).colorScheme.secondary,
                  //     shape: BoxShape.circle,
                  //   ),
                  //   child: SvgPicture.asset('assets/icons/mark.svg'),
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget contentintro(house) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.house[widget.position].buildingname ?? "-",
            style: Theme.of(context).textTheme.displayLarge!.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 10),
          // Text(
          //   house.subTxt,
          //   style: Theme.of(context).textTheme.bodyLarge!.copyWith(
          //         fontSize: 14,
          //       ),
          // ),
          const SizedBox(height: 15),
          // Text(
          //   '500 sqft',
          //   style: Theme.of(context).textTheme.bodyLarge!.copyWith(
          //         fontSize: 14,
          //       ),
          // ),
          // const SizedBox(height: 5),
          // RichText(
          //   text: TextSpan(
          //     children: [
          //       TextSpan(
          //         text: 'AED 4455',
          //         style: Theme.of(context).textTheme.displayLarge!.copyWith(
          //               fontSize: 16,
          //               fontWeight: FontWeight.bold,
          //             ),
          //       ),
          //       TextSpan(
          //         text: ' Per Month',
          //         style: Theme.of(context).textTheme.bodyLarge!.copyWith(
          //               fontSize: 14,
          //             ),
          //       ),
          //     ],
          //   ),
          // )
        ],
      ),
    );
  }

  Widget description(house) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppUtils.buildNormalText(text: 'About', fontWeight: FontWeight.bold),
          const SizedBox(height: 10),
          Text(
            'Multi-unit: Contains multiple residential units, each usually on a single level.\n\n'
            'Independent facilities: Each unit has its own cooking and bathroom facilities.\n\n'
            'Various structures: Can be low-rise, mid-rise, or high-rise buildings.\n\n'
            'Shared amenities: May offer shared amenities like laundry rooms, gyms, and pools, depending on the complex.',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 14,
                ),
          )
        ],
      ),
    );
  }

  _handleNavigateBack(BuildContext context) {
    Navigator.of(context).pop();
  }
}
