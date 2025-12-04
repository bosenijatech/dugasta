import 'dart:convert';

import 'package:dugasta/domain/pref.dart';
import 'package:dugasta/presentation/util/appcontants.dart';
import 'package:http/http.dart' as http;

import '../presentation/model/sales_categorymodel.dart';
import '../presentation/model/sales_faqmodel.dart';
import '../presentation/model/sales_profilemodel.dart';
import '../presentation/model/sales_projectmodel.dart';
import '../presentation/model/sales_subcategorymodel.dart';
import '../presentation/model/sales_typecasemodel.dart';
import '../presentation/model/sales_typemodel.dart';
import '../presentation/model/sales_unitnumbermodel.dart';

class Apiservice {
  static const int timeOutDuration = 35;
  String userid = Prefs.getUserName("UserName").toString();

  // static Future<http.Response> getlogin(
  //     String username, String password) async {
  //   var url = Uri.parse(AppConstants.liveurl + AppConstants.Login);
  //   Map<String, String> headers = {"Content-Type": "application/json"};

  //   var body = {"mobileusername": username, "mobilepassword": password};
  //   var response =
  //       await http.post(url, body: jsonEncode(body), headers: headers).timeout(
  //             const Duration(seconds: timeOutDuration),
  //           );
  //   return response;
  // }

//login

static Future<http.Response> getlogin(
    String username, String password) async {
  var url = Uri.parse(AppConstants.liveurl + AppConstants.Login);
  Map<String, String> headers = {"Content-Type": "application/json"};

  // Correct keys
  var body = {"username": username.trim(), "password": password.trim()};

  print("🔹 Request body: $body"); // Debug print

  var response = await http
      .post(url, body: jsonEncode(body), headers: headers)
      .timeout(const Duration(seconds: timeOutDuration));

  print("🔹 Response body: ${response.body}"); // Debug print
  return response;
}



  static Future<http.Response> getcontracts() async {
    var url = Uri.parse(AppConstants.liveurl + AppConstants.getcontractdetails);
    Map<String, String> headers = {"Content-Type": "application/json"};

    var body = {"customerId": Prefs.getCustomerId("CustomerID").toString()};
    var response =
        await http.post(url, body: jsonEncode(body), headers: headers).timeout(
              const Duration(seconds: timeOutDuration),
            );
    print(jsonEncode(body));
    return response;
  }

