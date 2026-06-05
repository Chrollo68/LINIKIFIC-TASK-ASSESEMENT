import 'package:flutter/material.dart';

class CardsListTilesScreen extends StatelessWidget {
  const CardsListTilesScreen({super.key});

  static final List<String> items = List<String>.generate(
    10,
    (index) => 'List item ${index + 1}',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cards & ListTiles')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('Card widgets', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 12),
          const Card(
            child: ListTile(
              leading: Icon(Icons.star_outline),
              title: Text('Simple Card'),
              subtitle: Text('A basic Material card with elevation.'),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
          ),
          const SizedBox(height: 12),
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: const ListTile(
              leading: Icon(Icons.upcoming),
              title: Text('Elevated Card'),
              subtitle: Text('A card with extra elevation for emphasis.'),
            ),
          ),
          const SizedBox(height: 12),
          Card(
            color: Theme.of(context).colorScheme.primaryContainer,
            child: const ListTile(
              leading: Icon(Icons.layers, color: Colors.white),
              title: Text(
                'Filled Card',
                style: TextStyle(color: Colors.white),
              ),
              subtitle: Text(
                'A filled card uses the theme surface color.',
                style: TextStyle(color: Colors.white70),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Card(
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Theme.of(context).colorScheme.outline),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const ListTile(
              leading: Icon(Icons.border_outer),
              title: Text('Outlined Card'),
              subtitle: Text('A card with an outline border.'),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'ListTiles and Avatars',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 12),
          ...items.map((item) {
            final index = items.indexOf(item);
            return Column(
              children: [
                ListTile(
                  leading: CircleAvatar(child: Text('${index + 1}')),
                  title: Text(item),
                  subtitle: const Text(
                    'This tile demonstrates a title, subtitle and trailing icon.',
                  ),
                  trailing: const Icon(Icons.chevron_right),
                ),
                const Divider(),
              ],
            );
          }).toList(),
          const SizedBox(height: 24),
          const ExpansionTile(
            leading: Icon(Icons.expand_more),
            title: Text('More material details'),
            children: [
              ListTile(
                leading: Icon(Icons.info),
                title: Text('Responsive design'),
                subtitle: Text(
                  'ExpansionTile can reveal additional content without leaving the page.',
                ),
              ),
              ListTile(
                leading: Icon(Icons.brush),
                title: Text('Theming example'),
                subtitle: Text(
                  'Material widgets adapt to the current color scheme.',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
