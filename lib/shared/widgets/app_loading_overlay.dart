import 'package:flutter/material.dart';
import 'package:coredesk/core/colors/app_colors.dart';

class AppLoadingOverlay {
  static void show(
    BuildContext context, {
    String message = 'Loading...',
    bool dismissible = false,
  }) {
    showDialog(
      context: context,
      barrierDismissible: dismissible,
      builder: (context) => PopScope(
        canPop: dismissible,
        child: Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(AppColors.primaryColor),
              ),
              const SizedBox(height: 16),
              Text(
                message,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static void hide(BuildContext context) {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
  }
}

void showLoadingDialog(BuildContext context, {String message = 'Loading...'}) {
  AppLoadingOverlay.show(context, message: message);
}

void hideLoadingDialog(BuildContext context) {
  AppLoadingOverlay.hide(context);
}
