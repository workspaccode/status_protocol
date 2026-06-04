import 'package:flutter/material.dart';

class StatusProtocolTheme extends InheritedWidget {
  final Color backgroundColor;
  final TextStyle? titleStyle;
  final TextStyle? messageStyle;
  final ButtonStyle? buttonStyle;
  final bool useSvg;

  const StatusProtocolTheme({
    super.key,
    this.backgroundColor = const Color(0xFF0D0D0F),
    this.titleStyle,
    this.messageStyle,
    this.buttonStyle,
    this.useSvg = true,
    required super.child,
  });

  static StatusProtocolTheme of(BuildContext context) {
    final result =
        context.dependOnInheritedWidgetOfExactType<StatusProtocolTheme>();
    return result ??
        const StatusProtocolTheme(child: SizedBox.shrink());
  }

  @override
  bool updateShouldNotify(StatusProtocolTheme oldWidget) {
    return backgroundColor != oldWidget.backgroundColor ||
        titleStyle != oldWidget.titleStyle ||
        messageStyle != oldWidget.messageStyle ||
        buttonStyle != oldWidget.buttonStyle ||
        useSvg != oldWidget.useSvg;
  }
}

class StatusProtocolProvider extends StatelessWidget {
  final Color backgroundColor;
  final TextStyle? titleStyle;
  final TextStyle? messageStyle;
  final ButtonStyle? buttonStyle;
  final bool useSvg;
  final Widget child;

  const StatusProtocolProvider({
    super.key,
    this.backgroundColor = const Color(0xFF0D0D0F),
    this.titleStyle,
    this.messageStyle,
    this.buttonStyle,
    this.useSvg = true,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return StatusProtocolTheme(
      backgroundColor: backgroundColor,
      titleStyle: titleStyle,
      messageStyle: messageStyle,
      buttonStyle: buttonStyle,
      useSvg: useSvg,
      child: child,
    );
  }
}