  //sales

static Future<http.Response> getsalescontracts() async {
  var url = Uri.parse(AppConstants.liveurl + AppConstants.getsalescontractdetails);

  // Get token from SharedPreferences
  String? token = Prefs.getToken("token"); // Make sure you have saved it during login

  Map<String, String> headers = {
    "Content-Type": "application/json",
    "Authorization": "Bearer $token", // <-- Add this
  };

  var body = {
    "customerId": Prefs.getCustomerId("CustomerID").toString(),
  };

  print("🔹 Request Body: ${jsonEncode(body)}");
  print("🔹 Headers: $headers"); // Debug headers

  var response = await http
      .post(url, body: jsonEncode(body), headers: headers)
      .timeout(const Duration(seconds: timeOutDuration));

  print("🔹 Response: ${response.body}"); // Debug response
  return response;
}

//Estimate
static Future<http.Response> getsalesestimate() async {
  var url = Uri.parse(AppConstants.liveurl + AppConstants.getsalesestimatedetails);

  // Get token from SharedPreferences
  String? token = Prefs.getToken("token"); // Make sure you have saved it during login

  Map<String, String> headers = {
    "Content-Type": "application/json",
    "Authorization": "Bearer $token", // <-- Add this
  };

  var body = {
    "customerId": Prefs.getCustomerId("CustomerID").toString(),
  };

  // print("🔹 Request Body: ${jsonEncode(body)}");
  // print("🔹 Headers: $headers"); // Debug headers

  var response = await http
      .post(url, body: jsonEncode(body), headers: headers)
      .timeout(const Duration(seconds: timeOutDuration));

  // print("🔹 Response: ${response.body}"); // Debug response
  return response;
}

//payment
static Future<http.Response> getsalespayment() async {
  var url = Uri.parse(AppConstants.liveurl + AppConstants.getsalespaymentdetails);

  // Get token from SharedPreferences
  String? token = Prefs.getToken("token"); // Make sure you have saved it during login

  Map<String, String> headers = {
    "Content-Type": "application/json",
    "Authorization": "Bearer $token", // <-- Add this
  };

  var body = {
    "customerId": Prefs.getCustomerId("CustomerID").toString(),
  };
  // var body = {
  //   "customerId":"6122",
  // };

  

  // print("🔹 Request Body: ${jsonEncode(body)}");
  // print("🔹 Headers: $headers"); // Debug headers

  var response = await http
      .post(url, body: jsonEncode(body), headers: headers)
      .timeout(const Duration(seconds: timeOutDuration));

  print("🔹 Response: ${response.body}"); // Debug response
  return response;
}

//reservation
static Future<http.Response> getsalesreservation() async {
  var url = Uri.parse(AppConstants.liveurl + AppConstants.getsalesreservation);

  // Get token from SharedPreferences
  String? token = Prefs.getToken("token"); // Make sure you have saved it during login

  Map<String, String> headers = {
    "Content-Type": "application/json",
    "Authorization": "Bearer $token", // <-- Add this
  };

  var body = {
    "customerId": Prefs.getCustomerId("CustomerID").toString(),
  };

  print("🔹 Request Body: ${jsonEncode(body)}");
  print("🔹 Headers: $headers"); // Debug headers

  var response = await http
      .post(url, body: jsonEncode(body), headers: headers)
      .timeout(const Duration(seconds: timeOutDuration));

  print("🔹 Response: ${response.body}"); // Debug response
  return response;
}

//faq

static Future<SalesfaqModel?> getSaleFaq() async {
    // ✅ Construct URL with query param (GET request)
    final customerId = Prefs.getCustomerId("CustomerID").toString();
    final url = Uri.parse(
      "${AppConstants.liveurl}${AppConstants.getsalesfaq}?customerId=$customerId",
    );

    // Token for authorization
    final token = Prefs.getToken("token");

    final headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    };

    print("🔹 Request URL: $url");
    print("🔹 Headers: $headers");

