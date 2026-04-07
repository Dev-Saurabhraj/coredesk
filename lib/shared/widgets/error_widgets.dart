import 'package:flutter/material.dart';
import 'package:coredesk/core/exceptions/exceptions.dart';
import 'package:coredesk/core/responsive/responsive_extensions.dart';
import 'package:coredesk/core/utils/error_handler.dart';
import 'package:coredesk/core/colors/app_colors.dart';

class ErrorWidget extends StatelessWidget {
  final AppException error;
  final VoidCallback? onRetry;
  final VoidCallback? onDismiss;
  final bool showRetry;

  const ErrorWidget({
    Key? key,
    required this.error,
    this.onRetry,
    this.onDismiss,
    this.showRetry = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final message = ErrorHandler.getUserFriendlyMessage(error);

    return Container(
      padding: EdgeInsets.all(context.responsive.cardPadding()),
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
        borderRadius: BorderRadius.circular(
          context.responsive.borderRadiusMedium(),
        ),
        border: Border.all(color: AppColors.errorColor.withOpacity(0.3)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.error_outline,
                color: AppColors.errorColor,
                size: context.responsive.iconSizeSmall(),
              ),
              SizedBox(width: context.responsive.elementSpacing()),
              Expanded(
                child: Text(
                  'Error',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.errorColor,
                    fontSize: context.adaptiveFont.titleMedium(),
                  ),
                ),
              ),
              if (onDismiss != null)
                GestureDetector(
                  onTap: onDismiss,
                  child: Icon(
                    Icons.close,
                    color: AppColors.errorColor,
                    size: context.responsive.iconSizeSmall(),
                  ),
                ),
            ],
          ),
          SizedBox(height: context.responsive.elementSpacing()),
          Text(
            message,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.textPrimary,
              fontSize: context.adaptiveFont.bodyMedium(),
            ),
          ),
          if (showRetry && onRetry != null) ...[
            SizedBox(height: context.responsive.sectionSpacing()),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: onRetry,
                icon: Icon(Icons.refresh),
                label: Text('Retry'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    vertical: context.responsive.verticalPadding(),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class LoadingOverlay extends StatelessWidget {
  final bool isLoading;
  final Widget child;
  final String? loadingMessage;

  const LoadingOverlay({
    Key? key,
    required this.isLoading,
    required this.child,
    this.loadingMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          Container(
            color: Colors.black.withOpacity(0.3),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(AppColors.primaryColor),
                  ),
                  if (loadingMessage != null) ...[
                    SizedBox(height: context.responsive.sectionSpacing()),
                    Text(
                      loadingMessage!,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white,
                        fontSize: context.adaptiveFont.bodyMedium(),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
      ],
    );
  }
}

class EmptyStateWidget extends StatelessWidget {
  final String? icon;
  final String title;
  final String? subtitle;
  final VoidCallback? onRetry;
  final Widget? customIcon;

  const EmptyStateWidget({
    Key? key,
    this.icon,
    required this.title,
    this.subtitle,
    this.onRetry,
    this.customIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(context.responsive.cardPadding()),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (customIcon != null)
              customIcon!
            else
              Icon(
                Icons.inbox_outlined,
                size: context.responsive.iconSizeLarge(),
                color: AppColors.textSecondary.withOpacity(0.5),
              ),
            SizedBox(height: context.responsive.sectionSpacing()),
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontSize: context.adaptiveFont.titleLarge(),
              ),
              textAlign: TextAlign.center,
            ),
            if (subtitle != null) ...[
              SizedBox(height: context.responsive.elementSpacing()),
              Text(
                subtitle!,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                  fontSize: context.adaptiveFont.bodyMedium(),
                ),
                textAlign: TextAlign.center,
              ),
            ],
            if (onRetry != null) ...[
              SizedBox(height: context.responsive.sectionSpacing()),
              ElevatedButton.icon(
                onPressed: onRetry,
                icon: Icon(Icons.refresh),
                label: Text('Try Again'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class ErrorSnackBar {
  static void show(
    BuildContext context,
    AppException error, {
    SnackBarAction? action,
  }) {
    final message = ErrorHandler.getUserFriendlyMessage(error);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: Colors.white),
        ),
        backgroundColor: AppColors.errorColor,
        action: action,
        duration: Duration(seconds: 4),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(context.responsive.elementSpacing()),
      ),
    );
  }

  static void showWithRetry(
    BuildContext context,
    AppException error,
    VoidCallback onRetry,
  ) {
    show(
      context,
      error,
      action: SnackBarAction(
        label: 'Retry',
        textColor: Colors.white,
        onPressed: onRetry,
      ),
    );
  }
}

class SuccessSnackBar {
  static void show(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 2),
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: Colors.white),
        ),
        backgroundColor: AppColors.successColor,
        duration: duration,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(context.responsive.elementSpacing()),
      ),
    );
  }
}
