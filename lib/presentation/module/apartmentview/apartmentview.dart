import 'dart:convert';

import 'package:dugasta/data/api_service.dart';
import 'package:dugasta/domain/pref.dart';
import 'package:dugasta/presentation/module/apartmentview/detailview.dart';
import 'package:dugasta/presentation/module/wishlist/wishlistpage.dart';
import 'package:dugasta/presentation/util/app_colors.dart';
import 'package:dugasta/presentation/util/app_utils.dart';
import 'package:dugasta/presentation/util/appcontants.dart';
import 'package:dugasta/presentation/util/calendarpopview.dart';
import 'package:dugasta/presentation/util/apartmentlist.dart';
import 'package:dugasta/presentation/utils/apptheme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../util/app_style.dart';
import 'apartmentview.dart' as MyData;

class ApartmentView extends StatefulWidget {
  const ApartmentView({super.key});

  @override
  _ApartmentViewState createState() => _ApartmentViewState();
}

class _ApartmentViewState extends State<ApartmentView>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  List<ApartmentModel> hotelList = [];
  final ScrollController _scrollController = ScrollController();
  List<String> wishlist = [];
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(const Duration(days: 5));
  bool isclickable = false;
  bool loading = false;

  TextEditingController searchcontroller = TextEditingController();

  // List<ApartmentModel> filteredOrders = [];


