import 'package:flutter/services.dart';

class HapticsService {
  static Future<void> lightTap() {
    return HapticFeedback.lightImpact().catchError((_) {
      // Haptics not supported or failed gracefully
    });
  }

  static Future<void> mediumTap() {
    return HapticFeedback.mediumImpact().catchError((_) {
      // Haptics not supported or failed gracefully
    });
  }

  static Future<void> heavyTap() {
    return HapticFeedback.heavyImpact().catchError((_) {
      // Haptics not supported or failed gracefully
    });
  }

  static Future<void> selectionTap() {
    return HapticFeedback.selectionClick().catchError((_) {
      // Haptics not supported or failed gracefully
    });
  }

  static Future<void> successTap() async {
    try {
      await HapticFeedback.heavyImpact();
      await Future.delayed(Duration(milliseconds: 50));
      await HapticFeedback.heavyImpact();
    } catch (e) {
      // Haptics not supported
    }
  }

  static Future<void> errorTap() async {
    try {
      await HapticFeedback.heavyImpact();
      await Future.delayed(Duration(milliseconds: 30));
      await HapticFeedback.heavyImpact();
      await Future.delayed(Duration(milliseconds: 30));
      await HapticFeedback.heavyImpact();
    } catch (e) {
      // Haptics not supported
    }
  }
}
