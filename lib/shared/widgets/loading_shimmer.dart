import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:coredesk/core/colors/app_colors.dart';
import 'package:coredesk/features/dashboard/presentation/helpers/responsive_helpers.dart';

class LoadingShimmer extends StatelessWidget {
  final double height;
  final double? width;
  final double borderRadius;

  const LoadingShimmer({
    super.key,
    this.height = 16,
    this.width,
    this.borderRadius = 8,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.dividerColor,
      highlightColor: AppColors.borderColor,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: AppColors.dividerColor,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}

class ShimmerStatCard extends StatelessWidget {
  const ShimmerStatCard({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final deviceSize = ResponsiveBreakpoints.getDeviceSize(screenWidth);
    final sizes = ShimmerCardResponsiveSizes.fromDeviceSize(deviceSize);

    return Container(
      padding: EdgeInsets.all(sizes.padding),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.dividerColor, AppColors.borderColor],
        ),
        borderRadius: BorderRadius.circular(sizes.borderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              LoadingShimmer(width: sizes.titleWidth, height: 12),
              Container(
                padding: EdgeInsets.all(sizes.iconContainerPadding),
                decoration: BoxDecoration(
                  color: AppColors.borderColor,
                  borderRadius: BorderRadius.circular(
                    sizes.iconContainerPadding * 1.5,
                  ),
                ),
                child: LoadingShimmer(
                  width: sizes.iconSize,
                  height: sizes.iconSize,
                ),
              ),
            ],
          ),
          SizedBox(height: sizes.spacing),
          LoadingShimmer(width: 50, height: sizes.valueHeight),
          SizedBox(height: sizes.spacing / 2),
          LoadingShimmer(width: sizes.subtitleWidth, height: 10),
        ],
      ),
    );
  }
}
