// Simple shopping cart logic with subtotal and discount.
// Run with: dart run mini_projects/shopping_cart_app.dart

class CartItem {
  String name;
  int quantity;
  double price;

  CartItem(this.name, this.quantity, this.price);
}

void main() {
  List<CartItem> cart = [
    CartItem('Notebook', 2, 5.5),
    CartItem('Pencil', 5, 1.25),
  ];

  cart.add(CartItem('Mouse pad', 1, 8.0));

  double subtotal = cart.fold(
    0.0,
    (sum, item) => sum + item.price * item.quantity,
  );
  print('Cart items:');
  for (var item in cart) {
    print(
      '- ${item.name} x${item.quantity}: \$${(item.price * item.quantity).toStringAsFixed(2)}',
    );
  }

  print('Subtotal: \$${subtotal.toStringAsFixed(2)}');
  print('Discounted total: \$${applyDiscount(subtotal).toStringAsFixed(2)}');
}

double applyDiscount(double subtotal) {
  if (subtotal > 20) {
    return subtotal * 0.9;
  }
  return subtotal;
}
