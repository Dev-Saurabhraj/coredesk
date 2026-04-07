import 'package:flutter/material.dart';
import '../colors/app_colors.dart';

class AppIcons {
  // Icon Themes
  static const IconThemeData appBarIcons = IconThemeData(
    color: AppColors.textPrimary,
    size: 24,
  );

  static const IconThemeData navigationIcons = IconThemeData(
    color: AppColors.textSecondary,
    size: 24,
  );

  static const IconThemeData buttonIcons = IconThemeData(
    color: Colors.white,
    size: 20,
  );

  // Icon Sizes
  static const double sizeLarge = 32;
  static const double sizeMedium = 24;
  static const double sizeSmall = 16;

  // Common Icons
  static const IconData email = Icons.email_outlined;
  static const IconData lock = Icons.lock_outlined;
  static const IconData visibility = Icons.visibility;
  static const IconData visibilityOff = Icons.visibility_off;
  static const IconData dashboard = Icons.dashboard;
  static const IconData logout = Icons.logout;
  static const IconData person = Icons.person;
  static const IconData stats = Icons.bar_chart_outlined;
  static const IconData leave = Icons.beach_access_outlined;
  static const IconData holiday = Icons.calendar_today_outlined;
  static const IconData attendance = Icons.history_outlined;
  static const IconData checkCircle = Icons.check_circle_outline;
  static const IconData mail = Icons.mail_outline;
  static const IconData retry = Icons.refresh;
}
