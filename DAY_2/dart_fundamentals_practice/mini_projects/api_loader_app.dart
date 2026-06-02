// Fake API loader console app using Future.delayed.
// Run with: dart run mini_projects/api_loader_app.dart

import 'dart:async';

void main() async {
  print('Loading dashboard data...');
  String response = await loadDashboardData();
  print(response);
}

Future<String> loadDashboardData() async {
  await Future.delayed(Duration(milliseconds: 600));
  return 'Dashboard data loaded successfully.';
}
