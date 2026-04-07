import 'package:flutter/material.dart';
import 'package:coredesk/core/responsive/responsive_extensions.dart';
import 'package:coredesk/core/colors/app_colors.dart';

class ResponsivePaddingContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets? customPadding;
  final Alignment alignment;
  final Color? backgroundColor;
  final BorderRadiusGeometry? borderRadius;

  const ResponsivePaddingContainer({
    Key? key,
    required this.child,
    this.customPadding,
    this.alignment = Alignment.topLeft,
    this.backgroundColor,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: Padding(
        padding: customPadding ?? context.screenPadding,
        child: Align(alignment: alignment, child: child),
      ),
    );
  }
}

class ResponsiveCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final double? elevation;
  final Color? backgroundColor;
  final BorderRadiusGeometry? borderRadius;
  final VoidCallback? onTap;
  final Border? border;

  const ResponsiveCard({
    Key? key,
    required this.child,
    this.padding,
    this.margin,
    this.elevation,
    this.backgroundColor,
    this.borderRadius,
    this.onTap,
    this.border,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final card = Card(
      elevation: elevation ?? 1,
      backgroundColor: backgroundColor ?? Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius:
            borderRadius ??
            BorderRadius.circular(context.responsive.borderRadiusMedium()),
        side: border != null
            ? border!.sides.first
            : BorderSide(color: AppColors.borderColor.withOpacity(0.15)),
      ),
      child: Padding(
        padding: padding ?? EdgeInsets.all(context.responsive.cardPadding()),
        child: child,
      ),
    );

    if (onTap != null) {
      return GestureDetector(onTap: onTap, child: card);
    }

    return card;
  }
}

class ResponsiveSection extends StatelessWidget {
  final String? title;
  final Widget child;
  final EdgeInsets? padding;
  final TextStyle? titleStyle;
  final VoidCallback? onViewMore;

  const ResponsiveSection({
    Key? key,
    this.title,
    required this.child,
    this.padding,
    this.titleStyle,
    this.onViewMore,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null) ...[
          Padding(
            padding: EdgeInsets.only(
              left: context.responsive.horizontalPadding(),
              right: context.responsive.horizontalPadding(),
              bottom: context.responsive.elementSpacing(),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title!,
                  style:
                      titleStyle ??
                      Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontSize: context.adaptiveFont.titleLarge(),
                        fontWeight: FontWeight.w600,
                      ),
                ),
                if (onViewMore != null)
                  GestureDetector(
                    onTap: onViewMore,
                    child: Text(
                      'View More',
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: AppColors.primary,
                        fontSize: context.adaptiveFont.labelMedium(),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
        Padding(
          padding:
              padding ??
              EdgeInsets.symmetric(
                horizontal: context.responsive.horizontalPadding(),
              ),
          child: child,
        ),
      ],
    );
  }
}

class ResponsiveButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool isLoading;
  final bool isEnabled;
  final IconData? icon;
  final ButtonStyle? style;
  final double? minHeight;

  const ResponsiveButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.isEnabled = true,
    this.icon,
    this.style,
    this.minHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: minHeight ?? (context.responsive.headerPadding()),
      child: ElevatedButton.icon(
        onPressed: isLoading || !isEnabled ? null : onPressed,
        icon: isLoading
            ? SizedBox(
                height: context.responsive.iconSizeSmall(),
                width: context.responsive.iconSizeSmall(),
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                ),
              )
            : (icon != null ? Icon(icon) : SizedBox.shrink()),
        label: Text(
          label,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            fontSize: context.adaptiveFont.labelLarge(),
          ),
        ),
        style: style,
      ),
    );
  }
}

class ResponsiveListTile extends StatelessWidget {
  final Widget? leading;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final bool showDivider;

  const ResponsiveListTile({
    Key? key,
    this.leading,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.backgroundColor,
    this.showDivider = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          color: backgroundColor ?? Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: Padding(
              padding: EdgeInsets.all(context.responsive.elementSpacing()),
              child: Row(
                children: [
                  if (leading != null) ...[
                    leading!,
                    SizedBox(width: context.responsive.elementSpacing()),
                  ],
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(
                                fontSize: context.adaptiveFont.bodyLarge(),
                              ),
                        ),
                        if (subtitle != null) ...[
                          SizedBox(height: 2),
                          Text(
                            subtitle!,
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(
                                  fontSize: context.adaptiveFont.bodySmall(),
                                  color: AppColors.onSurfaceVariant,
                                ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  if (trailing != null) ...[
                    SizedBox(width: context.responsive.elementSpacing()),
                    trailing!,
                  ],
                ],
              ),
            ),
          ),
        ),
        if (showDivider)
          Divider(height: 1, color: AppColors.borderColor.withOpacity(0.2)),
      ],
    );
  }
}

class ResponsiveTextInput extends StatelessWidget {
  final String labelText;
  final String? hintText;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final Icon? prefixIcon;
  final Icon? suffixIcon;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final int maxLines;

  const ResponsiveTextInput({
    Key? key,
    required this.labelText,
    this.hintText,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.onChanged,
    this.maxLines = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      maxLines: maxLines,
      validator: validator,
      onChanged: onChanged,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
        fontSize: context.adaptiveFont.bodyMedium(),
      ),
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
          fontSize: context.adaptiveFont.bodyMedium(),
        ),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        contentPadding: EdgeInsets.symmetric(
          horizontal: context.responsive.cardPadding(),
          vertical: context.responsive.verticalPadding(),
        ),
      ),
    );
  }
}
