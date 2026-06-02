// Demonstrates Dart Future and delayed execution.
// Run with: dart run async/future_demo.dart

import 'dart:async';

void main() {
  print('Fetching data...');
  Future<String> futureData = fetchData();

  futureData
      .then((result) {
        print(result);
      })
      .catchError((error) {
        print('Error: $error');
      })
      .whenComplete(() {
        print('Future processing complete.');
      });
}

Future<String> fetchData() {
  return Future.delayed(Duration(seconds: 1), () => 'Data loaded successfully');
}
