import 'package:flutter/material.dart';

class ButtonsShowcaseScreen extends StatelessWidget {
  const ButtonsShowcaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Buttons Showcase')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'ElevatedButton examples',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              ElevatedButton(
                onPressed: () {},
                child: const Text('Normal Elevated'),
              ),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.thumb_up),
                label: const Text('Icon Elevated'),
              ),
              const ElevatedButton(onPressed: null, child: Text('Disabled')),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            'TextButton examples',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              TextButton(onPressed: () {}, child: const Text('Basic Text')),
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.info_outline),
                label: const Text('Info'),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            'OutlinedButton examples',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              OutlinedButton(
                onPressed: () {},
                child: const Text('Basic Outline'),
              ),
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.check),
                label: const Text('Confirm'),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            'IconButton examples',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.favorite),
                tooltip: 'Favorite',
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.share),
                tooltip: 'Share',
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.settings),
                tooltip: 'Settings',
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            'FloatingActionButton examples',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              FloatingActionButton.small(
                onPressed: () {},
                tooltip: 'Small FAB',
                child: const Icon(Icons.add),
              ),
              FloatingActionButton(
                onPressed: () {},
                tooltip: 'Regular FAB',
                child: const Icon(Icons.create),
              ),
              FloatingActionButton.extended(
                onPressed: () {},
                icon: const Icon(Icons.send),
                label: const Text('Send'),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Buttons are essential Material components. ElevatedButton is used for primary actions, TextButton is low emphasis, and OutlinedButton is for secondary choices. IconButton provides compact tappable icons, and FloatingActionButton highlights prominent app actions.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