    try {
      // ✅ Use GET instead of POST
      final response = await http
          .get(url, headers: headers)
          .timeout(const Duration(seconds: timeOutDuration));

      print("🔹 Response (${response.statusCode}): ${response.body}");

      if (response.statusCode == 200) {
        return SalesfaqModel.fromJson(jsonDecode(response.body));
      } else {
        print("❌ Failed with status code: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("❌ Exception: $e");
      return null;
    }
  }


//mobileappgetcategory
static Future<MobileappgetcategoryModel?> mobileappgetcategory() async {
  final url = Uri.parse(
    "${AppConstants.liveurl}${AppConstants.mobileappgetcategory}",
  );

  final token = Prefs.getToken("token");

  final headers = {
    "Content-Type": "application/json",
    "Authorization": "Bearer $token",
  };

  print("🔹 Request URL: $url");
  print("🔹 Headers: $headers");

  try {
    final response = await http
        .get(url, headers: headers)
        .timeout(const Duration(seconds: timeOutDuration));

    print("🔹 Response (${response.statusCode}): ${response.body}");

    if (response.statusCode == 200) {
      return MobileappgetcategoryModel.fromJson(jsonDecode(response.body));
    } else {
      print("❌ Status Code: ${response.statusCode}");
      return null;
    }
  } catch (e) {
    print("❌ Exception: $e");
    return null;
  }
}


//getSubCategory
static Future<MobileappgetsubcategoryModel?> getSubCategory(
      String categoryId) async {
    final url = Uri.parse(
      "${AppConstants.liveurl}${AppConstants.mobileappgetsubcategory}?categoryId=$categoryId",
    );

    final token = Prefs.getToken("token");

    try {
      final response = await http.get(url, headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      });

      if (response.statusCode == 200) {
        return MobileappgetsubcategoryModel.fromJson(jsonDecode(response.body));
      }
      return null;
    } catch (e) {
      print("❌ SubCategory API Error: $e");
      return null;
    }
  }


//mobileappgettype
static Future<MobileappgetypeModel?> gettype() async {
  final url = Uri.parse("${AppConstants.liveurl}${AppConstants.getType}");

  final token = await Prefs.getToken("token"); // <-- FIXED: Added await

  final headers = {
    "Content-Type": "application/json",
    "Authorization": "Bearer $token",
  };

  print("🔹 Request URL: $url");
  print("🔹 Headers: $headers");

  try {
    final response = await http
        .get(url, headers: headers)
        .timeout(const Duration(seconds: timeOutDuration));

    print("🔹 Response (${response.statusCode}): ${response.body}");

    if (response.statusCode == 200) {
      try {
        return MobileappgetypeModel.fromJson(jsonDecode(response.body));
      } catch (e) {
        print("❌ JSON Parsing Error: $e");
        return null;
      }
    } else {
      print("❌ Status Code: ${response.statusCode}");
      return null;
    }
  } catch (e) {
    print("❌ Exception: $e");
    return null;
  }
}

//mobileappgettypecase
static Future<MobileappgetypecaseModel?> gettypecase() async {
  final url = Uri.parse("${AppConstants.liveurl}${AppConstants.getTypecase}");

  final token = await Prefs.getToken("token"); // <-- FIXED: Added await

  final headers = {
    "Content-Type": "application/json",
    "Authorization": "Bearer $token",
  };

  print("🔹 Request URL: $url");
  print("🔹 Headers: $headers");

  try {
    final response = await http
        .get(url, headers: headers)
        .timeout(const Duration(seconds: timeOutDuration));

    print("🔹 Response (${response.statusCode}): ${response.body}");

    if (response.statusCode == 200) {
      try {
        return MobileappgetypecaseModel.fromJson(jsonDecode(response.body));
      } catch (e) {
        print("❌ JSON Parsing Error: $e");
        return null;
      }
    } else {
      print("❌ Status Code: ${response.statusCode}");
      return null;
    }
  } catch (e) {
    print("❌ Exception: $e");
    return null;
  }
}


//unitnumber
static Future<MobileappgetunitnumberModel?> getunitnum() async {
    // ✅ Construct URL with query param (GET request)
    final customerId = Prefs.getCustomerId("CustomerID").toString();
    final url = Uri.parse(
      "${AppConstants.liveurl}${AppConstants.getUnitnumber}?customerId=$customerId",
    );

    // Token for authorization
    final token = Prefs.getToken("token");

    final headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    };

    print("🔹 Request URL: $url");
    print("🔹 Headers: $headers");

