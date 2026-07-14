import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../models/status_button.dart';
import '../utils/status_resolver.dart';
import 'status_theme.dart';

class StatusScreen extends StatelessWidget {
  final int statusCode;
  final void Function()? onRetry;
  final String? title;
  final String? message;
  final String? buttonLabel;
  final String? svgAsset;
  final Color? backgroundColor;
  final Color? accentColor;
  final bool showButton;
  final Widget? customButton;
  final Widget? customImage;
  final TextStyle? titleStyle;
  final TextStyle? messageStyle;
  final List<Widget>? additionalButtons;
  final bool showColumnButtons;

  /// The list of action buttons to display. Controls both the number of
  /// buttons and the style of each one (elevated, outlined or text) via
  /// [StatusButton.type]. When `null`, a single default button is built from
  /// [buttonLabel] and [onRetry].
  final List<StatusButton>? buttons;

  const StatusScreen({
    super.key,
    required this.statusCode,
    this.onRetry,
    this.title,
    this.message,
    this.buttonLabel,
    this.svgAsset,
    this.backgroundColor,
    this.accentColor,
    this.showButton = true,
    this.customButton,
    this.customImage,
    this.titleStyle,
    this.messageStyle,
    this.additionalButtons,
    this.showColumnButtons = false,
    this.buttons,
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
    final isDefaultAsset = svgAsset == null;
    final finalAssetPath = svgAsset ?? config.assetPath;
    final useSvg = theme.useSvg;

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 48),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (customImage != null)
                  customImage!
                else if (useSvg)
                  SvgPicture.asset(
                    finalAssetPath,
                    package: isDefaultAsset ? 'status_protocol' : null,
                    width: 200,
                    height: 200,
                    fit: BoxFit.contain,
                  )
                else
                  _buildFallbackIcon(accent),
                const SizedBox(height: 32),
                Text(
                  finalTitle,
                  style: titleStyle ??
                      theme.titleStyle ??
                      const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        // color: Colors.white,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text(
                  finalMessage,
                  style: messageStyle ??
                      theme.messageStyle ??
                      const TextStyle(
                        fontSize: 16,
                        // color: Colors.white70,
                        height: 1.4,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                if (showButton)
                  customButton ?? _buildButtons(accent, finalButtonLabel),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Builds a single button of the requested [StatusButton.type].
  Widget _buildButton(StatusButton button, Color accent) {
    final color = button.accentColor ?? accent;
    final child = Text(button.label, style: const TextStyle(fontSize: 16));

    switch (button.type) {
      case StatusButtonType.elevated:
        return ElevatedButton(
          onPressed: button.onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 0,
          ),
          child: child,
        );
      case StatusButtonType.outlined:
        return OutlinedButton(
          onPressed: button.onPressed,
          style: OutlinedButton.styleFrom(
            foregroundColor: color,
            side: BorderSide(color: color, width: 1.5),
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: child,
        );
      case StatusButtonType.text:
        return TextButton(
          onPressed: button.onPressed,
          style: TextButton.styleFrom(
            foregroundColor: color,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: child,
        );
    }
  }

  /// Builds the action buttons area.
  ///
  /// When [buttons] is provided, that list is rendered (its length controls
  /// how many buttons appear and each entry's [StatusButton.type] controls
  /// whether it is elevated, outlined or text). Otherwise a single default
  /// button is built from [buttonLabel] and [onRetry]. The legacy
  /// [additionalButtons] raw-widget list is still supported when
  /// [showColumnButtons] is `true` and no [buttons] are supplied.
  Widget _buildButtons(Color accent, String defaultLabel) {
    // Legacy raw-widget fallback.
    if (buttons == null && showColumnButtons && additionalButtons != null) {
      return Column(children: additionalButtons!);
    }

    final resolved = buttons ??
        [
          StatusButton(label: defaultLabel, onPressed: onRetry),
        ];

    final built = resolved.map((b) => _buildButton(b, accent)).toList();

    if (showColumnButtons) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: _withSpacing(built, vertical: 12),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: _withSpacing(built, horizontal: 12),
    );
  }

  Widget _buildFallbackIcon(Color accent) {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.error_outline_rounded,
        size: 56,
        color: accent,
      ),
    );
  }

  /// Interleaves [SizedBox] spacers between [widgets] so multiple buttons are
  /// evenly separated, either horizontally (row) or vertically (column).
  List<Widget> _withSpacing(
    List<Widget> widgets, {
    double horizontal = 0,
    double vertical = 0,
  }) {
    if (widgets.length <= 1) return widgets;
    final spacer = SizedBox(width: horizontal, height: vertical);
    final result = <Widget>[];
    for (var i = 0; i < widgets.length; i++) {
      if (i > 0) result.add(spacer);
      result.add(widgets[i]);
    }
    return result;
  }
}
