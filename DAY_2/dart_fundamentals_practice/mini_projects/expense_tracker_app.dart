// Simple expense tracker logic with total calculation.
// Run with: dart run mini_projects/expense_tracker_app.dart

class Expense {
  String category;
  double amount;

  Expense(this.category, this.amount);
}

void main() {
  List<Expense> expenses = [
    Expense('Coffee', 4.5),
    Expense('Lunch', 12.0),
    Expense('Parking', 3.0),
  ];

  expenses.add(Expense('Books', 15.99));

  double total = expenses.fold(0.0, (sum, expense) => sum + expense.amount);
  print('Expense details:');
  for (var expense in expenses) {
    print('- ${expense.category}: \$${expense.amount}');
  }
  print('Total spent: \$${total.toStringAsFixed(2)}');
}
