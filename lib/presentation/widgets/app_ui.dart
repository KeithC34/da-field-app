import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';

class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  const AppHeader({super.key, required this.title, this.subtitle, this.actions});

  final String title;
  final String? subtitle;
  final List<Widget>? actions;

  @override
  Size get preferredSize => const Size.fromHeight(64);

  @override
  Widget build(BuildContext context) => AppBar(
        titleSpacing: 16,
        title: subtitle == null
            ? Text(title)
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
                  Text(subtitle!, style: Theme.of(context).textTheme.labelSmall),
                ],
              ),
        actions: actions,
      );
}

class SectionHeader extends StatelessWidget {
  const SectionHeader({super.key, required this.title, this.trailing, this.subtitle});
  final String title;
  final Widget? trailing;
  final String? subtitle;

  @override
  Widget build(BuildContext context) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(title, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
              if (subtitle != null) ...[
                const SizedBox(height: 4),
                Text(subtitle!, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant)),
              ],
            ]),
          ),
          if (trailing case final Widget trailingWidget) trailingWidget,
        ],
      );
}

class SectionCard extends StatelessWidget {
  const SectionCard({super.key, required this.child, this.padding = const EdgeInsets.all(16)});
  final Widget child;
  final EdgeInsetsGeometry padding;
  @override
  Widget build(BuildContext context) => Card(child: Padding(padding: padding, child: child));
}

class OfflineBanner extends StatelessWidget {
  const OfflineBanner({super.key, this.message = 'Saved offline — will sync when internet is available.'});
  final String message;
  @override
  Widget build(BuildContext context) => Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
        color: Theme.of(context).colorScheme.secondaryContainer,
        child: Row(children: [
          const Icon(Icons.cloud_queue_outlined, size: 18),
          const SizedBox(width: 8),
          Expanded(child: Text(message, style: Theme.of(context).textTheme.labelSmall)),
        ]),
      );
}

class StatusBadge extends StatelessWidget {
  const StatusBadge({super.key, required this.label, this.color = AppTheme.primary, this.icon});
  final String label;
  final Color color;
  final IconData? icon;
  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
        decoration: BoxDecoration(color: color.withValues(alpha: .12), borderRadius: BorderRadius.circular(99)),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          if (icon != null) ...[Icon(icon, size: 14, color: color), const SizedBox(width: 4)],
          Text(label.toUpperCase(), style: TextStyle(fontSize: 10, letterSpacing: .8, color: color, fontWeight: FontWeight.w800)),
        ]),
      );
}

class EmptyState extends StatelessWidget {
  const EmptyState({super.key, required this.icon, required this.title, required this.message});
  final IconData icon;
  final String title;
  final String message;
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(32),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Icon(icon, size: 48, color: Theme.of(context).colorScheme.primary),
          const SizedBox(height: 12),
          Text(title, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(height: 6),
          Text(message, textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant)),
        ]),
      );
}
