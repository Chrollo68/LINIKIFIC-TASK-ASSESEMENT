import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionScreen extends StatefulWidget {
  const PermissionScreen({super.key});

  @override
  State<PermissionScreen> createState() => _PermissionScreenState();
}

class _PermissionScreenState extends State<PermissionScreen> {
  String status = "No Permission Requested";

  Future<void> requestCamera() async {
    PermissionStatus result = await Permission.camera.request();

    if (result.isGranted) {
      setState(() {
        status = "Camera Permission Granted";
      });
    } else if (result.isDenied) {
      setState(() {
        status = "Camera Permission Denied";
      });
    } else if (result.isPermanentlyDenied) {
      setState(() {
        status = "Camera Permission Permanently Denied";
      });

      openAppSettings();
    }
  }

  Future<void> requestLocation() async {
    PermissionStatus result = await Permission.location.request();

    if (result.isGranted) {
      setState(() {
        status = "Location Permission Granted";
      });
    } else {
      setState(() {
        status = "Location Permission Denied";
      });
    }
  }

  Future<void> requestStorage() async {
    PermissionStatus result = await Permission.storage.request();

    if (result.isGranted) {
      setState(() {
        status = "Storage Permission Granted";
      });
    } else {
      setState(() {
        status = "Storage Permission Denied";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Permission Demo")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(status, style: const TextStyle(fontSize: 18)),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: requestCamera,
              child: const Text("Camera Permission"),
            ),

            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: requestLocation,
              child: const Text("Location Permission"),
            ),

            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: requestStorage,
              child: const Text("Storage Permission"),
            ),
          ],
        ),
      ),
    );
  }
}
