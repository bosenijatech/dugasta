// import 'package:dugasta/presentation/util/apartmentlist.dart';
// import 'package:dugasta/presentation/util/app_utils.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';

// class HouseInfo extends StatelessWidget {
//   final ApartmentModel house;
//   final int position;
//   const HouseInfo({Key? key, required this.house, required this.position})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20),
//       child: Column(
//         children: [
//           Row(
//             children: [
//               _MenuInfo(
//                   imageUrl: 'assets/icons/bedroom.svg',
//                   content:house.message![widget.position].apartmenttype.toString()),
//               // _MenuInfo(
//               //   imageUrl: 'assets/icons/bathroom.svg',
//               //   content: '1 Kitchen \n1 Toilet',
//               // ),
//             ],
//           ),
//           SizedBox(height: 10),
//           // Row(
//           //   children: [
//           //     _MenuInfo(
//           //       imageUrl: 'assets/icons/kitchen.svg',
//           //       content: '2 Kitchen\n120 sqft',
//           //     ),
//           //     _MenuInfo(
//           //       imageUrl: 'assets/icons/parking.svg',
//           //       content: '5 Parking\n120 sqft',
//           //     ),
//           //   ],
//           // )
//         ],
//       ),
//     );
//   }
// }

// class _MenuInfo extends StatelessWidget {
//   final String imageUrl;
//   final String content;

//   const _MenuInfo({
//     Key? key,
//     required this.imageUrl,
//     required this.content,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: Row(
//         children: [
//           SvgPicture.asset(imageUrl),
//           const SizedBox(width: 20),
//           AppUtils.buildNormalText(text: content, fontSize: 12),
//         ],
//       ),
//     );
//   }
// }
