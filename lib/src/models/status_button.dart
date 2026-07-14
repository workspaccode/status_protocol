import 'package:flutter/material.dart';

/// Describes a single action button shown on a [StatusScreen].
///
/// Provide a list of these via [StatusScreen.buttons] to control both the
/// number of buttons and the style of each one (elevated, outlined or text).
class StatusButton {
  /// The text displayed on the button.
  final String label;

  /// Callback invoked when the button is pressed.
  final VoidCallback? onPressed;

  /// The visual style of the button. Defaults to [StatusButtonType.elevated].
  final StatusButtonType type;

  /// Optional override for the accent color used by this button. When `null`,
  /// the screen's [StatusScreen.accentColor] is used instead.
  final Color? accentColor;

  const StatusButton({
    required this.label,
    this.onPressed,
    this.type = StatusButtonType.elevated,
    this.accentColor,
  });
}

/// The visual style of a button rendered by [StatusScreen].
enum StatusButtonType {
  /// A filled, prominent button ([ElevatedButton]).
  elevated,

  /// A button with a border and transparent background ([OutlinedButton]).
  outlined,

  /// A low-emphasis, text-only button ([TextButton]).
  text,
}
