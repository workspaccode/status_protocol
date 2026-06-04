import 'package:flutter/material.dart';
import '../utils/status_resolver.dart';
import 'status_theme.dart';

class StatusBanner extends StatelessWidget {
  final int statusCode;
  final VoidCallback? onDismiss;
  final VoidCallback? onRetry;
  final String? title;
  final String? message;
  final String? buttonLabel;
  final Color? backgroundColor;
  final Color? accentColor;

  const StatusBanner({
    super.key,
    required this.statusCode,
    this.onDismiss,
    this.onRetry,
    this.title,
    this.message,
    this.buttonLabel,
    this.backgroundColor,
    this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    final config = resolve(statusCode);
    final theme = StatusProtocolTheme.of(context);

    final bgColor = backgroundColor ?? theme.backgroundColor;
    final accent = accentColor ?? config.accentColor;
    final finalTitle = title ?? config.title;
    final finalMessage = message ?? config.message;
    final finalButtonLabel = buttonLabel ?? config.buttonLabel;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: accent.withValues(alpha: 0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.warning_amber_rounded, color: accent, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  finalTitle,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  finalMessage,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.white70,
                  ),
                ),
                if (onRetry != null) ...[
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 32,
                    child: ElevatedButton(
                      onPressed: onRetry,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: accent,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 0,
                        textStyle: const TextStyle(fontSize: 13),
                      ),
                      child: Text(finalButtonLabel),
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (onDismiss != null)
            GestureDetector(
              onTap: onDismiss,
              child: const Icon(Icons.close, color: Colors.white54, size: 20),
            ),
        ],
      ),
    );
  }
}
