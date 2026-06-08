import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import '../themes/app_theme.dart';
import '../widgets/custom_widgets.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Settings')),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomHeader(
                title: 'Appearance',
                subtitle: 'Customize your app experience',
              ),

              // Current Theme Section
              Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    child: Consumer<ThemeProvider>(
                      builder: (context, themeProvider, _) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Current Theme',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: AppSpacing.md),
                          Text(
                            themeProvider.getThemeModeString(),
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          Text(
                            themeProvider.getThemeModeDescription(),
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // Theme Selection
              FeatureSection(
                title: 'Select Theme',
                children: [
                  Consumer<ThemeProvider>(
                    builder: (context, themeProvider, _) => Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.lg,
                      ),
                      child: Column(
                        spacing: AppSpacing.md,
                        children: [
                          // Light Theme Option
                          Card(
                            child: ListTile(
                              title: const Text('Light Theme'),
                              subtitle: const Text(
                                'Bright and clean appearance',
                              ),
                              leading: Radio<ThemeMode>(
                                value: ThemeMode.light,
                                groupValue: themeProvider.themeMode,
                                onChanged: (value) {
                                  if (value != null) {
                                    themeProvider.setLightTheme();
                                  }
                                },
                              ),
                              trailing: Icon(
                                Icons.light_mode,
                                color: Theme.of(context).primaryColor,
                              ),
                              onTap: () => themeProvider.setLightTheme(),
                            ),
                          ),

                          // Dark Theme Option
                          Card(
                            child: ListTile(
                              title: const Text('Dark Theme'),
                              subtitle: const Text(
                                'Dark and comfortable for night use',
                              ),
                              leading: Radio<ThemeMode>(
                                value: ThemeMode.dark,
                                groupValue: themeProvider.themeMode,
                                onChanged: (value) {
                                  if (value != null) {
                                    themeProvider.setDarkTheme();
                                  }
                                },
                              ),
                              trailing: Icon(
                                Icons.dark_mode,
                                color: Theme.of(context).primaryColor,
                              ),
                              onTap: () => themeProvider.setDarkTheme(),
                            ),
                          ),

                          // System Theme Option
                          Card(
                            child: ListTile(
                              title: const Text('System Theme'),
                              subtitle: const Text(
                                'Follow device system settings',
                              ),
                              leading: Radio<ThemeMode>(
                                value: ThemeMode.system,
                                groupValue: themeProvider.themeMode,
                                onChanged: (value) {
                                  if (value != null) {
                                    themeProvider.setSystemTheme();
                                  }
                                },
                              ),
                              trailing: Icon(
                                Icons.brightness_auto,
                                color: Theme.of(context).primaryColor,
                              ),
                              onTap: () => themeProvider.setSystemTheme(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                ],
              ),

              // Quick Toggle
              FeatureSection(
                title: 'Quick Toggle',
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.lg,
                    ),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(AppSpacing.lg),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Toggle Theme',
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                const SizedBox(height: AppSpacing.sm),
                                Text(
                                  'Switch between light and dark',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ],
                            ),
                            Consumer<ThemeProvider>(
                              builder: (context, themeProvider, _) =>
                                  IconButton(
                                icon: Icon(
                                  themeProvider.themeMode == ThemeMode.light
                                      ? Icons.dark_mode
                                      : Icons.light_mode,
                                  size: 32,
                                ),
                                onPressed: () => themeProvider.toggleTheme(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                ],
              ),

              // Theme Preview Cards
              FeatureSection(
                title: 'Theme Preview',
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.lg,
                    ),
                    child: Consumer<ThemeProvider>(
                      builder: (context, themeProvider, _) => Column(
                        spacing: AppSpacing.md,
                        children: [
                          ThemePreviewCard(
                            title: 'Light',
                            backgroundColor: AppColors.lightBackground,
                            textColor: AppColors.lightTextPrimary,
                            isSelected:
                                themeProvider.themeMode == ThemeMode.light,
                            onTap: () => themeProvider.setLightTheme(),
                          ),
                          ThemePreviewCard(
                            title: 'Dark',
                            backgroundColor: AppColors.darkBackground,
                            textColor: AppColors.darkTextPrimary,
                            isSelected:
                                themeProvider.themeMode == ThemeMode.dark,
                            onTap: () => themeProvider.setDarkTheme(),
                          ),
                          ThemePreviewCard(
                            title: 'System',
                            backgroundColor: Theme.of(
                              context,
                            ).scaffoldBackgroundColor,
                            textColor:
                                Theme.of(context).textTheme.bodyLarge?.color ??
                                    Colors.black,
                            isSelected:
                                themeProvider.themeMode == ThemeMode.system,
                            onTap: () => themeProvider.setSystemTheme(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                ],
              ),

              // About Theme Section
              Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'About Theming',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: AppSpacing.md),
                        _buildAboutPoint(
                          context,
                          'Material 3 Design System',
                          'This app uses Material 3 design principles',
                        ),
                        const SizedBox(height: AppSpacing.md),
                        _buildAboutPoint(
                          context,
                          'Theme Persistence',
                          'Your theme preference is saved locally',
                        ),
                        const SizedBox(height: AppSpacing.md),
                        _buildAboutPoint(
                          context,
                          'Custom Color Palette',
                          'Semantic colors for success, warning, and error states',
                        ),
                        const SizedBox(height: AppSpacing.md),
                        _buildAboutPoint(
                          context,
                          'Responsive Design',
                          'Layouts adapt to different screen sizes',
                        ),
                        const SizedBox(height: AppSpacing.md),
                        _buildAboutPoint(
                          context,
                          'Typography System',
                          'Material 3 text styles applied consistently',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  Widget _buildAboutPoint(
    BuildContext context,
    String title,
    String description,
  ) =>
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.check_circle,
            color: Theme.of(context).primaryColor,
            size: 20,
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(description, style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ),
        ],
      );
}
