// Demonstrates Dart late variables and required named parameters.
// Run with: dart run null_safety/late_required_demo.dart

class Book {
  late String title;
  late String author;

  Book({required this.title, required this.author});

  void describe() {
    print('Book: $title by $author');
  }
}

void main() {
  Book book = Book(title: 'Effective Dart', author: 'Dart Team');
  book.describe();
}
