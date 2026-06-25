import 'package:flutter/material.dart';

class ContactInfo {
  final String? email;
  final String? phone;
  final String? website;
  final String? label;
  final String? message;

  const ContactInfo({
    this.email,
    this.phone,
    this.website,
    this.label,
    this.message,
  });
}

class ContactStyle {
  final TextStyle? labelStyle;
  final TextStyle? messageStyle;
  final TextStyle? linkStyle;
  final double? iconSize;
  final Color? iconColor;
  final EdgeInsetsGeometry? padding;
  final double? spacing;

  const ContactStyle({
    this.labelStyle,
    this.messageStyle,
    this.linkStyle,
    this.iconSize,
    this.iconColor,
    this.padding,
    this.spacing,
  });
}
