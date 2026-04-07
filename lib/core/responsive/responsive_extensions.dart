import 'package:flutter/material.dart';
import 'responsive_system.dart';

extension ResponsiveExtension on BuildContext {
  ResponsiveSystem get responsive => ResponsiveSystem(this);

  AdaptiveFont get adaptiveFont => AdaptiveFont(this);

  double get screenWidth => MediaQuery.of(this).size.width;

  double get screenHeight => MediaQuery.of(this).size.height;

  double get horizontalPadding => responsive.horizontalPadding();

  double get verticalPadding => responsive.verticalPadding();

  double get headerPadding => responsive.headerPadding();

  double get sectionSpacing => responsive.sectionSpacing();

  double get elementSpacing => responsive.elementSpacing();

  double get cardPadding => responsive.cardPadding();

  double get borderRadiusLarge => responsive.borderRadiusLarge();

  double get borderRadiusMedium => responsive.borderRadiusMedium();

  double get borderRadiusSmall => responsive.borderRadiusSmall();

  EdgeInsets get screenPadding => responsive.screenPadding();

  EdgeInsets get cardMargin => responsive.cardMargin();

  DeviceCategory get deviceCategory => responsive.deviceCategory;

  bool get isSmallScreen => screenWidth < 480;

  bool get isMediumScreen => screenWidth >= 480 && screenWidth < 720;

  bool get isLargeScreen => screenWidth >= 720;

  bool get isPortrait =>
      MediaQuery.of(this).orientation == Orientation.portrait;

  bool get isLandscape =>
      MediaQuery.of(this).orientation == Orientation.landscape;
}

class ResponsiveWidget extends StatelessWidget {
  final Widget? extraSmallChild;
  final Widget? smallChild;
  final Widget? mediumChild;
  final Widget? largeChild;
  final Widget? defaultChild;

  const ResponsiveWidget({
    Key? key,
    this.extraSmallChild,
    this.smallChild,
    this.mediumChild,
    this.largeChild,
    this.defaultChild,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final category = context.deviceCategory;

    switch (category) {
      case DeviceCategory.extraSmall:
        return extraSmallChild ??
            smallChild ??
            defaultChild ??
            SizedBox.shrink();
      case DeviceCategory.small:
        return smallChild ?? defaultChild ?? SizedBox.shrink();
      case DeviceCategory.medium:
        return mediumChild ?? defaultChild ?? SizedBox.shrink();
      case DeviceCategory.large:
        return largeChild ?? mediumChild ?? defaultChild ?? SizedBox.shrink();
    }
  }
}

class ResponsiveLayoutBuilder extends StatelessWidget {
  final Widget Function(BuildContext) builder;

  const ResponsiveLayoutBuilder({Key? key, required this.builder})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return builder(context);
  }
}

class FittedSpacing extends StatelessWidget {
  final double baseSpacing;
  final Axis direction;
  final List<Widget> children;

  const FittedSpacing({
    Key? key,
    required this.baseSpacing,
    this.direction = Axis.vertical,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final spacing = context.responsive.scale(baseSpacing);

    if (direction == Axis.vertical) {
      return Column(
        children: children
            .expand(
              (child) => [
                child,
                if (children.indexOf(child) != children.length - 1)
                  SizedBox(height: spacing),
              ],
            )
            .toList(),
      );
    }

    return Row(
      children: children
          .expand(
            (child) => [
              child,
              if (children.indexOf(child) != children.length - 1)
                SizedBox(width: spacing),
            ],
          )
          .toList(),
    );
  }
}

class AspectRatioFitted extends StatelessWidget {
  final double aspectRatio;
  final Widget child;

  const AspectRatioFitted({
    Key? key,
    required this.aspectRatio,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(aspectRatio: aspectRatio, child: child);
  }
}

class MaxWidthContainer extends StatelessWidget {
  final double maxWidth;
  final Widget child;
  final AlignmentGeometry alignment;
  final EdgeInsets padding;

  const MaxWidthContainer({
    Key? key,
    required this.maxWidth,
    required this.child,
    this.alignment = Alignment.center,
    this.padding = EdgeInsets.zero,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Padding(padding: padding, child: child),
      ),
    );
  }
}

class ResponsiveGrid extends StatelessWidget {
  final List<Widget> children;
  final int Function(BuildContext) columnsBuilder;
  final double spacing;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;

  const ResponsiveGrid({
    Key? key,
    required this.children,
    required this.columnsBuilder,
    this.spacing = 0,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.start,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final columns = columnsBuilder(context);

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columns,
        mainAxisSpacing: spacing,
        crossAxisSpacing: spacing,
      ),
      itemCount: children.length,
      itemBuilder: (context, index) => children[index],
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
    );
  }
}
