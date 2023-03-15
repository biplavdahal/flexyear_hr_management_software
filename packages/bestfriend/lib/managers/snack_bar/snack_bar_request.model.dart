import 'package:bestfriend/bestfriend.dart';
import 'package:flutter/foundation.dart';

class SnackbarAction {
  final String label;
  final VoidCallback onPressed;

  SnackbarAction({
    required this.label,
    required this.onPressed,
  });
}

class SnackbarRequest {
  final ESnackbarType type;
  final String message;
  final ESnackbarDuration duration;
  final SnackbarAction? action;

  SnackbarRequest._({
    this.type = ESnackbarType.info,
    required this.message,
    this.duration = ESnackbarDuration.short,
    this.action,
  });

  factory SnackbarRequest.of({
    required String message,
    ESnackbarType type = ESnackbarType.info,
    ESnackbarDuration duration = ESnackbarDuration.short,
    SnackbarAction? action,
  }) {
    return SnackbarRequest._(
      message: message,
      type: type,
      duration: duration,
      action: action,
    );
  }
}
