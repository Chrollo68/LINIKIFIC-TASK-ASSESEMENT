import 'package:flutter/material.dart';
import 'package:day_3/models/list_item.dart';

class ItemListScreen extends StatelessWidget {
  const ItemListScreen({super.key});

  static final List<ListItem> _items = List<ListItem>.generate(
    24,
    (index) => ListItem(
      id: index + 1,
      title: 'Item ${index + 1}',
      subtitle: 'Description for item ${index + 1}',
    ),
  );

  void _showSnackBar(BuildContext context, ListItem item) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Tapped ${item.title}'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Item List Screen')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: const [
                Icon(Icons.list, color: Colors.indigo),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'This ListView.builder screen shows a list of items. Tap any card to display a SnackBar with the item title.',
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _items.length,
              itemBuilder: (context, index) {
                final item = _items[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 6,
                  ),
                  child: Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.indigo.shade200,
                        child: Text(
                          item.id.toString(),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      title: Text(item.title),
                      subtitle: Text(item.subtitle),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => _showSnackBar(context, item),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pop(context),
        tooltip: 'Back to Home',
        child: const Icon(Icons.arrow_back),
      ),
    );
  }
}
