import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
                  customButton ?? _buildDefaultButton(accent, finalButtonLabel, showColumnButtons),
              ],
            ),
          ),
        ),
      ),
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

  Widget _buildDefaultButton(Color accent, String label, bool showColumnBTNS) {
    return showColumnBTNS 
    ? Column(
      children: additionalButtons ?? [],
    )
    : ElevatedButton(
      onPressed: onRetry,
      style: ElevatedButton.styleFrom(
        backgroundColor: accent,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 0,
      ),
      child: Text(label, style: const TextStyle(fontSize: 16)),
    );
  }
}

