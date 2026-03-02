import 'package:flutter/material.dart';
import 'package:mobile/core/constants/app_sizes.dart';

class AppEmptyState extends StatelessWidget {
  const AppEmptyState({
    super.key,
    required this.title,
    this.message,
    this.icon,
  });

  final String title;
  final String? message;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.spacingLg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(icon ?? Icons.inbox_outlined, size: 32),
            const SizedBox(height: AppSizes.spacingSm),
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            if (message != null) ...<Widget>[
              const SizedBox(height: AppSizes.spacingXs),
              Text(
                message!,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
