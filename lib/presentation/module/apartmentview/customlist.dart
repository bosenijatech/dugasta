// import 'package:dugasta/presentation/util/apartmentlist.dart';
// import 'package:dugasta/presentation/utils/apptheme.dart';
// import 'package:flutter/material.dart';

// class CustomListViewApartment extends StatelessWidget {
//   const CustomListViewApartment({
//     Key? key,
//     this.hotelData,
//     this.animationController,
//     this.animation,
//     this.callback,
//     this.isFavorite = false,
//     this.onFavoriteToggle,
//   }) : super(key: key);

//   final VoidCallback? callback;
//   final ApartmentModel? hotelData;
//   final AnimationController? animationController;
//   final Animation<double>? animation;
//   final bool isFavorite;
//   final VoidCallback? onFavoriteToggle;

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: animationController!,
//       builder: (BuildContext context, Widget? child) {
//         return FadeTransition(
//           opacity: animation!,
//           child: Transform(
//             transform: Matrix4.translationValues(
//                 0.0, 50 * (1.0 - animation!.value), 0.0),
//             child: Padding(
//               padding: const EdgeInsets.only(
//                   left: 24, right: 24, top: 8, bottom: 16),
//               child: InkWell(
//                 splashColor: Colors.transparent,
//                 onTap: callback,
//                 child: Container(
//                   decoration: BoxDecoration(
//                     borderRadius: const BorderRadius.all(Radius.circular(16.0)),
//                     boxShadow: <BoxShadow>[
//                       BoxShadow(
//                         color: Colors.grey.withOpacity(0.6),
//                         offset: const Offset(4, 4),
//                         blurRadius: 16,
//                       ),
//                     ],
//                   ),
//                   child: ClipRRect(
//                     borderRadius: const BorderRadius.all(Radius.circular(16.0)),
//                     child: Stack(
//                       children: <Widget>[
//                         Column(
//                           children: <Widget>[
//                             AspectRatio(
//                               aspectRatio: 2,
//                               child: Image.asset(
//                                 hotelData!.imagePath,
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                             Container(
//                               color: AppTheme.buildLightTheme().cardColor,
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: <Widget>[
//                                   Expanded(
//                                     child: Container(
//                                       child: Padding(
//                                         padding: const EdgeInsets.only(
//                                             left: 16, top: 8, bottom: 8),
//                                         child: Column(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.center,
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: <Widget>[
//                                             Text(
//                                               hotelData!.titleTxt,
//                                               textAlign: TextAlign.left,
//                                               style: TextStyle(
//                                                 fontWeight: FontWeight.w600,
//                                                 fontSize: 16,
//                                               ),
//                                             ),
//                                             Row(
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.center,
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment.start,
//                                               children: <Widget>[
//                                                 Text(
//                                                   hotelData!.subTxt,
//                                                   style: TextStyle(
//                                                       fontSize: 14,
//                                                       color: Colors.grey
//                                                           .withOpacity(0.8)),
//                                                 ),
//                                                 const SizedBox(
//                                                   width: 4,
//                                                 ),
//                                                 Icon(
//                                                   Icons.location_pin,
//                                                   size: 12,
//                                                   color:
//                                                       AppTheme.buildLightTheme()
//                                                           .primaryColor,
//                                                 ),
//                                                 Expanded(
//                                                   child: Text(
//                                                     '${hotelData!.dist.toStringAsFixed(1)} km to city',
//                                                     overflow:
//                                                         TextOverflow.ellipsis,
//                                                     style: TextStyle(
//                                                         fontSize: 14,
//                                                         color: Colors.grey
//                                                             .withOpacity(0.8)),
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   // Padding(
//                                   //   padding: const EdgeInsets.only(
//                                   //       right: 16, top: 8),
//                                   //   child: Column(
//                                   //     mainAxisAlignment:
//                                   //         MainAxisAlignment.center,
//                                   //     crossAxisAlignment:
//                                   //         CrossAxisAlignment.end,
//                                   //     children: <Widget>[
//                                   //       Text(
//                                   //         'AED 2000',
//                                   //         textAlign: TextAlign.left,
//                                   //         style: TextStyle(
//                                   //           fontWeight: FontWeight.w600,
//                                   //           fontSize: 16,
//                                   //         ),
//                                   //       ),
//                                   //       Text(
//                                   //         '/per month',
//                                   //         style: TextStyle(
//                                   //             fontSize: 14,
//                                   //             color:
//                                   //                 Colors.grey.withOpacity(0.8)),
//                                   //       ),
//                                   //     ],
//                                   //   ),
//                                   // ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                         Positioned(
//                           top: 8,
//                           right: 8,
//                           child: IconButton(
//                             icon: Icon(
//                               isFavorite
//                                   ? Icons.favorite
//                                   : Icons.favorite_border,
//                               color: isFavorite ? Colors.red : Colors.grey,
//                             ),
//                             onPressed: () {
//                               onFavoriteToggle?.call();
//                               if (isFavorite) {
//                                 ApartmentModel.removeFromWishlist(hotelData!);
//                               } else {
//                                 ApartmentModel.addToWishlist(hotelData!);
//                               }
//                             },
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
