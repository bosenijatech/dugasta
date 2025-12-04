import 'dart:convert';

class WishListItem {
  int? id;
  String? imagePath;
  String? titleTxt;
  String? subTxt;
  double? dist;
  double? rating;
  WishListItem(
      {required this.id,
      required this.imagePath,
      required this.titleTxt,
      required this.subTxt,
      required this.dist,
      required this.rating});

  // Convert WishListItem to Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'imagePath': imagePath,
      'titleTxt': titleTxt,
      'subTxt': subTxt,
      'dist': dist,
      "rating": rating
    };
  }

  // Convert Map to WishListItem
  factory WishListItem.fromMap(Map<String, dynamic> map) {
    return WishListItem(
      id: map['id'],
      imagePath: map['imagePath'],
      titleTxt: map['titleTxt'],
      subTxt: map['subTxt'],
      dist: map['dist'],
      rating: map['rating'],
    );
  }

  // Convert WishListItem to JSON
  String toJson() => json.encode(toMap());

  // Convert JSON to WishListItem
  factory WishListItem.fromJson(String source) =>
      WishListItem.fromMap(json.decode(source));
}
