import 'package:intl/intl.dart';

class AppConstants {
  //static const String LIVE_URL = 'http://192.168.0.102:4001/';

  static const String androidAppPackageName = "com.nijatech.bindhaenre";
  static const String iOSAppID = "6746790165";

  static const String liveurl = 'https://mobapp.nijatech.com:5604/';
  static const String attachmentURL = 'https://11290313.app.netsuite.com';
  static const String SESSIONTOKEN = 'Token';
  static const String SESSIONLOGGEDIN = "LoggedIn";
  // static const String Login = 'api/mobileapp/tenant/login';
  static const String Login = 'customer/mobileappcustomerlogin';

  static const String getcontractdetails = 'api/mobileapp/tenant/getcontract';
  static const String getsalescontractdetails = 'customer/mobileappgetcontract';
  static const String getsalesestimatedetails = 'customer/mobileappgetestimate';
  static const String getsalespaymentdetails = 'customer/mobileappgetpaymentdetails';
  static const String getsalesreservation = 'customer/mobileappgetreservation';
  static const String getsalesfaq = 'customer/mobileappgetFaq';
  static const String getsalesprofile = 'customer/mobileappgetCustomerProfile';
  static const String mobileappgetcategory = 'customer/mobileappgetcategory';
  static const String mobileappgetsubcategory = 'customer/mobileappgetsubcategory';
  static const String getType = 'customer/mobileappgetType';
  static const String getTypecase = 'customer/mobileappgetCaseType';
  static const String getUnitnumber = 'customer/mobileappgetUnit';
  static const String getproject = 'customer/mobileappgetproject';
  static const String netsuiteform = 'customer/netsuitepostcaseForm';
  // static const String getsalesprofile = 'customer/mobileappgetCustomerProfile';
  static const String getnoncontractdetails =
      'api/mobileapp/tenant/getnoncontract';

  static const String getrequesttypemaster =
      'api/mobileapp/tenant/getsubcategory';
  static const String getmaincatmaster = 'api/mobileapp/tenant/getmaincategory';

  static const String getcategorymaster =
      'api/mobileapp/tenant/getcategorymaster';

  static const String getmaincategorymaster =
      'api/mobileapp/tenant/getmaincategorymaster';

  static const String getsubcategorymaster =
      'api/mobileapp/tenant/getsubcategorymaster';

  // static const String postrequest = 'api/mobileapp/tenant/addservicereq';

  static const String postrequest =
      'api/mobileapp/tenant/addservicereqfrommobile';

  static const String viewrequest = 'api/mobileapp/tenant/getservicereqlist';
  //static const String viewcheque = 'api/mobileapp/tenant/getchequedetails';
  static const String viewcheque = 'api/mobileapp/tenant/viewreceipts';
  static const String getfaqmaster = 'api/mobileapp/tenant/getfaqquestions';
  static const String generateotp = 'api/mobileapp/generateotp';
  static const String checkotp = 'api/mobileapp/checkotp';
  static const String registerpage = 'api/mobileapp/tenant/register';
  static const String profilepage = 'api/mobileapp/tenant/getprofiledata';
  static const String getSuggestion = 'customer/mobileappFeedbackGetSuggestion';
  static const String getLevel = 'customer/mobileappFeedbackGetLevel';
  static const String netsuiteFeedback = 'customer/netsuitepostFeedback';
  static const String updateprofilepage = 'api/mobileapp/tenant/profileupdate';
  static const String postenquiry = 'api/mobileapp/tenant/addenquiry';
  static const String getfeedback = 'api/mobileapp/tenant/viewlistfeedback';
  static const String addfeedback =
      'api/mobileapp/tenant/addfeedbacktransaction';

  static const String uploadimage = 'api/mobileapp/upload';
  static const String verifyotp = 'api/mobileapp/tenant/verifyotp';
  static const String viewapartment = 'api/mobileapp/tenant/viewapartment';
  static const String viewpdcchequelist =
      'api/mobileapp/tenant/viewpdcreceipts';

