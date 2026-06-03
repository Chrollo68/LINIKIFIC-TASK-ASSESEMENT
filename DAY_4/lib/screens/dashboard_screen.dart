import 'package:flutter/material.dart';

import '../widgets/common_widgets.dart';

class DashboardScreen extends StatelessWidget {
  static const routeName = '/dashboard';

  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard Screen')),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth > 900;
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SectionHeader(
                    title: 'Dashboard Summary',
                    subtitle: 'Nested rows and columns with responsive layout.',
                  ),
                  Expanded(
                    child: isWide
                        ? _WideDashboardContent()
                        : _NarrowDashboardContent(),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _WideDashboardContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: Column(
            children: [
              Row(
                children: const [
                  Expanded(
                      child: StatisticCard(
                          title: 'Orders',
                          value: '1.2K',
                          icon: Icons.shopping_cart,
                          color: Colors.blue)),
                  SizedBox(width: 14),
                  Expanded(
                      child: StatisticCard(
                          title: 'Revenue',
                          value: '\$24.8K',
                          icon: Icons.trending_up,
                          color: Colors.green)),
                ],
              ),
              const SizedBox(height: 14),
              Row(
                children: const [
                  Expanded(
                      child: StatisticCard(
                          title: 'Visitors',
                          value: '7.4K',
                          icon: Icons.people_alt,
                          color: Colors.purple)),
                  SizedBox(width: 14),
                  Expanded(
                      child: StatisticCard(
                          title: 'Conversion',
                          value: '18%',
                          icon: Icons.show_chart,
                          color: Colors.orange)),
                ],
              ),
              const SizedBox(height: 14),
              Expanded(child: _RecentActivity()),
            ],
          ),
        ),
        const SizedBox(width: 14),
        Expanded(flex: 2, child: _QuickActions()),
      ],
    );
  }
}

class _NarrowDashboardContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const StatisticCard(
            title: 'Orders',
            value: '1.2K',
            icon: Icons.shopping_cart,
            color: Colors.blue),
        const SizedBox(height: 12),
        const StatisticCard(
            title: 'Revenue',
            value: '\$24.8K',
            icon: Icons.trending_up,
            color: Colors.green),
        const SizedBox(height: 12),
        const StatisticCard(
            title: 'Visitors',
            value: '7.4K',
            icon: Icons.people_alt,
            color: Colors.purple),
        const SizedBox(height: 12),
        const StatisticCard(
            title: 'Conversion',
            value: '18%',
            icon: Icons.show_chart,
            color: Colors.orange),
        const SizedBox(height: 12),
        Expanded(child: _QuickActions()),
        const SizedBox(height: 12),
        Expanded(child: _RecentActivity()),
      ],
    );
  }
}

class _QuickActions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Quick Actions',
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 14),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _ActionTile(icon: Icons.add_shopping_cart, label: 'New sale'),
                _ActionTile(icon: Icons.bar_chart, label: 'Analytics'),
                _ActionTile(
                    icon: Icons.inventory_2_outlined, label: 'Inventory'),
                _ActionTile(icon: Icons.person_add, label: 'New lead'),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _RecentActivity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Recent Activity',
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            Expanded(
              child: ListView(
                children: const [
                  ListTile(
                    leading: Icon(Icons.check_circle_outline),
                    title: Text('Order #4532 completed'),
                    subtitle: Text('2 hours ago'),
                  ),
                  ListTile(
                    leading: Icon(Icons.person_outline),
                    title: Text('New customer joined'),
                    subtitle: Text('4 hours ago'),
                  ),
                  ListTile(
                    leading: Icon(Icons.trending_up),
                    title: Text('Campaign performance improved'),
                    subtitle: Text('Yesterday'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionTile extends StatelessWidget {
  final IconData icon;
  final String label;

  const _ActionTile({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(14),
        width: 140,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Theme.of(context).colorScheme.outline),
        ),
        child: Row(
          children: [
            CircleAvatar(
                radius: 18,
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                child: Icon(icon,
                    color: Theme.of(context).colorScheme.primary, size: 20)),
            const SizedBox(width: 12),
            Expanded(
                child:
                    Text(label, style: Theme.of(context).textTheme.bodyMedium)),
          ],
        ),
      ),
    );
  }
}
