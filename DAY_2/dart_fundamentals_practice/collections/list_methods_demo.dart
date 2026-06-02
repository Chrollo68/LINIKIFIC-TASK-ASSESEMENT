// Demonstrates Dart list methods with a shopping cart example.
// Run with: dart run collections/list_methods_demo.dart

void main() {
  List<int> cartPrices = [15, 25, 40, 10];
  print('Initial cart: $cartPrices');

  cartPrices.add(8);
  print('After add: $cartPrices');

  cartPrices.remove(25);
  print('After remove: $cartPrices');

  List<int> discounted = cartPrices.map((price) => price - 2).toList();
  print('Discounted prices: $discounted');

  List<int> expensiveItems = cartPrices.where((price) => price > 20).toList();
  print('Expensive items: $expensiveItems');

  int total = cartPrices.reduce((value, element) => value + element);
  print('Total price: $total');

  cartPrices.sort();
  print('Sorted prices: $cartPrices');
}
