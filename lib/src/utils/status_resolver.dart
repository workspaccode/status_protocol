import 'package:flutter/material.dart';
import '../data/status_data.dart';
import '../models/status_config.dart';

const _fallbackAsset = 'assets/svg/noInternet.svg';

StatusConfig resolve(int code) {
  final configs = allStatusConfigs();

  final exact = configs.where((c) => c.code == code).firstOrNull;
  if (exact != null) return exact;

  if (code >= 400 && code < 500) {
    return StatusConfig(
      code: code,
      title: 'Client Error',
      message: 'Something went wrong with your request.',
      assetPath: _fallbackAsset,
      buttonLabel: 'Try Again',
      accentColor: Colors.orange,
      category: StatusCategory.clientError,
    );
  }

  if (code >= 500 && code < 600) {
    return StatusConfig(
      code: code,
      title: 'Server Error',
      message: 'Something went wrong on our end.',
      assetPath: _fallbackAsset,
      buttonLabel: 'Try Again',
      accentColor: Colors.purple,
      category: StatusCategory.serverError,
    );
  }

  if (code <= 0) {
    return const StatusConfig(
      code: 0,
      title: 'No Internet',
      message: 'Check your internet connection.',
      assetPath: 'assets/svg/noInternet.svg',
      buttonLabel: 'Retry',
      accentColor: Colors.grey,
      category: StatusCategory.clientError,
    );
  }

  return const StatusConfig(
    code: -1,
    title: 'Unknown Error',
    message: 'An unexpected error occurred.',
    assetPath: 'assets/svg/noInternet.svg',
    buttonLabel: 'Try Again',
    accentColor: Colors.grey,
    category: StatusCategory.serverError,
  );
}
