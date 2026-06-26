import 'package:get/get.dart';

class CounterController extends GetxController {
  // Observable counter using GetX reactive state management.
  final RxInt counter = 0.obs;

  // Increment function to update the counter.
  void increment() {
    counter.value++;
  }
}