List filteredOrders =
    MyData.apartments.map((e) => ApartmentModel.fromMap(e)).toList();


  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    getapartmentlist();
   
   
    loadWishlist();
    super.initState();
  }

  void loadWishlist() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    wishlist =
        prefs.getStringList('wishlist_${Prefs.getTenantID("TenantId")}') ?? [];
    setState(() {});
  }

  void clearWishlist(String techId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('wishlist_$techId');
  }

  void toggleWishlist(
    String id,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> currentWishlist =
        prefs.getStringList('wishlist_${Prefs.getTenantID("TenantId")}') ?? [];

    if (currentWishlist.contains(id)) {
      currentWishlist.remove(id);
    } else {
      currentWishlist.add(id);
    }

    await prefs.setStringList(
        'wishlist_${Prefs.getTenantID("TenantId")}', currentWishlist);
    wishlist = currentWishlist;
    setState(() {});
  }

  @override
  void dispose() {
    searchcontroller.dispose();
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: !loading
            ? Stack(
                children: [
                  InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                    child: Column(
                      children: [
                        getAppBarUI(),
                        Expanded(
                          child: NestedScrollView(
                            controller: _scrollController,
                            headerSliverBuilder: (BuildContext context,
                                bool innerBoxIsScrolled) {
                              return [
                                SliverList(
                                  delegate: SliverChildBuilderDelegate(
                                      (BuildContext context, int index) {
                                    return Column(
                                      children: [
                                        getSearchBarUI(),
                                        //getTimeDateUI(),
                                      ],
                                    );
                                  }, childCount: 1),
                                ),
                                SliverPersistentHeader(
                                  pinned: true,
                                  floating: true,
                                  delegate: ContestTabHeader(
                                    getFilterBarUI(),
                                  ),
                                ),
                              ];
                            },
                            body: Container(
                              color: Colors.white,
                              child: _filterItems(searchcontroller.text)
                                      .isNotEmpty
                                  ? ListView.builder(
                                      itemCount:
                                          _filterItems(searchcontroller.text)
                                              .length,
                                      padding: const EdgeInsets.only(top: 8),
                                      scrollDirection: Axis.vertical,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        final apartmentlist = _filterItems(
                                            searchcontroller.text)[index];
                                        final int count =
                                            hotelList.length > 10
                                                ? 10
                                                : hotelList.length;
                                        final apartment =
                                            filteredOrders[index];
                                        final isWishlisted = wishlist
                                            .contains(apartment.internalid);
                                        final Animation<double>
                                            animation = Tween<double>(
                                                    begin: 0.0, end: 1.0)
                                                .animate(CurvedAnimation(
                                                    parent:
                                                        animationController!,
                                                    curve: Interval(
                                                        (1 / count) * index,
                                                        1.0,
                                                        curve: Curves
                                                            .fastOutSlowIn)));
                                        animationController?.forward();
    
                                        return AnimatedBuilder(
                                          animation: animationController!,
                                          builder: (BuildContext context,
                                              Widget? child) {
                                            return FadeTransition(
                                              opacity: animation,
                                              child: Transform(
                                                transform:
                                                    Matrix4.translationValues(
                                                        0.0,
                                                        50 *
                                                            (1.0 -
                                                                animation
                                                                    .value),
                                                        0.0),
                                                child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 24,
                                                            right: 24,
                                                            top: 8,
                                                            bottom: 16),
                                                    child: InkWell(
                                                      splashColor:
                                                          Colors.transparent,
                                                      onTap: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        Details(
                                                                          position:
                                                                              index,
                                                                          house:
                                                                              _filterItems(searchcontroller.text),
                                                                        )));
                                                      },
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .all(
                                                                  Radius.circular(
                                                                      16.0)),
                                                          boxShadow: <BoxShadow>[
                                                            BoxShadow(
                                                              color: Colors
                                                                  .grey
                                                                  .withOpacity(
                                                                      0.6),
                                                              offset:
                                                                  const Offset(
                                                                      4, 4),
                                                              blurRadius: 16,
                                                            ),
                                                          ],
                                                        ),
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .all(
                                                                  Radius.circular(
                                                                      16.0)),
                                                          child: Stack(
                                                            children: [
                                                              Column(
                                                                children: [
                                                                  AspectRatio(
                                                                    aspectRatio:
                                                                        2,
                                                                    child: apartmentlist.imageUrl == null ||
                                                                            apartmentlist.imageUrl.toString().isEmpty ||
                                                                            apartmentlist.imageUrl.toString() == ""
                                                                        ? Image.asset(
                                                                            // 'assets/images/one.jpg',
                                                                            AppAssets.carousel1,
                                                                            fit: BoxFit.cover,
                                                                          )
                                                                        : Image.network(
                                                                            AppConstants.attachmentURL + apartmentlist.imageUrl.toString(),
                                                                            fit: BoxFit.cover,
                                                                          ),
                                                                  ),
                                                                  Container(
                                                                    color: AppTheme
                                                                            .primary
                                                                      ,
                                                                    child:
                                                                        Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment.center,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment.start,
                                                                      children: [
                                                                        Expanded(
                                                                          child:
                                                                              Container(
                                                                            child: Padding(
                                                                              padding: const EdgeInsets.only(left: 5, top: 8, bottom: 8),
                                                                              child: Column(
                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  Text(
                                                                                    apartmentlist.buildingname.toString(),
                                                                                    textAlign: TextAlign.left,
                                                                                    style: TextStyle(
                                                                                      fontWeight: FontWeight.w600,
                                                                                      fontSize: 16,
                                                                                      color: Colors.white
                                                                                    ),
                                                                                  ),
                                                                                  Row(
                                                                                    children: [
                                                                                      (apartmentlist.propertylocationname == null || apartmentlist.propertylocationname.toString() == "")
                                                                                          ? Container()
                                                                                          : Icon(
                                                                                              Icons.location_on_outlined,
                                                                                              color: Colors.grey,
                                                                                            ),
                                                                                      Text(
                                                                                        (apartmentlist.propertylocationname == null || apartmentlist.propertylocationname.toString() == "") ? "" : apartmentlist.propertylocationname.toString(),
                                                                                        textAlign: TextAlign.left,
                                                                                        style: TextStyle(
                                                                                            color: Colors.white,
                                                                                          fontSize: 12,
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
                                                              Positioned(
                                                                top: 8,
                                                                right: 8,
                                                                child:
                                                                    IconButton(
                                                                        icon:
                                                                            Icon(
                                                                          isWishlisted
                                                                              ? Icons.favorite
                                                                              : Icons.favorite_border,
                                                                          color: isWishlisted
                                                                              ? Colors.red
                                                                              : Colors.yellow,
                                                                        ),
                                                                        onPressed: () => toggleWishlist(apartment
                                                                            .internalid
                                                                            .toString())),
                                                              )
                                                            ],
                                                          ),
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
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }

  Widget getTimeDateUI() {
    return Padding(
      padding: const EdgeInsets.only(left: 18, bottom: 16),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    focusColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    splashColor: Colors.grey.withOpacity(0.2),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(4.0),
                    ),
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      // setState(() {
                      //   isDatePopupOpen = true;
                      // });
                      showDemoDialog(context: context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 8, right: 8, top: 4, bottom: 4),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Choose date',
                            style: TextStyle(
                                fontWeight: FontWeight.w100,
                                fontSize: 16,
                                color: Colors.grey.withOpacity(0.8)),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            '${DateFormat("dd, MMM").format(startDate)} - ${DateFormat("dd, MMM").format(endDate)}',
                            style: TextStyle(
                              fontWeight: FontWeight.w100,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Container(
              width: 1,
              height: 42,
              color: Colors.grey.withOpacity(0.8),
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    focusColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    splashColor: Colors.grey.withOpacity(0.2),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(4.0),
                    ),
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 8, right: 8, top: 4, bottom: 4),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Type',
                            style: TextStyle(
                                fontWeight: FontWeight.w100,
                                fontSize: 16,
                                color: Colors.grey.withOpacity(0.8)),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            '1 BHK - 2 BHK',
                            style: TextStyle(
                              fontWeight: FontWeight.w100,
                              fontSize: 16,
                            ),
                          ),
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
    );
  }

  Widget getSearchBarUI() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 8),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 16, top: 12, bottom: 8),
              child: Container(
                decoration: BoxDecoration(
                  // color: AppTheme.buildLightTheme().cardColor,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(38.0),
                  ),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        offset: const Offset(0, 2),
                        blurRadius: 8.0),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, top: 4, bottom: 4),
                  child: TextField(
                    controller: searchcontroller,
                    onChanged: (val) {
                      setState(() {
                        searchcontroller.text;
                      });
                    },
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                    // cursorColor: AppTheme.buildLightTheme().primaryColor,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Search...',
                      suffixIcon: InkWell(
                          onTap: () {
                            setState(() {
                              searchcontroller.text = "";
                              searchcontroller.clear();
                            });
                          },
                          child: const Icon(Icons.clear)),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void addToWishlist(String apartmentId) async {
    wishlist.add(apartmentId);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('wishlist', wishlist);
  }

  void removeFromWishlist(String apartmentId) async {
    wishlist.remove(apartmentId);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('wishlist', wishlist);
  }

  Widget getFilterBarUI() {
    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 24,
            decoration: BoxDecoration(
              // color: AppTheme.buildLightTheme().colorScheme.surface,
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    offset: const Offset(0, -2),
                    blurRadius: 8.0),
              ],
            ),
          ),
        ),
        Container(
          // color: AppTheme.buildLightTheme().colorScheme.surface,
          child: Padding(
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 4),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '${hotelList.length} Villas and apartment found',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Divider(height: 1, color: Colors.grey.shade300),
        )
      ],
    );
  }

  void showDemoDialog({BuildContext? context}) {
    showDialog<dynamic>(
      context: context!,
      builder: (BuildContext context) => CalendarPopupView(
        barrierDismissible: true,
        minimumDate: DateTime.now(),
        //  maximumDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 10),
        initialEndDate: endDate,
        initialStartDate: startDate,
        onApplyClick: (DateTime startData, DateTime endData) {
          setState(() {
            startDate = startData;
            endDate = endData;
          });
        },
        onCancelClick: () {},
      ),
    );
  }

  Widget getAppBarUI() {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.primary,
        //color: AppTheme.buildLightTheme().colorScheme.surface,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              offset: const Offset(0, 2),
              blurRadius: 8.0),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top, left: 8, right: 8),
        child: Row(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              width: AppBar().preferredSize.height + 40,
              height: AppBar().preferredSize.height,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(32.0),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.arrow_back,
                      color: AppColor.kwhite,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: AppUtils.buildNormalText(
                text: 'Apartment View',
                fontWeight: FontWeight.w600,
                color: AppColor.kwhite,
                fontSize: 18,
              ),
            ),
            SizedBox(
              width: AppBar().preferredSize.height + 40,
              height: AppBar().preferredSize.height,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(32.0),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WishList(
                                  wishlistIds: wishlist,
                                  wishlistApartments: hotelList
                                      .where((apt) =>
                                          wishlist.contains(apt.internalid))
                                      .toList())),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.favorite_border,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  // Material(
                  //   color: Colors.transparent,
                  //   child: InkWell(
                  //     borderRadius: const BorderRadius.all(
                  //       Radius.circular(32.0),
                  //     ),
                  //     onTap: () {},
                  //     child: Padding(
                  //       padding: const EdgeInsets.all(8.0),
                  //       child: Icon(
                  //         Icons.location_pin,
                  //         color: Colors.white,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  // void getapartmentlist() async {
  //   setState(() {
  //     loading = true;
  //   });
  //   Apiservice.viewapartment().then((response) {
  //     setState(() {
  //       loading = false;
  //     });
  //     if (response.statusCode == 200) {
  //       if (jsonDecode(response.body)['status'].toString() == "true") {
  //         hotelList.clear();
  //         hotelList = jsonDecode(response.body)['message']
  //             .map<ApartmentModel>((item) => ApartmentModel.fromJson(item))
  //             .toList();
  //         filteredOrders = hotelList;
  //       } else {
  //         hotelList.clear();
  //         AppUtils.showSingleDialogPopup(context,
  //             jsonDecode(response.body)['message'].toString(), "Ok", exitpopup);
  //       }
  //       //return response;
  //     } else {
  //       throw Exception(jsonDecode(response.body)['message'].toString());
  //     }
  //   }).catchError((e) {
  //     setState(() {
  //       loading = false;
  //     });
  //     AppUtils.showSingleDialogPopup(context, e.toString(), "Ok", exitpopup);
  //   });
  // }
void getapartmentlist() {
  setState(() {
    loading = true;
  });

  Future.delayed(const Duration(seconds: 1), () {
    setState(() {
      loading = false;

      // Local dummy data (instead of API)
  List<Map<String, dynamic>> apartments = [
  {
    "internalid": "01",
    "buildingname": "Akshaya",
    "propertylocationname": "Dubai",
    "propertylocationid": "1",
    "buildingtype": "flat",
    "maintenanceIncharge": "jenifer",
    "imageUrl": "",
  },
  {
    "internalid": "02",
    "buildingname": "Prestige",
    "propertylocationname": "Chennai",
    "propertylocationid": "2",
    "buildingtype": "villa",
    "maintenanceIncharge": "arun",
    "imageUrl": "",
  },
];

hotelList = apartments.map((e) => ApartmentModel.fromMap(e)).toList();
filteredOrders = hotelList;


    });
  });
}

  void exitpopup() {
    AppUtils.pop(context);
  }

  _filterItems(String query) {
    final lowerQuery = query.toString().toLowerCase();

    return query.isEmpty
        ? hotelList
        : hotelList.where((hotellist) {
            // Match main fields
            bool matchesMainFields = hotellist.internalid
                    .toString()
                    .toLowerCase()
                    .contains(lowerQuery) ||
                hotellist.buildingname
                    .toString()
                    .toLowerCase()
                    .contains(lowerQuery) ||
                hotellist.maintenanceIncharge
                    .toString()
                    .toLowerCase()
                    .contains(lowerQuery) ||
                hotellist.buildingtype
                    .toString()
                    .toLowerCase()
                    .contains(lowerQuery);

            // Match inside resourceAllocationList (if present)

            return matchesMainFields;
          }).toList();
  }
}

class ContestTabHeader extends SliverPersistentHeaderDelegate {
  ContestTabHeader(
    this.searchUI,
  );
  final Widget searchUI;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return searchUI;
  }

  @override
  double get maxExtent => 52.0;

  @override
  double get minExtent => 52.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

List<Map<String, dynamic>> apartments = [
  {
    "internalid": "01",
    "buildingname": "Akshaya",
    "propertylocationname": "Dubai",
    "propertylocationid": "1",
    "buildingtype": "flat",
    "maintenanceIncharge": "jenifer",
    "imageUrl": "",
  },
  {
    "internalid": "02",
    "buildingname": "Prestige",
    "propertylocationname": "Chennai",
    "propertylocationid": "2",
    "buildingtype": "villa",
    "maintenanceIncharge": "arun",
    "imageUrl": "",
  },
];


