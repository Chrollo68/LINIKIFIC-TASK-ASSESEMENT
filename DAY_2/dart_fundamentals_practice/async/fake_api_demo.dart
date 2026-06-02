// Demonstrates a fake API call using Future.delayed and custom async logic.
// Run with: dart run async/fake_api_demo.dart

import 'dart:math';

Future<void> main() async {
  print('Starting fake API loader...');
  try {
    String result = await fetchUserTasks();
    print(result);
  } catch (error) {
    print('API error: $error');
  }
}

Future<String> fetchUserTasks() async {
  await Future.delayed(Duration(seconds: 1));
  bool networkAvailable = Random().nextBool();
  if (!networkAvailable) {
    throw 'Unable to contact the server.';
  }
  return 'Fake API tasks loaded successfully.';
}
