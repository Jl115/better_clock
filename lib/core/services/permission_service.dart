import 'package:permission_handler/permission_handler.dart';

/// Singleton permission helper.
class PermissionService {
  static final PermissionService _instance = PermissionService._internal();
  factory PermissionService() => _instance;
  PermissionService._internal();

  Future<bool> requestNotifications() async {
    final status = await Permission.notification.request();
    return status.isGranted;
  }

  Future<bool> requestStorage() async {
    final status = await Permission.storage.request();
    return status.isGranted;
  }

  Future<bool> requestExactAlarm() async {
    final status = await Permission.scheduleExactAlarm.request();
    return status.isGranted;
  }
}
