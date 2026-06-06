import 'package:flutter/material.dart';
import '../themes/app_theme.dart';

/// Custom header widget
class CustomHeader extends StatelessWidget {
  const CustomHeader({super.key, required this.title, this.subtitle});
  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.headlineLarge),
            if (subtitle != null) ...[
              const SizedBox(height: AppSpacing.sm),
              Text(subtitle!, style: Theme.of(context).textTheme.bodyMedium),
            ],
          ],
        ),
      );
}

/// Themed card widget for demonstration
class DemoCard extends StatelessWidget {
  const DemoCard({
    super.key,
    required this.title,
    required this.description,
    this.icon,
    this.onTap,
  });
  final String title;
  final String description;
  final Widget? icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => Card(
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (icon != null) ...[
                  icon!,
                  const SizedBox(height: AppSpacing.md),
                ],
                Text(title, style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: AppSpacing.sm),
                Text(description,
                    style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ),
        ),
      );
}

/// Theme preview card
class ThemePreviewCard extends StatelessWidget {
  const ThemePreviewCard({
    super.key,
    required this.title,
    required this.backgroundColor,
    required this.textColor,
    this.onTap,
    this.isSelected = false,
  });
  final String title;
  final Color backgroundColor;
  final Color textColor;
  final VoidCallback? onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
            border: isSelected
                ? Border.all(color: Theme.of(context).primaryColor, width: 3)
                : null,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: textColor,
                    fontSize: AppTypography.titleLargeSize,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (isSelected) ...[
                  const SizedBox(height: AppSpacing.sm),
                  Icon(Icons.check_circle, color: textColor, size: 24),
                ],
              ],
            ),
          ),
        ),
      );
}

/// Status badge widget
class StatusBadge extends StatelessWidget {
  const StatusBadge({
    super.key,
    required this.label,
    required this.backgroundColor,
    required this.textColor,
  });
  final String label;
  final Color backgroundColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(AppSpacing.radiusLarge),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.w600,
            fontSize: AppTypography.bodyMediumSize,
          ),
        ),
      );
}

/// Semantic color showcase
class SemanticColorTile extends StatelessWidget {
  const SemanticColorTile({
    super.key,
    required this.label,
    required this.color,
    required this.semanticName,
  });
  final String label;
  final Color color;
  final String semanticName;

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(AppSpacing.radiusMedium),
        ),
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: TextStyle(
                color: _getContrastColor(color),
                fontWeight: FontWeight.w600,
                fontSize: AppTypography.bodyLargeSize,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              semanticName,
              style: TextStyle(
                color: _getContrastColor(color).withOpacity(0.8),
                fontSize: AppTypography.bodyMediumSize,
              ),
            ),
          ],
        ),
      );

  Color _getContrastColor(Color color) {
    final luminance = color.computeLuminance();
    return luminance > 0.5 ? Colors.black : Colors.white;
  }
}

/// Responsive grid widget
class ResponsiveGrid extends StatelessWidget {
  const ResponsiveGrid({
    super.key,
    required this.children,
    this.mobileColumns = 1,
    this.tabletColumns = 2,
    this.desktopColumns = 3,
    this.spacing = AppSpacing.md,
  });
  final List<Widget> children;
  final int mobileColumns;
  final int tabletColumns;
  final int desktopColumns;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    int columns;

    if (screenWidth < AppBreakpoints.tabletMin) {
      columns = mobileColumns;
    } else if (screenWidth < AppBreakpoints.desktopMin) {
      columns = tabletColumns;
    } else {
      columns = desktopColumns;
    }

    return GridView.count(
      crossAxisCount: columns,
      mainAxisSpacing: spacing,
      crossAxisSpacing: spacing,
      childAspectRatio: 1,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: children,
    );
  }
}

/// Feature showcase section
class FeatureSection extends StatelessWidget {
  const FeatureSection(
      {super.key, required this.title, required this.children});
  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg,
              AppSpacing.lg,
              AppSpacing.lg,
              AppSpacing.md,
            ),
            child:
                Text(title, style: Theme.of(context).textTheme.headlineMedium),
          ),
          ...children,
        ],
      );
}