  static const String uploadimagetonetsuite =
      "api/mobileapp/tenant/uploadimagetonetsuite";

  static const String viewbuildinglist = 'api/mobileapp/tenant/getbuildinglist';

  static const String manageloginupdate =
      "api/mobileapp/tenant/manageloginupdate";

  static const String updatepassword = "api/mobileapp/tenant/updatepassword";
  static const String forgetpassword = "api/mobileapp/sendmail";
  static const String notificationmaster =
      "api/mobileapp/tenant/getnotification";

  static const String apartmentabout =
      "Multi-unit: Contains multiple residential units, each usually on a single level.Independent facilities: Each unit has its own cooking and bathroom facilities.\n Various structures: Can be low-rise, mid-rise, or high-rise buildings.\n Shared amenities: May offer shared amenities like laundry rooms, gyms, and pools, depending on the complex.";
  static const String tokenupdatemaster = "api/mobileapp/tenant/updatetoken";

  static changeddmmyyformat(datetime) {
    return DateFormat("dd-MM-yyyy").format(DateTime.parse(datetime));
  }

  static List<String> iconname = [
    // 'ic_contracts.svg',
    // 'ic_cheque.svg',
    // 'ic_settings.svg',
    // 'ic_apartments.svg',
    // 'ic_faq.svg',
    // 'ic_news.svg',
    // 'ic_statement.svg',
    "contracts.png"
"payment.png"
"service.png"
"partment.png"
"FAQ.png"
"statement.png"
  ];

  static List<String> names = [
    'Your Contracts',
    'Payment Details',
    'Service Request',
    'Apartment List',
    'FAQ',

    'Statement',
        'Appointment',
  ];

  static List<String> accountdashiconname = [
    'ic_statement.svg',
    'ic_statement.svg',
    'ic_statement.svg',
    'ic_statement.svg',
    'ic_statement.svg',
    'ic_statement.svg',
  ];
  static List<String> accountdashname = [
    'Account Statement',
    'Cheque Details',
    'Standing Instruction',
    'Security Deposit',
    'Appointment',
    'Statement'
    
  ];

  static List<String> tenantnames = ['Apartment List', 'FAQ'];

  static List<String> tenanticonname = [
    'ic_apartments.svg',
    'ic_faq.svg',
    // 'ic_news.svg',
  ];
  static List<String> salesnames = ['Contract', 'Estimate',   "Reservation", "Payment" ,"Faq"];

  static List<String> salesiconname = [
    'ic_apartments.svg',
    'ic_faq.svg',
    'ic_faq.svg',
    // 'ic_news.svg',
  ];

  // static List apartmentListimages = [
  //   Image.asset('assets/images/one.jpg'),
  //   Image.asset('assets/images/two.jpg'),
  //   // Image.asset('assets/images/three.jpg'),
  //   // Image.asset('assets/images/four.jpg'),
  //   // Image.asset('assets/images/five.jpg'),
  //   // Image.asset('assets/images/six.jpg'),
  //   // Image.asset('assets/images/seven.jpg'),
  //   // Image.asset('assets/images/eight.jpg'),
  //   // Image.asset('assets/images/nine.jpg'),
  //   // Image.asset('assets/images/ten.jpg')
  // ];

  static String getFileTypeExtension(String fileName) {
    return ".${fileName.split('.').last}".toLowerCase();
  }

  static List<String> apartmentListimages = [
    'assets/images/one.jpg',
    'assets/images/two.jpg',
    'assets/images/three.jpg',
    'assets/images/four.jpg',
    'assets/images/five.jpg',
    'assets/images/six.jpg',
    'assets/images/seven.jpg',
    'assets/images/eight.jpg',
    'assets/images/nine.jpg',
    'assets/images/ten.jpg'
  ];
}
