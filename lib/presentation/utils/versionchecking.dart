import 'dart:convert';
import 'dart:io';
import 'package:dugasta/presentation/util/appcontants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class VersionCheckService {
  final String serverUrl =
      "${AppConstants.liveurl}api/mobileapp/tenant/getversioncheck"; // Replace with your server's URL

  Future<void> checkForUpdate(BuildContext context) async {
    try {
      // Fetch the latest app version from the server
      final response = await http.get(Uri.parse(serverUrl));
      if (response.statusCode == 200) {
        final serverVersion = json.decode(response.body)['version'];

        // Fetch the app's current installed version
        final packageInfo = await PackageInfo.fromPlatform();
        final currentVersion = packageInfo.version;

        // Compare versions
        if (_isUpdateAvailable(currentVersion, serverVersion)) {
          // _showUpdateDialog(context);
          // AppUtils.showSingleDialogPopup(
          //     context, "App Version is Available", "Update", _launchUpdateUrl);
          print('APP UPDATE AVIABLE');
        }
      }
    } catch (e) {
      print("Error checking for update: $e");
    }
  }

  bool _isUpdateAvailable(String currentVersion, String serverVersion) {
    final current = currentVersion.split('.').map(int.parse).toList();
    final latest = serverVersion.split('.').map(int.parse).toList();

    for (int i = 0; i < latest.length; i++) {
      if (i >= current.length || latest[i] > current[i]) {
        return true;
      } else if (latest[i] < current[i]) {
        return false;
      }
    }
    return false;
  }

  void _showUpdateDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Update Available"),
        content: const Text(
            "A newer version of the app is available. Please update to continue."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Later"),
          ),
          TextButton(
            onPressed: () => _launchUpdateUrl(),
            child: const Text("Update"),
          ),
        ],
      ),
    );
  }

  Future<void> _launchUpdateUrl() async {
    const appStoreUrl =
        "https://apps.apple.com/ae/app/sslootah-re/id6502507788"; // Replace with your App Store URL
    const playStoreUrl =
        "https://play.google.com/store/apps/details?id=com.nijatech.bindhaenre"; // Replace with your Play Store URL

    final url = Platform.isIOS ? appStoreUrl : playStoreUrl;

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print("Could not launch $url");
    }
  }
}
