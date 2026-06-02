// Demonstrates Dart constructors: default, named, and factory.
// Run with: dart run oop/constructors_demo.dart

class Vehicle {
  String model;
  int year;

  // Default constructor.
  Vehicle(this.model, this.year);

  // Named constructor.
  Vehicle.electric(String model) : this(model, DateTime.now().year);

  // Factory constructor for a safe default.
  factory Vehicle.withDefaults() {
    return Vehicle('Standard model', 2024);
  }
}

void main() {
  var car = Vehicle('Sedan', 2020);
  var electricCar = Vehicle.electric('EV Compact');
  var defaultCar = Vehicle.withDefaults();

  print('Car: ${car.model}, year ${car.year}');
  print('Electric: ${electricCar.model}, year ${electricCar.year}');
  print('Default: ${defaultCar.model}, year ${defaultCar.year}');
}
