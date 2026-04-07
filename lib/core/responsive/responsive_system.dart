import 'package:flutter/material.dart';

enum DeviceCategory { extraSmall, small, medium, large }

class ResponsiveSystem {
  final BuildContext context;

  ResponsiveSystem(this.context);

  double get screenWidth => MediaQuery.of(context).size.width;

  double get screenHeight => MediaQuery.of(context).size.height;

  double get devicePixelRatio => MediaQuery.of(context).devicePixelRatio;

  bool get isPortrait =>
      MediaQuery.of(context).orientation == Orientation.portrait;

  bool get isLandscape =>
      MediaQuery.of(context).orientation == Orientation.landscape;

  DeviceCategory get deviceCategory => _getDeviceCategory();

  DeviceCategory _getDeviceCategory() {
    if (screenWidth < 360) return DeviceCategory.extraSmall;
    if (screenWidth < 480) return DeviceCategory.small;
    if (screenWidth < 720) return DeviceCategory.medium;
    return DeviceCategory.large;
  }

  double horizontalPadding() {
    switch (deviceCategory) {
      case DeviceCategory.extraSmall:
        return 12;
      case DeviceCategory.small:
        return 14;
      case DeviceCategory.medium:
        return 16;
      case DeviceCategory.large:
        return 18;
    }
  }

  double verticalPadding() {
    switch (deviceCategory) {
      case DeviceCategory.extraSmall:
        return 8;
      case DeviceCategory.small:
        return 10;
      case DeviceCategory.medium:
        return 12;
      case DeviceCategory.large:
        return 14;
    }
  }

  double headerPadding() {
    switch (deviceCategory) {
      case DeviceCategory.extraSmall:
        return 24;
      case DeviceCategory.small:
        return 28;
      case DeviceCategory.medium:
        return 32;
      case DeviceCategory.large:
        return 36;
    }
  }

  double sectionSpacing() {
    switch (deviceCategory) {
      case DeviceCategory.extraSmall:
        return 16;
      case DeviceCategory.small:
        return 18;
      case DeviceCategory.medium:
        return 20;
      case DeviceCategory.large:
        return 24;
    }
  }

  double elementSpacing() {
    switch (deviceCategory) {
      case DeviceCategory.extraSmall:
        return 8;
      case DeviceCategory.small:
        return 10;
      case DeviceCategory.medium:
        return 12;
      case DeviceCategory.large:
        return 14;
    }
  }

  double cardPadding() {
    switch (deviceCategory) {
      case DeviceCategory.extraSmall:
        return 14;
      case DeviceCategory.small:
        return 16;
      case DeviceCategory.medium:
        return 18;
      case DeviceCategory.large:
        return 20;
    }
  }

  double borderRadiusLarge() {
    switch (deviceCategory) {
      case DeviceCategory.extraSmall:
        return 18;
      case DeviceCategory.small:
        return 20;
      case DeviceCategory.medium:
        return 22;
      case DeviceCategory.large:
        return 24;
    }
  }

  double borderRadiusMedium() {
    switch (deviceCategory) {
      case DeviceCategory.extraSmall:
        return 12;
      case DeviceCategory.small:
        return 13;
      case DeviceCategory.medium:
        return 14;
      case DeviceCategory.large:
        return 16;
    }
  }

  double borderRadiusSmall() {
    switch (deviceCategory) {
      case DeviceCategory.extraSmall:
        return 8;
      case DeviceCategory.small:
        return 8;
      case DeviceCategory.medium:
        return 9;
      case DeviceCategory.large:
        return 10;
    }
  }

  double iconSizeXSmall() {
    switch (deviceCategory) {
      case DeviceCategory.extraSmall:
        return 16;
      case DeviceCategory.small:
        return 18;
      case DeviceCategory.medium:
        return 20;
      case DeviceCategory.large:
        return 22;
    }
  }

  double iconSizeSmall() {
    switch (deviceCategory) {
      case DeviceCategory.extraSmall:
        return 20;
      case DeviceCategory.small:
        return 22;
      case DeviceCategory.medium:
        return 24;
      case DeviceCategory.large:
        return 28;
    }
  }

  double iconSizeMedium() {
    switch (deviceCategory) {
      case DeviceCategory.extraSmall:
        return 28;
      case DeviceCategory.small:
        return 30;
      case DeviceCategory.medium:
        return 32;
      case DeviceCategory.large:
        return 36;
    }
  }

  double iconSizeLarge() {
    switch (deviceCategory) {
      case DeviceCategory.extraSmall:
        return 40;
      case DeviceCategory.small:
        return 44;
      case DeviceCategory.medium:
        return 48;
      case DeviceCategory.large:
        return 56;
    }
  }

  int get gridColumnsPortrait {
    switch (deviceCategory) {
      case DeviceCategory.extraSmall:
      case DeviceCategory.small:
        return 2;
      case DeviceCategory.medium:
        return 3;
      case DeviceCategory.large:
        return 4;
    }
  }

  int get gridColumnsLandscape {
    switch (deviceCategory) {
      case DeviceCategory.extraSmall:
      case DeviceCategory.small:
        return 3;
      case DeviceCategory.medium:
        return 4;
      case DeviceCategory.large:
        return 5;
    }
  }

  int get gridColumns {
    return isPortrait ? gridColumnsPortrait : gridColumnsLandscape;
  }

