import 'package:flutter/material.dart';

class ProfileTile extends StatelessWidget {
  const ProfileTile({
    super.key,
    required this.title,
    required this.value,
    this.icon,
    this.trailing,
  });

  final String title;
  final String value;
  final IconData? icon;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon != null ? Icon(icon) : null,
      title: Text(title, style: Theme.of(context).textTheme.titleSmall),
      subtitle: Text(value, style: Theme.of(context).textTheme.bodyMedium),
      trailing: trailing,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    );
  }
}
