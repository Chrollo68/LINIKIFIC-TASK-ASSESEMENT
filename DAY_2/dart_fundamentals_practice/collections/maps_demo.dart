// Demonstrates Dart map usage with a product inventory example.
// Run with: dart run collections/maps_demo.dart

void main() {
  Map<String, int> inventory = {'notebook': 12, 'pen': 20, 'marker': 8};
  print('Initial inventory: $inventory');

  inventory['pen'] = 22;
  inventory['stapler'] = 3;
  print('Updated inventory: $inventory');

  inventory.remove('marker');
  print('After removing marker: $inventory');

  print('Available notebook quantity: ${inventory['notebook']}');
}
