import 'package:flutter/material.dart';

class ExportImportButton extends StatelessWidget {
  final String buttonText;
  final Widget? subtitleText;
  final void Function() onTap;
  final EdgeInsetsGeometry? margin;
  final IconData icon;
  const ExportImportButton({
    super.key,
    required this.buttonText,
    this.subtitleText,
    required this.onTap,
    this.margin,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onTap,
        child: Container(
          margin: margin,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 55,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              const SizedBox(height: 16),
              Text(
                buttonText,
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
              ),
              if (subtitleText != null) const SizedBox(height: 5),
              if (subtitleText != null) subtitleText!,
            ],
          ),
        ),
      ),
    );
  }
}
