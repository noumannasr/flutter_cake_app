import 'package:permission_handler/permission_handler.dart';

enum PermissionStatusEnum {
  granted,
  denied,
}

class PermissionHandler {
  static Future<void> requestNotificationPermission({
    required Function(PermissionStatusEnum status) notificationPermissionStatus,
  }) async {
    final permissionStatus = await Permission.notification.status;

    if (permissionStatus != PermissionStatus.granted) {
      final permissionRequestResult = await Permission.notification.request();

      if (permissionRequestResult == PermissionStatus.granted) {
        notificationPermissionStatus(PermissionStatusEnum.granted);
      } else {
        notificationPermissionStatus(PermissionStatusEnum.denied);
      }
    }
  }
}
