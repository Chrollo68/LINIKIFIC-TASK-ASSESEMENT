// Demonstrates Dart abstract classes, interfaces, and mixins.
// Run with: dart run oop/abstract_interface_mixin_demo.dart

abstract class Animal {
  String name;
  Animal(this.name);

  void speak();
}

class Dog extends Animal {
  Dog(String name) : super(name);

  @override
  void speak() {
    print('$name says: Woof!');
  }
}

mixin ServiceAnimal {
  void assist() {
    print('Helping with a task.');
  }
}

class GuideDog extends Dog with ServiceAnimal {
  GuideDog(String name) : super(name);
}

void main() {
  Dog dog = Dog('Buddy');
  dog.speak();

  GuideDog guideDog = GuideDog('Grace');
  guideDog.speak();
  guideDog.assist();
}
