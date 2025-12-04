import 'package:dugasta/presentation/module/apartmentview/apartmentview.dart';
import 'package:dugasta/presentation/util/apartmentlist.dart';
import 'package:dugasta/presentation/util/appcontants.dart';
import 'package:dugasta/presentation/utils/apptheme.dart';
import 'package:flutter/material.dart';

class WishList extends StatefulWidget {
  final List<ApartmentModel> wishlistApartments;
  final List<String> wishlistIds;
  const WishList(
      {Key? key, required this.wishlistIds, required this.wishlistApartments})
      : super(key: key);

  @override
  State<WishList> createState() => _WishListState();
}

class _WishListState extends State<WishList> with TickerProviderStateMixin {
  AnimationController? animationController;
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
          'My Wishlist',
          style: TextStyle(color: Colors.white),
        )),
        body: Container(
          // color: AppTheme.buildLightTheme().colorScheme.surface,
          child: widget.wishlistApartments.isNotEmpty
              ? ListView.builder(
                  itemCount: widget.wishlistApartments.length,
                  padding: const EdgeInsets.only(top: 8),
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext context, int index) {
                    final apartment = widget.wishlistApartments[index];
                    final int count = widget.wishlistApartments.length > 10
                        ? 10
                        : widget.wishlistApartments.length;
                    final Animation<double> animation =
                        Tween<double>(begin: 0.0, end: 1.0).animate(
                            CurvedAnimation(
                                parent: animationController!,
                                curve: Interval((1 / count) * index, 1.0,
                                    curve: Curves.fastOutSlowIn)));
                    animationController?.forward();

                    return AnimatedBuilder(
                      animation: animationController!,
                      builder: (BuildContext context, Widget? child) {
                        return FadeTransition(
                          opacity: animation,
                          child: Transform(
                            transform: Matrix4.translationValues(
                                0.0, 50 * (1.0 - animation.value), 0.0),
                            child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 24, right: 24, top: 8, bottom: 16),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(16.0)),
                                    boxShadow: <BoxShadow>[
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.6),
                                        offset: const Offset(4, 4),
                                        blurRadius: 16,
                                      ),
                                    ],
                                  ),
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(16.0)),
                                    child: Stack(
                                      children: [
                                        Column(
                                          children: [
                                            AspectRatio(
                                              aspectRatio: 2,
                                              child: apartment.imageUrl == null
                                                  ? Image.asset(
                                                      'assets/images/one.jpg',
                                                      fit: BoxFit.cover,
                                                    )
                                                  : Image.network(
                                                      AppConstants
                                                              .attachmentURL +
                                                          apartment.imageUrl
                                                              .toString(),
                                                      fit: BoxFit.cover,
                                                    ),
                                            ),
                                            Container(
                                              // color: AppTheme.buildLightTheme()
                                              //     .cardColor,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    child: Container(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 5,
                                                                top: 8,
                                                                bottom: 8),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              apartment
                                                                  .buildingname
                                                                  .toString(),
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize: 16,
                                                              ),
                                                            ),
                                                            Row(
                                                              children: [
                                                                (apartment.propertylocationname ==
                                                                            null ||
                                                                        apartment.propertylocationname.toString() ==
                                                                            "")
                                                                    ? Container()
                                                                    : Icon(
                                                                        Icons
                                                                            .location_on_outlined,
                                                                        color: Colors
                                                                            .grey,
                                                                      ),
                                                                Text(
                                                                  (apartment.propertylocationname ==
                                                                              null ||
                                                                          apartment.propertylocationname.toString() ==
                                                                              "")
                                                                      ? ""
                                                                      : apartment
                                                                          .propertylocationname
                                                                          .toString(),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                  ),
                                                                ),
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                )),
                          ),
                        );
                      },
                    );
                  },
                )
              : Container(
                  child: Text('No Property!'),
                ),
        ));
    // ListView.builder(
    //     itemCount: wishlistApartments.length,
    //     itemBuilder: (context, index) {
    //       final apartment = wishlistApartments[index];
    //       return Card(
    //         elevation: 3,
    //         child: Padding(
    //           padding: const EdgeInsets.all(8.0),
    //           child: Stack(
    //             children: [
    //               Column(
    //                 children: [
    //                   AspectRatio(
    //                     aspectRatio: 2,
    //                     child: apartment.imageUrl == null
    //                         ? Image.asset(
    //                             'assets/images/community2.png',
    //                             fit: BoxFit.cover,
    //                           )
    //                         : Image.network(
    //                             AppConstants.attachmentURL +
    //                                 apartment.imageUrl.toString(),
    //                             fit: BoxFit.cover,
    //                           ),
    //                   ),
    //                   Container(
    //                     color: AppTheme.buildLightTheme().cardColor,
    //                     child: Row(
    //                       mainAxisAlignment: MainAxisAlignment.center,
    //                       crossAxisAlignment: CrossAxisAlignment.start,
    //                       children: [
    //                         Expanded(
    //                           child: Container(
    //                             child: Padding(
    //                               padding: const EdgeInsets.only(
    //                                   left: 5, top: 8, bottom: 8),
    //                               child: Column(
    //                                 mainAxisAlignment:
    //                                     MainAxisAlignment.center,
    //                                 crossAxisAlignment:
    //                                     CrossAxisAlignment.start,
    //                                 children: [
    //                                   Text(
    //                                     apartment.buildingname.toString(),
    //                                     textAlign: TextAlign.left,
    //                                     style: TextStyle(
    //                                       fontWeight: FontWeight.w600,
    //                                       fontSize: 16,
    //                                     ),
    //                                   ),
    //                                   Row(
    //                                     children: [
    //                                       Icon(
    //                                         Icons.location_on_outlined,
    //                                         color: Colors.grey,
    //                                       ),
    //                                       Text(
    //                                         apartment
    //                                                 .propertylocationname ??
    //                                             "",
    //                                         textAlign: TextAlign.left,
    //                                         style: TextStyle(
    //                                           fontSize: 12,
    //                                         ),
    //                                       ),
    //                                     ],
    //                                   )
    //                                 ],
    //                               ),
    //                             ),
    //                           ),
    //                         ),
    //                       ],
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ],
    //           ),
    //         ),
    //       );
    //     }));
  }

  final TextStyle priceTextStyle = const TextStyle(
    color: Colors.black,
    fontSize: 24.0,
    fontWeight: FontWeight.bold,
  );

  final TextStyle titleTextStyle = const TextStyle(
    color: Colors.black,
    fontSize: 16.0,
    fontWeight: FontWeight.w500,
  );
}
