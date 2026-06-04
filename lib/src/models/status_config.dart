import 'package:flutter/material.dart';

enum StatusCategory {
  informational,
  success,
  redirect,
  clientError,
  serverError,
}

class StatusConfig {
  final int code;
  final String title;
  final String message;
  final String assetPath;
  final String buttonLabel;
  final Color accentColor;
  final StatusCategory category;

  const StatusConfig({
    required this.code,
    required this.title,
    required this.message,
    required this.assetPath,
    required this.buttonLabel,
    required this.accentColor,
    required this.category,
  });
}