  double get gridSpacing {
    switch (deviceCategory) {
      case DeviceCategory.extraSmall:
        return 10;
      case DeviceCategory.small:
        return 12;
      case DeviceCategory.medium:
        return 14;
      case DeviceCategory.large:
        return 16;
    }
  }

  double containerHeight(double baseHeight) {
    return baseHeight * (screenHeight / 800);
  }

  double containerWidth(double baseWidth) {
    return baseWidth * (screenWidth / 360);
  }

  double scale(double size) {
    return size * (screenWidth / 360);
  }

  EdgeInsets screenPadding() {
    return EdgeInsets.only(
      left: horizontalPadding(),
      right: horizontalPadding(),
      top: headerPadding(),
      bottom: verticalPadding(),
    );
  }

  EdgeInsets cardMargin() {
    return EdgeInsets.all(elementSpacing());
  }

  BoxConstraints get maxScreenConstraints {
    return BoxConstraints(maxWidth: screenWidth, maxHeight: screenHeight);
  }
}

class AdaptiveFont {
  final BuildContext context;

  AdaptiveFont(this.context);

  ResponsiveSystem get responsive => ResponsiveSystem(context);

  double displayLarge() {
    switch (responsive.deviceCategory) {
      case DeviceCategory.extraSmall:
        return 28;
      case DeviceCategory.small:
        return 32;
      case DeviceCategory.medium:
        return 36;
      case DeviceCategory.large:
        return 42;
    }
  }

  double displayMedium() {
    switch (responsive.deviceCategory) {
      case DeviceCategory.extraSmall:
        return 24;
      case DeviceCategory.small:
        return 28;
      case DeviceCategory.medium:
        return 32;
      case DeviceCategory.large:
        return 36;
    }
  }

  double displaySmall() {
    switch (responsive.deviceCategory) {
      case DeviceCategory.extraSmall:
        return 20;
      case DeviceCategory.small:
        return 22;
      case DeviceCategory.medium:
        return 24;
      case DeviceCategory.large:
        return 28;
    }
  }

  double headlineLarge() {
    switch (responsive.deviceCategory) {
      case DeviceCategory.extraSmall:
        return 18;
      case DeviceCategory.small:
        return 20;
      case DeviceCategory.medium:
        return 22;
      case DeviceCategory.large:
        return 26;
    }
  }

  double headlineMedium() {
    switch (responsive.deviceCategory) {
      case DeviceCategory.extraSmall:
        return 16;
      case DeviceCategory.small:
        return 18;
      case DeviceCategory.medium:
        return 20;
      case DeviceCategory.large:
        return 24;
    }
  }

  double headlineSmall() {
    switch (responsive.deviceCategory) {
      case DeviceCategory.extraSmall:
        return 14;
      case DeviceCategory.small:
        return 15;
      case DeviceCategory.medium:
        return 16;
      case DeviceCategory.large:
        return 18;
    }
  }

  double titleLarge() {
    switch (responsive.deviceCategory) {
      case DeviceCategory.extraSmall:
        return 16;
      case DeviceCategory.small:
        return 17;
      case DeviceCategory.medium:
        return 18;
      case DeviceCategory.large:
        return 20;
    }
  }

  double titleMedium() {
    switch (responsive.deviceCategory) {
      case DeviceCategory.extraSmall:
        return 14;
      case DeviceCategory.small:
        return 15;
      case DeviceCategory.medium:
        return 16;
      case DeviceCategory.large:
        return 18;
    }
  }

  double titleSmall() {
    switch (responsive.deviceCategory) {
      case DeviceCategory.extraSmall:
        return 12;
      case DeviceCategory.small:
        return 13;
      case DeviceCategory.medium:
        return 14;
      case DeviceCategory.large:
        return 16;
    }
  }

  double bodyLarge() {
    switch (responsive.deviceCategory) {
      case DeviceCategory.extraSmall:
        return 14;
      case DeviceCategory.small:
        return 15;
      case DeviceCategory.medium:
        return 16;
      case DeviceCategory.large:
        return 18;
    }
  }

  double bodyMedium() {
    switch (responsive.deviceCategory) {
      case DeviceCategory.extraSmall:
        return 12;
      case DeviceCategory.small:
        return 13;
      case DeviceCategory.medium:
        return 14;
      case DeviceCategory.large:
        return 16;
    }
  }

  double bodySmall() {
    switch (responsive.deviceCategory) {
      case DeviceCategory.extraSmall:
        return 10;
      case DeviceCategory.small:
        return 11;
      case DeviceCategory.medium:
        return 12;
      case DeviceCategory.large:
        return 14;
    }
  }

  double labelLarge() {
    switch (responsive.deviceCategory) {
      case DeviceCategory.extraSmall:
        return 12;
      case DeviceCategory.small:
        return 13;
      case DeviceCategory.medium:
        return 14;
      case DeviceCategory.large:
        return 16;
    }
  }

  double labelMedium() {
    switch (responsive.deviceCategory) {
      case DeviceCategory.extraSmall:
        return 11;
      case DeviceCategory.small:
        return 12;
      case DeviceCategory.medium:
        return 13;
      case DeviceCategory.large:
        return 14;
    }
  }

  double labelSmall() {
    switch (responsive.deviceCategory) {
      case DeviceCategory.extraSmall:
        return 10;
      case DeviceCategory.small:
        return 10;
      case DeviceCategory.medium:
        return 11;
      case DeviceCategory.large:
        return 12;
    }
  }
}
