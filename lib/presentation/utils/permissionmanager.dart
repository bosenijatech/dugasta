import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionManager {
  // Singleton instance
  static final PermissionManager _instance = PermissionManager._internal();

  // Private constructor
  PermissionManager._internal();

  // Factory constructor
  factory PermissionManager() => _instance;

  // Camera permission check with UI explanation if needed
  Future<bool> checkAndRequestCameraPermission(BuildContext context) async {
    final status = await Permission.camera.status;

    if (status.isGranted) {
      return true;
    }

    // Request permission
    final result = await Permission.camera.request();

    if (result.isGranted) {
      return true;
    } else if (result.isPermanentlyDenied || result.isDenied) {
      _showPermissionDialog(context);
    }

    return false;
  }

  // Show explanation dialog (only when needed)
  void _showPermissionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Camera Permission Required'),
        content: const Text(
          'To use this feature, please allow camera access from Settings.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              openAppSettings(); // user-initiated
              Navigator.of(context).pop();
            },
            child: const Text('Open Settings'),
          ),
        ],
      ),
    );
  }
}