    try {
      // ✅ Use GET instead of POST
      final response = await http
          .get(url, headers: headers)
          .timeout(const Duration(seconds: timeOutDuration));

      print("🔹 Response (${response.statusCode}): ${response.body}");

      if (response.statusCode == 200) {
        return MobileappgetunitnumberModel.fromJson(jsonDecode(response.body));
      } else {
        print("❌ Failed with status code: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("❌ Exception: $e");
      return null;
    }
  }
//project
  static Future<MobileappgetprojectModel?> getProject(
      String unitId) async {
    final url = Uri.parse(
      "${AppConstants.liveurl}${AppConstants.getproject}?unitId=$unitId",
    );

    final token = Prefs.getToken("token");

    try {
      final response = await http.get(url, headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      });

      if (response.statusCode == 200) {
        return MobileappgetprojectModel.fromJson(jsonDecode(response.body));
      }
      return null;
    } catch (e) {
      print("❌ Project API Error: $e");
      return null;
    }
  }

//netsuitepostcaseForm
  static Future<http.Response> netsuitepostcaseForm(dynamic json) async {
    var url = Uri.parse(AppConstants.liveurl + AppConstants.netsuiteform);
    Map<String, String> headers = {"Content-Type": "application/json"};
    var response = await http
        .post(
          url,
          body: jsonEncode(json),
          headers: headers,
        )
        .timeout(
          const Duration(seconds: timeOutDuration),
        );

    return response;
  }



//profile
static Future<SalesprofileModel?> getsalesProfile() async {
    // ✅ Construct URL with query param (GET request)
    final customerId = Prefs.getCustomerId("CustomerID").toString();
    final url = Uri.parse(
      "${AppConstants.liveurl}${AppConstants.getsalesprofile}?customerId=$customerId",
    );

    // Token for authorization
    final token = Prefs.getToken("token");

    final headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    };

    print("🔹 Request URL: $url");
    print("🔹 Headers: $headers");

