import 'package:flutter/material.dart';
import 'package:coredesk/core/index.dart'; // Standardized import mapping
import '../../data/models/holiday_model.dart';

class HolidayCard extends StatelessWidget {
  final HolidayModel holiday;

  const HolidayCard({super.key, required this.holiday});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.responsive.verticalPadding()),
      margin: EdgeInsets.only(bottom: context.elementSpacing),
      decoration: BoxDecoration(
        color: AppColors.secondaryColor.withOpacity(0.08),
        borderRadius: BorderRadius.circular(context.borderRadiusMedium),
        border: Border.all(color: AppColors.secondaryColor.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: AppColors.secondaryColor.withOpacity(0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  holiday.name,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: context.adaptiveFont.titleSmall(),
                      ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: context.elementSpacing / 2),
                Row(
                  children: [
                    Icon(
                      Icons.event,
                      size: context.responsive.iconSizeSmall(),
                      color: AppColors.secondaryColor,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      holiday.date,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.textSecondary,
                            fontWeight: FontWeight.w500,
                            fontSize: context.adaptiveFont.bodySmall(),
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(context.responsive.verticalPadding() * 0.8),
            decoration: BoxDecoration(
              color: AppColors.secondaryColor.withOpacity(0.15),
              borderRadius: BorderRadius.circular(context.borderRadiusMedium),
            ),
            child: Icon(
              Icons.celebration_rounded,
              color: AppColors.secondaryColor,
              size: context.responsive.iconSizeMedium(),
            ),
          ),
        ],
      ),
    );
  }
}
