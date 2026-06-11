import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  Future<PermissionStatus> cameraStatus() async {
    return await Permission.camera.status;
  }

  Future<void> requestCamera() async {
    await Permission.camera.request();
  }

  Future<void> requestLocation() async {
    await Permission.location.request();
  }

  Future<void> requestStorage() async {
    await Permission.storage.request();
  }

  Future<void> openAppSettingsPage() async {
    await openAppSettings();
  }
}