    try {
      // ✅ Use GET instead of POST
      final response = await http
          .get(url, headers: headers)
          .timeout(const Duration(seconds: timeOutDuration));

      print("🔹 Response (${response.statusCode}): ${response.body}");

      if (response.statusCode == 200) {
        return SalesprofileModel.fromJson(jsonDecode(response.body));
      } else {
        print("❌ Failed with status code: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("❌ Exception: $e");
      return null;
    }
  }


  static Future<http.Response> getnoncontracts() async {
    var url =
        Uri.parse(AppConstants.liveurl + AppConstants.getnoncontractdetails);
    Map<String, String> headers = {"Content-Type": "application/json"};

    var body = {"customerId": Prefs.getCustomerId("CustomerID").toString()};
    var response =
        await http.post(url, body: jsonEncode(body), headers: headers).timeout(
              const Duration(seconds: timeOutDuration),
            );
    print(jsonEncode(body));
    return response;
  }

  static Future<http.Response> getrequesttypemaster(dynamic body) async {
    var url =
        Uri.parse(AppConstants.liveurl + AppConstants.getrequesttypemaster);
    Map<String, String> headers = {"Content-Type": "application/json"};

    //var body = {"tenantid": Prefs.getTenentID("UserID")};
    var response =
        await http.post(url, headers: headers, body: jsonEncode(body)).timeout(
              const Duration(seconds: timeOutDuration),
            );
    // print(jsonEncode(response));
    return response;
  }

  static Future<http.Response> getcategorymaster(String headerid) async {
    var url = Uri.parse(AppConstants.liveurl + AppConstants.getcategorymaster);
    Map<String, String> headers = {"Content-Type": "application/json"};

    var body = {
      "tenantid": Prefs.getTenentID("UserID"),
      "headerid": headerid != "null" ? int.parse(headerid) : 0
    };
    var response =
        await http.post(url, body: jsonEncode(body), headers: headers).timeout(
              const Duration(seconds: timeOutDuration),
            );
    print(jsonEncode(body));
    return response;
  }

  static Future<http.Response> getmaincategorymaster() async {
    var url = Uri.parse(AppConstants.liveurl + AppConstants.getmaincatmaster);
    Map<String, String> headers = {"Content-Type": "application/json"};

    //var body = {"tenantid": Prefs.getTenentID("UserID")};
    var response = await http.get(url, headers: headers).timeout(
          const Duration(seconds: timeOutDuration),
        );
    // print(jsonEncode(response));
    return response;
  }

  static Future<http.Response> getsubcategorymaster(
      String headerid, String categoryid) async {
    var url =
        Uri.parse(AppConstants.liveurl + AppConstants.getsubcategorymaster);
    Map<String, String> headers = {"Content-Type": "application/json"};

    var body = {
      "tenantid": Prefs.getTenentID("UserID"),
      "headerid": int.parse(headerid),
      "cm_headerid": int.parse(categoryid)
    };
    var response =
        await http.post(url, body: jsonEncode(body), headers: headers).timeout(
              const Duration(seconds: timeOutDuration),
            );
    // print(jsonEncode(response));
    return response;
  }

  static Future<http.Response> postrequest(dynamic json) async {
    var url = Uri.parse(AppConstants.liveurl + AppConstants.postrequest);
    Map<String, String> headers = {"Content-Type": "application/json"};

    //var body = {"username": username, "userpassword": password};
    var response =
        await http.post(url, body: jsonEncode(json), headers: headers).timeout(
              const Duration(seconds: timeOutDuration),
            );
    print(jsonEncode(json));
    return response;
  }

  static Future<http.Response> getviewservicelist() async {
    var url = Uri.parse(AppConstants.liveurl + AppConstants.viewrequest);
    Map<String, String> headers = {"Content-Type": "application/json"};

    var body = {
      "tenantid": Prefs.getTenentID("CustomerID"),
    };
    var response =
        await http.post(url, body: jsonEncode(body), headers: headers).timeout(
              const Duration(seconds: timeOutDuration),
            );
    // print(jsonEncode(response));
    return response;
  }

  static Future<http.Response> getchequelist() async {
    var url = Uri.parse(AppConstants.liveurl + AppConstants.viewcheque);
    Map<String, String> headers = {"Content-Type": "application/json"};

    var body = {
      "customerId": Prefs.getCustomerId("CustomerID"),
    };
    var response =
        await http.post(url, body: jsonEncode(body), headers: headers).timeout(
              const Duration(seconds: timeOutDuration),
            );
    print(jsonEncode(body));
    return response;
  }

  static Future<http.Response> getpdcchequelist() async {
    var url = Uri.parse(AppConstants.liveurl + AppConstants.viewpdcchequelist);
    Map<String, String> headers = {"Content-Type": "application/json"};

    var body = {
      "customerId": Prefs.getCustomerId("CustomerID"),
    };
    var response =
        await http.post(url, body: jsonEncode(body), headers: headers).timeout(
              const Duration(seconds: timeOutDuration),
            );
    print(jsonEncode(body));
    return response;
  }

  static Future<http.Response> getfaqlist() async {
    var url = Uri.parse(AppConstants.liveurl + AppConstants.getfaqmaster);
    Map<String, String> headers = {"Content-Type": "application/json"};

    var body = {
      // "tenantid": Prefs.getTenentID("UserID"),
    };
    var response = await http.get(url, headers: headers).timeout(
          const Duration(seconds: timeOutDuration),
        );
    // print(jsonEncode(response));
    return response;
  }

  static Future<http.Response> generateotp() async {
    var url = Uri.parse(AppConstants.liveurl + AppConstants.generateotp);
    Map<String, String> headers = {"Content-Type": "application/json"};

    var body = {
      "countrycode": Prefs.getCounrtryCode("Countrycode"),
      "mobilenumber": Prefs.getMobileNo("MobileNo"),
      "email": Prefs.getEmail("Email")
    };
    var response =
        await http.post(url, body: jsonEncode(body), headers: headers).timeout(
              const Duration(seconds: timeOutDuration),
            );

    return response;
  }

  static Future<http.Response> checkotp(dynamic json) async {
    var url = Uri.parse(AppConstants.liveurl + AppConstants.checkotp);
    Map<String, String> headers = {"Content-Type": "application/json"};

    var response = await http
        .post(
          url,
          body: jsonEncode(json),
          headers: headers,
        )
        .timeout(
          const Duration(seconds: timeOutDuration),
        );

    return response;
  }

  static Future<http.Response> registerpage(dynamic json) async {
    var url = Uri.parse(AppConstants.liveurl + AppConstants.registerpage);
    Map<String, String> headers = {"Content-Type": "application/json"};

    var response = await http
        .post(
          url,
          body: jsonEncode(json),
          headers: headers,
        )
        .timeout(
          const Duration(seconds: timeOutDuration),
        );

    print(jsonEncode(json));
    return response;
  }

  static Future<http.Response> getprofileage() async {
    var url = Uri.parse(AppConstants.liveurl + AppConstants.profilepage);
    Map<String, String> headers = {"Content-Type": "application/json"};

    var body = {
      "_id": Prefs.getId("Id"),
    };
    var response = await http
        .post(
          url,
          body: jsonEncode(body),
          headers: headers,
        )
        .timeout(
          const Duration(seconds: timeOutDuration),
        );
    print(jsonEncode(body));
    return response;
  }

  static Future<http.Response> updateprofilepage(dynamic json) async {
    var url = Uri.parse(AppConstants.liveurl + AppConstants.updateprofilepage);
    Map<String, String> headers = {"Content-Type": "application/json"};
    var response = await http
        .post(
          url,
          body: jsonEncode(json),
          headers: headers,
        )
        .timeout(
          const Duration(seconds: timeOutDuration),
        );
    print(jsonEncode(json));
    return response;
  }

  static Future<http.Response> postenquiry(dynamic json) async {
    var url = Uri.parse(AppConstants.liveurl + AppConstants.postenquiry);
    Map<String, String> headers = {"Content-Type": "application/json"};
    var response = await http
        .post(
          url,
          body: jsonEncode(json),
          headers: headers,
        )
        .timeout(
          const Duration(seconds: timeOutDuration),
        );

    return response;
  }

  static Future<http.Response> getfeedbacklist() async {
    var url = Uri.parse(AppConstants.liveurl + AppConstants.getfeedback);
    Map<String, String> headers = {"Content-Type": "application/json"};
    var response = await http
        .get(
          url,
          headers: headers,
        )
        .timeout(
          const Duration(seconds: timeOutDuration),
        );
    return response;
  }

  static Future<http.Response> getSuggestionlist() async {
    var url = Uri.parse(AppConstants.liveurl + AppConstants.getSuggestion);
    Map<String, String> headers = {"Content-Type": "application/json"};
    var response = await http
        .get(
          url,
          headers: headers,
        )
        .timeout(
          const Duration(seconds: timeOutDuration),
        );
    return response;
  }
  static Future<http.Response> getLevellist() async {
    var url = Uri.parse(AppConstants.liveurl + AppConstants.getLevel);
    Map<String, String> headers = {"Content-Type": "application/json"};
    var response = await http
        .get(
          url,
          headers: headers,
        )
        .timeout(
          const Duration(seconds: timeOutDuration),
        );
    return response;
  }

  static Future<http.Response> netsuiteFeedback(dynamic json) async {
    var url = Uri.parse(AppConstants.liveurl + AppConstants.netsuiteFeedback);
    Map<String, String> headers = {"Content-Type": "application/json"};
    var response = await http
        .post(
          url,
          body: jsonEncode(json),
          headers: headers,
        )
        .timeout(
          const Duration(seconds: timeOutDuration),
        );
    print(jsonEncode(json));
    return response;
  }

  static Future<http.Response> postfeedbacktransaction(dynamic json) async {
    var url = Uri.parse(AppConstants.liveurl + AppConstants.addfeedback);
    Map<String, String> headers = {"Content-Type": "application/json"};
    var response = await http
        .post(
          url,
          body: jsonEncode(json),
          headers: headers,
        )
        .timeout(
          const Duration(seconds: timeOutDuration),
        );
    print(jsonEncode(json));
    return response;
  }

  static Future<http.Response> postverifyotp(String otpnumber) async {
    var url = Uri.parse(AppConstants.liveurl + AppConstants.verifyotp);
    Map<String, String> headers = {"Content-Type": "application/json"};

    var body = {"email": Prefs.getEmail("Email").toString(), "otp": otpnumber};
    var response = await http
        .post(
          url,
          body: jsonEncode(body),
          headers: headers,
        )
        .timeout(
          const Duration(seconds: timeOutDuration),
        );
    return response;
  }

  static Future<http.Response> viewapartment() async {
    var url = Uri.parse(AppConstants.liveurl + AppConstants.viewapartment);
    Map<String, String> headers = {"Content-Type": "application/json"};

    var body = {};
    var response = await http
        .post(
          url,
          body: jsonEncode(body),
          headers: headers,
        )
        .timeout(
          const Duration(seconds: timeOutDuration),
        );
    return response;
  }

  static Future<http.Response> getbuildinglist() async {
    var url = Uri.parse(AppConstants.liveurl + AppConstants.viewbuildinglist);
    Map<String, String> headers = {"Content-Type": "application/json"};

    var body = {};
    var response = await http
        .get(
          url,
          headers: headers,
        )
        .timeout(
          const Duration(seconds: timeOutDuration),
        );
    return response;
  }

  static Future<http.Response> postimages(filetype, filename, base64) async {
    var url =
        Uri.parse(AppConstants.liveurl + AppConstants.uploadimagetonetsuite);
    Map<String, String> headers = {"Content-Type": "application/json"};

    var body = {"mimetype": filetype, "filename": filename, "filedata": base64};
    var response =
        await http.post(url, headers: headers, body: jsonEncode(body)).timeout(
              const Duration(seconds: timeOutDuration),
            );
    //log(jsonEncode(body));
    return response;
  }

  static Future<http.Response> loginupdate() async {
    var url = Uri.parse(AppConstants.liveurl + AppConstants.manageloginupdate);
    Map<String, String> headers = {"Content-Type": "application/json"};
    var body = {"customerId": Prefs.getCustomerId('CustomerID')};
    var response =
        await http.post(url, headers: headers, body: jsonEncode(body)).timeout(
              const Duration(seconds: timeOutDuration),
            );
    return response;
  }

  static Future<http.Response> passwordupdate(dynamic json) async {
    var url = Uri.parse(AppConstants.liveurl + AppConstants.updatepassword);
    Map<String, String> headers = {"Content-Type": "application/json"};
    // var body = {"email": Prefs.getCustomerId('CustomerID')};
    var response =
        await http.post(url, headers: headers, body: jsonEncode(json)).timeout(
              const Duration(seconds: timeOutDuration),
            );
    return response;
  }

  static Future<http.Response> sendforgeotpassword(String emailid) async {
    var url = Uri.parse(AppConstants.liveurl + AppConstants.forgetpassword);
    Map<String, String> headers = {"Content-Type": "application/json"};
    var body = {"tenant_email": emailid};

    var response =
        await http.post(url, headers: headers, body: jsonEncode(body)).timeout(
              const Duration(seconds: timeOutDuration),
            );
    return response;
  }

  static Future<http.Response> getnotificationmaster() async {
    var url = Uri.parse(AppConstants.liveurl + AppConstants.notificationmaster);
    Map<String, String> headers = {"Content-Type": "application/json"};
    var body = {"customerId": Prefs.getCustomerId('CustomerID')};
    var response =
        await http.post(url, headers: headers, body: jsonEncode(body)).timeout(
              const Duration(seconds: timeOutDuration),
            );
    //print(jsonEncode(body));
    return response;
  }

  static Future<http.Response> tokenupdate() async {
    var url = Uri.parse(AppConstants.liveurl + AppConstants.tokenupdatemaster);
    Map<String, String> headers = {"Content-Type": "application/json"};
    var body = {
      "customerId": Prefs.getCustomerId("CustomerID"),
      "firebaseToken": Prefs.getFirebaseToken('FirebaseToken'.toString())
    };
    var response =
        await http.post(url, headers: headers, body: jsonEncode(body)).timeout(
              const Duration(seconds: timeOutDuration),
            );
    // print(jsonEncode(body));
    return response;
  }
}
