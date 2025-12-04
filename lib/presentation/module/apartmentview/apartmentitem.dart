// import 'package:dugasta/presentation/util/apartmentlist.dart';
// import 'package:dugasta/presentation/util/app_colors.dart';
// import 'package:dugasta/presentation/util/appcontants.dart';
// import 'package:flutter/material.dart';

// class ApartmentItem extends StatelessWidget {
//   ApartmentModel hotel;
//   int position;
//   ApartmentItem(
//       {Key? key,
//       required this.hotel,
//       required this.position})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {},
//       child: Container(
//         child: Stack(
//           children: <Widget>[
//             Hero(
//               tag: Key('key${hotel.!.first.iV}'),
//               child: Padding(
//                 padding: const EdgeInsets.all(5.0),
//                 child: ClipRRect(
//                     borderRadius: BorderRadius.circular(8.0),
//                     child: Image.asset(
//                         AppConstants.apartmentListimages[imageIndex],
//                         fit: BoxFit.cover)),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: Card(
//                 elevation: 8,
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10.0)),
//                 margin: const EdgeInsets.only(top: 200),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[
//                     ListTile(
//                       title: Text(
//                         hotel[position].buildingname.toString(),
//                         style: titleTextStyle,
//                       ),
//                       subtitle: Text(
//                         hotel.message![position].propertylocationname
//                             .toString(),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   final TextStyle priceTextStyle = const TextStyle(
//     color: Colors.black,
//     fontSize: 24.0,
//     fontWeight: FontWeight.bold,
//   );

//   final TextStyle titleTextStyle = const TextStyle(
//     color: Colors.black,
//     fontSize: 16.0,
//     fontWeight: FontWeight.w500,
//   );
// }
