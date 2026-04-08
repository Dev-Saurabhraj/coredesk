/// Helper class for managing responsive breakpoints and sizing
class ResponsiveBreakpoints {
  static const double extraSmallPhones = 360;
  static const double smallPhones = 480;
  static const double mediumPhones = 720;
  static const double largePhones = 900;

  /// Determine device size category based on screen width
  static DeviceSize getDeviceSize(double screenWidth) {
    if (screenWidth < extraSmallPhones) {
      return DeviceSize.extraSmall;
    } else if (screenWidth < smallPhones) {
      return DeviceSize.small;
    } else if (screenWidth < mediumPhones) {
      return DeviceSize.medium;
    } else {
      return DeviceSize.large;
    }
  }
}

/// Enum for device size categories
enum DeviceSize { extraSmall, small, medium, large }

/// Responsive sizes for StatCard widget
class StatCardResponsiveSizes {
  final double padding;
  final double iconSize;
  final double iconContainerPadding;
  final double titleFontSize;
  final double valueFontSize;
  final double subtitleFontSize;
  final double borderRadius;
  final double spacing;

  const StatCardResponsiveSizes({
    required this.padding,
    required this.iconSize,
    required this.iconContainerPadding,
    required this.titleFontSize,
    required this.valueFontSize,
    required this.subtitleFontSize,
    required this.borderRadius,
    required this.spacing,
  });

  /// Get responsive sizes based on device type
  factory StatCardResponsiveSizes.fromDeviceSize(DeviceSize deviceSize) {
    switch (deviceSize) {
      case DeviceSize.extraSmall:
        // Extra small phones (< 360)
        return const StatCardResponsiveSizes(
          padding: 12,
          iconSize: 18,
          iconContainerPadding: 6,
          titleFontSize: 12,
          valueFontSize: 20,
          subtitleFontSize: 10,
          borderRadius: 12,
          spacing: 8,
        );
      case DeviceSize.small:
        // Small phones (360 - 480)
        return const StatCardResponsiveSizes(
          padding: 14,
          iconSize: 20,
          iconContainerPadding: 7,
          titleFontSize: 13,
          valueFontSize: 24,
          subtitleFontSize: 11,
          borderRadius: 14,
          spacing: 10,
        );
      case DeviceSize.medium:
        // Medium phones (480 - 720)
        return const StatCardResponsiveSizes(
          padding: 16,
          iconSize: 22,
          iconContainerPadding: 8,
          titleFontSize: 14,
          valueFontSize: 28,
          subtitleFontSize: 12,
          borderRadius: 16,
          spacing: 12,
        );
      case DeviceSize.large:
        // Large phones and tablets (720+)
        return const StatCardResponsiveSizes(
          padding: 18,
          iconSize: 24,
          iconContainerPadding: 10,
          titleFontSize: 15,
          valueFontSize: 32,
          subtitleFontSize: 13,
          borderRadius: 18,
          spacing: 14,
        );
    }
  }
}

/// Responsive grid configuration for dashboard stats
class GridResponsiveConfig {
  final int crossAxisCount;
  final double childAspectRatio;
  final double mainAxisSpacing;
  final double crossAxisSpacing;

  const GridResponsiveConfig({
    required this.crossAxisCount,
    required this.childAspectRatio,
    required this.mainAxisSpacing,
    required this.crossAxisSpacing,
  });

  /// Get grid configuration based on device size
  factory GridResponsiveConfig.fromScreenWidth(double screenWidth) {
    final deviceSize = ResponsiveBreakpoints.getDeviceSize(screenWidth);

    switch (deviceSize) {
      case DeviceSize.extraSmall:
        // Extra small phones (< 360): 2 columns
        return const GridResponsiveConfig(
          crossAxisCount: 2,
          childAspectRatio: 1.1,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        );
      case DeviceSize.small:
        // Small phones (360 - 480): 2 columns
        return const GridResponsiveConfig(
          crossAxisCount: 2,
          childAspectRatio: 1.0,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        );
      case DeviceSize.medium:
        // Medium phones (480 - 720): 3 columns
        return const GridResponsiveConfig(
          crossAxisCount: 3,
          childAspectRatio: 0.95,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
        );
      case DeviceSize.large:
        // Large phones and tablets (720+): 3 columns
        return const GridResponsiveConfig(
          crossAxisCount: 3,
          childAspectRatio: 1.1,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
        );
    }
  }
}

/// Responsive padding and layout helpers
class ResponsivePadding {
  /// Get horizontal padding based on screen width
  static double getHorizontalPadding(double screenWidth) {
    if (screenWidth < ResponsiveBreakpoints.smallPhones) {
      return 12.0;
    }
    return 16.0;
  }

  /// Get top padding - increased for better spacing from phone top
  static const double topPadding = 32.0;

  /// Get bottom padding
  static const double bottomPadding = 16.0;
}

/// Shimmer card responsive sizing
class ShimmerCardResponsiveSizes {
  final double padding;
  final double borderRadius;
  final double titleWidth;
  final double valueHeight;
  final double subtitleWidth;
  final double spacing;
  final double iconSize;
  final double iconContainerPadding;

  const ShimmerCardResponsiveSizes({
    required this.padding,
    required this.borderRadius,
    required this.titleWidth,
    required this.valueHeight,
    required this.subtitleWidth,
    required this.spacing,
    required this.iconSize,
    required this.iconContainerPadding,
  });

  /// Get shimmer sizes based on device size
  factory ShimmerCardResponsiveSizes.fromDeviceSize(DeviceSize deviceSize) {
    switch (deviceSize) {
      case DeviceSize.extraSmall:
        return const ShimmerCardResponsiveSizes(
          padding: 12,
          borderRadius: 12,
          titleWidth: 60,
          valueHeight: 20,
          subtitleWidth: 120,
          spacing: 8,
          iconSize: 16,
          iconContainerPadding: 6,
        );
      case DeviceSize.small:
        return const ShimmerCardResponsiveSizes(
          padding: 14,
          borderRadius: 14,
          titleWidth: 70,
          valueHeight: 22,
          subtitleWidth: 130,
          spacing: 10,
          iconSize: 18,
          iconContainerPadding: 7,
        );
      case DeviceSize.medium:
        return const ShimmerCardResponsiveSizes(
          padding: 16,
          borderRadius: 16,
          titleWidth: 80,
          valueHeight: 26,
          subtitleWidth: 140,
          spacing: 12,
          iconSize: 20,
          iconContainerPadding: 8,
        );
      case DeviceSize.large:
        return const ShimmerCardResponsiveSizes(
          padding: 18,
          borderRadius: 18,
          titleWidth: 90,
          valueHeight: 30,
          subtitleWidth: 150,
          spacing: 14,
          iconSize: 22,
          iconContainerPadding: 10,
        );
    }
  }
}
