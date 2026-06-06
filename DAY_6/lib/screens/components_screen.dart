import 'package:flutter/material.dart';
import '../themes/app_theme.dart';
import '../widgets/custom_widgets.dart';

class ComponentsScreen extends StatefulWidget {
  const ComponentsScreen({Key? key}) : super(key: key);

  @override
  State<ComponentsScreen> createState() => _ComponentsScreenState();
}

class _ComponentsScreenState extends State<ComponentsScreen> {
  bool _isLoading = false;

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Dialog Title'),
        content: const Text(
          'This is a themed dialog component. All colors and styles are inherited from the active theme.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Bottom Sheet',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              'This bottom sheet demonstrates themed component styling with Material 3.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: AppSpacing.lg),
            Row(
              spacing: AppSpacing.md,
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Close'),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Done'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Component Showcase')),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomHeader(
                title: 'UI Components',
                subtitle: 'All themed with Material 3 design system',
              ),

              // Dialog and Bottom Sheet Section
              FeatureSection(
                title: 'Dialogs & Modals',
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.lg,
                    ),
                    child: Column(
                      spacing: AppSpacing.md,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: () => _showDialog(context),
                            icon: const Icon(Icons.info_outline),
                            label: const Text('Show Dialog'),
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton.icon(
                            onPressed: () => _showBottomSheet(context),
                            icon: const Icon(Icons.upload),
                            label: const Text('Show Bottom Sheet'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                ],
              ),

              // Color Palette Section
              FeatureSection(
                title: 'Color Palette',
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.lg,
                    ),
                    child: Column(
                      spacing: AppSpacing.md,
                      children: [
                        // Primary Colors
                        Text(
                          'Primary Colors',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                        const Row(
                          spacing: AppSpacing.md,
                          children: [
                            Expanded(
                              child: SemanticColorTile(
                                label: 'Primary',
                                color: AppColors.primary,
                                semanticName: 'Main action color',
                              ),
                            ),
                            Expanded(
                              child: SemanticColorTile(
                                label: 'Primary Light',
                                color: AppColors.primaryLight,
                                semanticName: 'Lighter variant',
                              ),
                            ),
                          ],
                        ),

                        // Secondary Colors
                        const SizedBox(height: AppSpacing.md),
                        Text(
                          'Secondary Colors',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                        const Row(
                          spacing: AppSpacing.md,
                          children: [
                            Expanded(
                              child: SemanticColorTile(
                                label: 'Secondary',
                                color: AppColors.secondary,
                                semanticName: 'Secondary action',
                              ),
                            ),
                            Expanded(
                              child: SemanticColorTile(
                                label: 'Secondary Light',
                                color: AppColors.secondaryLight,
                                semanticName: 'Lighter variant',
                              ),
                            ),
                          ],
                        ),

                        // Semantic Colors
                        const SizedBox(height: AppSpacing.md),
                        Text(
                          'Semantic Colors',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                        const Row(
                          spacing: AppSpacing.md,
                          children: [
                            Expanded(
                              child: SemanticColorTile(
                                label: 'Success',
                                color: AppColors.success,
                                semanticName: 'Success state',
                              ),
                            ),
                            Expanded(
                              child: SemanticColorTile(
                                label: 'Warning',
                                color: AppColors.warning,
                                semanticName: 'Warning state',
                              ),
                            ),
                          ],
                        ),
                        const Row(
                          spacing: AppSpacing.md,
                          children: [
                            Expanded(
                              child: SemanticColorTile(
                                label: 'Error',
                                color: AppColors.error,
                                semanticName: 'Error state',
                              ),
                            ),
                            Expanded(
                              child: SemanticColorTile(
                                label: 'Info',
                                color: AppColors.info,
                                semanticName: 'Info state',
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

              // Status Badges
              const FeatureSection(
                title: 'Status Badges',
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSpacing.lg,
                    ),
                    child: Wrap(
                      spacing: AppSpacing.md,
                      runSpacing: AppSpacing.md,
                      children: [
                        StatusBadge(
                          label: 'Active',
                          backgroundColor: AppColors.success,
                          textColor: Colors.white,
                        ),
                        StatusBadge(
                          label: 'Pending',
                          backgroundColor: AppColors.warning,
                          textColor: Colors.white,
                        ),
                        StatusBadge(
                          label: 'Error',
                          backgroundColor: AppColors.error,
                          textColor: Colors.white,
                        ),
                        StatusBadge(
                          label: 'Info',
                          backgroundColor: AppColors.info,
                          textColor: Colors.white,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: AppSpacing.lg),
                ],
              ),

              // List Tiles
              FeatureSection(
                title: 'List Components',
                children: [
                  Card(
                    margin:
                        const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                    child: Column(
                      children: [
                        ListTile(
                          leading: Icon(
                            Icons.account_circle,
                            color: Theme.of(context).primaryColor,
                          ),
                          title: const Text('User Profile'),
                          subtitle: const Text('Tap to view details'),
                          trailing: const Icon(Icons.arrow_forward_ios),
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Profile tapped')),
                            );
                          },
                        ),
                        const Divider(),
                        ListTile(
                          leading: Icon(
                            Icons.settings,
                            color: Theme.of(context).primaryColor,
                          ),
                          title: const Text('Settings'),
                          subtitle: const Text('App configuration'),
                          trailing: const Icon(Icons.arrow_forward_ios),
                        ),
                        const Divider(),
                        ListTile(
                          leading: Icon(
                            Icons.help,
                            color: Theme.of(context).primaryColor,
                          ),
                          title: const Text('Help & Support'),
                          subtitle: const Text('Get help with the app'),
                          trailing: const Icon(Icons.arrow_forward_ios),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                ],
              ),

              // Loading State
              FeatureSection(
                title: 'Loading States',
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.lg,
                    ),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(AppSpacing.lg),
                        child: Column(
                          spacing: AppSpacing.md,
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() => _isLoading = !_isLoading);
                                },
                                child: Text(
                                  _isLoading ? 'Loading...' : 'Start Loading',
                                ),
                              ),
                            ),
                            if (_isLoading)
                              Column(
                                spacing: AppSpacing.md,
                                children: [
                                  LinearProgressIndicator(
                                    minHeight: 8,
                                    borderRadius: BorderRadius.circular(
                                      AppSpacing.radiusSmall,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 50,
                                    height: 50,
                                    child: CircularProgressIndicator(),
                                  ),
                                  Text(
                                    'Processing...',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                ],
              ),

              // Text Styles
              FeatureSection(
                title: 'Typography',
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.lg,
                    ),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(AppSpacing.lg),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: AppSpacing.md,
                          children: [
                            Text(
                              'Display Large',
                              style: Theme.of(context).textTheme.displayLarge,
                            ),
                            Text(
                              'Headline Large',
                              style: Theme.of(context).textTheme.headlineLarge,
                            ),
                            Text(
                              'Title Large',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            Text(
                              'Body Large',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            Text(
                              'Body Medium',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            Text(
                              'Label Large',
                              style: Theme.of(context).textTheme.labelLarge,
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
      );
}
