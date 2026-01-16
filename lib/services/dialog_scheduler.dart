import 'dart:async';
import 'package:flutter/material.dart';

class DialogScheduler {
  static Timer? _timer;

  static void scheduleDialog({
    required BuildContext context,
    required DateTime time,
    required String title,
    required String message,
  }) {
    final now = DateTime.now();
    final delay = time.difference(now);

    if (delay.isNegative) return;

    _timer?.cancel();

    _timer = Timer(delay, () {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    });
  }
}
