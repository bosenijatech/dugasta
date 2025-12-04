// class ApartmentModel {
//   String? internalid;
//   String? buildingname;
//   String? propertylocationname;
//   String? propertylocationid;
//   String? buildingtype;
//   String? maintenanceIncharge;
//   String? imageUrl;

//   ApartmentModel(
//       {required this.internalid,
//       required this.buildingname,
//       required this.propertylocationname,
//       required this.propertylocationid,
//       required this.buildingtype,
//       required this.imageUrl,
//       required this.maintenanceIncharge});

//   factory ApartmentModel.fromJson(Map<String, dynamic> json) {
//     return ApartmentModel(
//         internalid: json["internalid"],
//         buildingname: json["buildingname"],
//         propertylocationname: json["propertylocationname"],
//         propertylocationid: json["propertylocationid"],
//         buildingtype: json["buildingtype"],
//         imageUrl: json["imageUrl"],
//         maintenanceIncharge: json["maintenanceIncharge"]);
//   }

//   static fromMap(Map<String, dynamic> e) {}
// }

class ApartmentModel {
  final String? internalid;
  final String? buildingname;
  final String? propertylocationname;
  final String? propertylocationid;
  final String? buildingtype;
  final String? maintenanceIncharge;
  final String? imageUrl;

  ApartmentModel({
    this.internalid,
    this.buildingname,
    this.propertylocationname,
    this.propertylocationid,
    this.buildingtype,
    this.imageUrl,
    this.maintenanceIncharge,
  });

  factory ApartmentModel.fromJson(Map<String, dynamic> json) {
    return ApartmentModel(
      internalid: json["internalid"]?.toString(),
      buildingname: json["buildingname"]?.toString(),
      propertylocationname: json["propertylocationname"]?.toString(),
      propertylocationid: json["propertylocationid"]?.toString(),
      buildingtype: json["buildingtype"]?.toString(),
      imageUrl: json["imageUrl"]?.toString(),
      maintenanceIncharge: json["maintenanceIncharge"]?.toString(),
    );
  }

  factory ApartmentModel.fromMap(Map<String, dynamic> map) {
    return ApartmentModel(
      internalid: map["internalid"]?.toString(),
      buildingname: map["buildingname"]?.toString(),
      propertylocationname: map["propertylocationname"]?.toString(),
      propertylocationid: map["propertylocationid"]?.toString(),
      buildingtype: map["buildingtype"]?.toString(),
      imageUrl: map["imageUrl"]?.toString(),
      maintenanceIncharge: map["maintenanceIncharge"]?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "internalid": internalid,
      "buildingname": buildingname,
      "propertylocationname": propertylocationname,
      "propertylocationid": propertylocationid,
      "buildingtype": buildingtype,
      "imageUrl": imageUrl,
      "maintenanceIncharge": maintenanceIncharge,
    };
  }
}
