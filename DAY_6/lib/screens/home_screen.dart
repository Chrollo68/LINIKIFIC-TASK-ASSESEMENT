import 'package:flutter/material.dart';
import '../themes/app_theme.dart';
import '../widgets/custom_widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _fabCounter = 0;

  @override
  Widget build(BuildContext context) {
    final isMobile =
        MediaQuery.of(context).size.width < AppBreakpoints.tabletMin;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Theming'),
        elevation: AppSpacing.elevationSmall,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            const CustomHeader(
              title: 'Welcome to Theme Showcase',
              subtitle: 'Material 3 Design System',
            ),

            // Cards Section
            FeatureSection(
              title: 'Featured Components',
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.lg,
                  ),
                  child: ResponsiveGrid(
                    mobileColumns: 1,
                    tabletColumns: 2,
                    desktopColumns: 3,
                    children: [
                      DemoCard(
                        title: 'Responsive Design',
                        description: 'Adapts to different screen sizes',
                        icon: Icon(
                          Icons.devices,
                          color: Theme.of(context).primaryColor,
                          size: 32,
                        ),
                      ),
                      DemoCard(
                        title: 'Theme Support',
                        description: 'Light and dark themes with Material 3',
                        icon: Icon(
                          Icons.palette,
                          color: Theme.of(context).primaryColor,
                          size: 32,
                        ),
                      ),
                      DemoCard(
                        title: 'State Management',
                        description: 'Provider package for theme switching',
                        icon: Icon(
                          Icons.settings,
                          color: Theme.of(context).primaryColor,
                          size: 32,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
              ],
            ),

            // Buttons Section
            FeatureSection(
              title: 'Button Styles',
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.lg,
                  ),
                  child: Column(
                    spacing: AppSpacing.md,
                    children: [
                      // Elevated Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Text('Elevated button pressed'),
                                duration: const Duration(seconds: 2),
                              ),
                            );
                          },
                          child: const Text('Elevated Button'),
                        ),
                      ),

                      // Outlined Button
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Text('Outlined button pressed'),
                                duration: const Duration(seconds: 2),
                              ),
                            );
                          },
                          child: const Text('Outlined Button'),
                        ),
                      ),

                      // Text Button
                      SizedBox(
                        width: double.infinity,
                        child: TextButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Text('Text button pressed'),
                                duration: const Duration(seconds: 2),
                              ),
                            );
                          },
                          child: const Text('Text Button'),
                        ),
                      ),

                      // Button Row
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () {},
                              icon: const Icon(Icons.save),
                              label: const Text('Save'),
                            ),
                          ),
                          const SizedBox(width: AppSpacing.md),
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () {},
                              icon: const Icon(Icons.clear),
                              label: const Text('Cancel'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
              ],
            ),

            // Chips Section
            FeatureSection(
              title: 'Chip Styles',
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.lg,
                  ),
                  child: Wrap(
                    spacing: AppSpacing.md,
                    runSpacing: AppSpacing.md,
                    children: [
                      ActionChip(
                        label: const Text('Action Chip'),
                        onPressed: () {},
                      ),
                      FilterChip(
                        label: const Text('Filter Chip'),
                        selected: false,
                        onSelected: (_) {},
                      ),
                      FilterChip(
                        label: const Text('Selected Filter'),
                        selected: true,
                        onSelected: (_) {},
                      ),
                      Chip(label: const Text('Input Chip'), onDeleted: () {}),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
              ],
            ),

            // Progress Indicators
            FeatureSection(
              title: 'Progress Indicators',
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.lg,
                  ),
                  child: Column(
                    spacing: AppSpacing.lg,
                    children: [
                      LinearProgressIndicator(
                        value: 0.7,
                        minHeight: 8.0,
                        borderRadius: BorderRadius.circular(
                          AppSpacing.radiusSmall,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CircularProgressIndicator(),
                          CircularProgressIndicator(value: 0.7),
                          CircularProgressIndicator(value: 0.3),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
              ],
            ),

            // Counter Display
            FeatureSection(
              title: 'Interactive Demo',
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.lg,
                  ),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.lg),
                      child: Column(
                        children: [
                          Text(
                            'FAB Button Counter',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: AppSpacing.md),
                          Text(
                            '$_fabCounter',
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium
                                ?.copyWith(
                                  color: Theme.of(context).primaryColor,
                                ),
                          ),
                          const SizedBox(height: AppSpacing.md),
                          Text(
                            'Use the FAB button to increment',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() => _fabCounter++);
        },
        tooltip: 'Increment Counter',
        child: const Icon(Icons.add),
      ),
    );
  }
}
