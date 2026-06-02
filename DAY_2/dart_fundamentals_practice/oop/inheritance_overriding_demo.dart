// Demonstrates Dart inheritance and method overriding with an employee model.
// Run with: dart run oop/inheritance_overriding_demo.dart

class Employee {
  String name;
  int id;

  Employee(this.name, this.id);

  String getDetails() => 'Employee: $name, ID: $id';
}

class Manager extends Employee {
  String department;

  Manager(String name, int id, this.department) : super(name, id);

  @override
  String getDetails() => 'Manager: $name, ID: $id, Department: $department';
}

void main() {
  Employee employee = Employee('Riya', 101);
  Manager manager = Manager('Ethan', 102, 'Marketing');

  print(employee.getDetails());
  print(manager.getDetails());
}
