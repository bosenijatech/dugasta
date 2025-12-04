import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  static SharedPreferences? _prefs;

  static Future<SharedPreferences> init() async {
    _prefs = await SharedPreferences.getInstance();
    return _prefs!;
  }

  //sets
  static Future<bool> setId(String key, String value) async =>
      await _prefs!.setString(key, value);

  static Future<bool> setTenantId(String key, String value) async =>
      await _prefs!.setString(key, value);

  static Future<bool> setUserName(String key, String value) async =>
      await _prefs!.setString(key, value);
  static Future<bool> setcompanyName(String key, String value) async =>
      await _prefs!.setString(key, value);
  static Future<bool> setName(String key, String value) async =>
      await _prefs!.setString(key, value);



  static Future<bool> setTenentID(String key, String value) async =>
      await _prefs!.setString(key, value);

  static Future<bool> setFirstName(String key, String value) async =>
      await _prefs!.setString(key, value);

  static Future<bool> setTenentInternalID(String key, String value) async =>
      await _prefs!.setString(key, value);

  static Future<bool> setLoggedIn(String key, bool value) async =>
      await _prefs!.setBool(key, value);

  static Future<bool> setMobileNo(String key, String value) async =>
      await _prefs!.setString(key, value);

  static Future<bool> setCountryCode(String key, String value) async =>
      await _prefs!.setString(key, value);

  static Future<bool> setEmail(String key, String value) async =>
      await _prefs!.setString(key, value);

  static Future<bool> setEmiratesNo(String key, String value) async =>
      await _prefs!.setString(key, value);
  static Future<bool> setEmiratsExpDate(String key, String value) async =>
      await _prefs!.setString(key, value);
  static Future<bool> setPassportNo(String key, String value) async =>
      await _prefs!.setString(key, value);

  static Future<bool> setPassportExpDate(String key, String value) async =>
      await _prefs!.setString(key, value);

  static Future<bool> setActive(String key, String value) async =>
      await _prefs!.setString(key, value);

  static Future<bool> setCustomerId(String key, String value) async =>
      await _prefs!.setString(key, value);

  static Future<bool> setRole(String key, String value) async =>
      await _prefs!.setString(key, value);

  static Future<bool> setSubSidiary(String key, String value) async =>
      await _prefs!.setString(key, value);

  static Future<bool> setSeenFirstTime(String key, bool value) async =>
      await _prefs!.setBool(key, value);

  static Future<bool> setincharge(String key, String value) async =>
      await _prefs!.setString(key, value);

  static Future<bool> setFirebaseToken(String key, String value) async =>
      await _prefs!.setString(key, value);

 static Future<bool> setToken(String key, String value) async =>
    await _prefs!.setString(key, value);


  static Future<bool> setCustomerName(String key, String value) async =>
      await _prefs!.setString(key, value);
  //await Prefs.setTenantId("TenantId", model.message!.tenantid.toString());

  //getsuserName
  static bool? getLoggedIn(String key) => _prefs!.getBool(key);
  static String? getId(String key) => _prefs!.getString(key);
  static String? getUserName(String key) => _prefs!.getString(key);
  static String? getcompanyName(String key) => _prefs!.getString(key);
  static String? getTenantID(String key) => _prefs!.getString(key);
  static String? getName(String key) => _prefs!.getString(key);
  static String? getTenentID(String key) => _prefs!.getString(key);
  static String? getTenentInternalID(String key) => _prefs!.getString(key);

  static String? getCenterName(String key) => _prefs!.getString(key);
  static String? getMobileNo(String key) => _prefs!.getString(key);
  static String? getCounrtryCode(String key) => _prefs!.getString(key);
  static String? getEmail(String key) => _prefs!.getString(key);
  static String? getEmiratesNo(String key) => _prefs!.getString(key);
  static String? getEmiratesExpDate(String key) => _prefs!.getString(key);
  static String? getPassPortNo(String key) => _prefs!.getString(key);
  static String? getPassPortExpDate(String key) => _prefs!.getString(key);
  static String? getActive(String key) => _prefs!.getString(key);
  static String? getFirstName(String key) => _prefs!.getString(key);
  static String? getCustomerId(String key) => _prefs!.getString(key);
  static String? getRole(String key) => _prefs!.getString(key);
  static String? getSubsidiary(String key) => _prefs!.getString(key);
  static bool? getSeenFirstTime(String key) => _prefs!.getBool(key);
  static String? getIncharge(String key) => _prefs!.getString(key);
  static String? getFirebaseToken(String key) => _prefs!.getString(key);
  static String? getToken(String key) => _prefs!.getString(key);
  static String? getCustomerName(String key) => _prefs!.getString(key);
  //deletes..
  static Future<bool> remove(String key) async => await _prefs!.remove(key);

  static Future<bool> clear() async => await _prefs!.clear();
}
