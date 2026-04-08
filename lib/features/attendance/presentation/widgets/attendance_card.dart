import 'package:flutter/material.dart';
import 'package:coredesk/core/index.dart';
import '../../data/models/attendance_model.dart';

class AttendanceCard extends StatelessWidget {
  final AttendanceModel attendance;

  const AttendanceCard({super.key, required this.attendance});

  Color _getStatusColor() {
    switch (attendance.status.toLowerCase()) {
      case 'present':
        return AppColors.successColor;
      case 'absent':
        return AppColors.errorColor;
      case 'half day':
        return AppColors.warningColor;
      default:
        return AppColors.infoColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.responsive.verticalPadding()),
      margin: EdgeInsets.only(bottom: context.elementSpacing),
      decoration: BoxDecoration(
        color: AppColors.surfaceColor, // Switched to surface color for a cleaner modern look
        borderRadius: BorderRadius.circular(context.borderRadiusMedium),
        border: Border.all(color: AppColors.borderColor.withOpacity(0.5)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  attendance.date,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: context.adaptiveFont.titleSmall(),
                      ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: _getStatusColor().withOpacity(0.1),
                  borderRadius: BorderRadius.circular(context.borderRadiusSmall),
                ),
                child: Text(
                  attendance.status,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: _getStatusColor(),
                        fontWeight: FontWeight.w700,
                        fontSize: context.adaptiveFont.bodySmall(),
                      ),
                ),
              ),
            ],
          ),
          SizedBox(height: context.elementSpacing),
          Row(
            children: [
              Icon(
                Icons.access_time,
                size: context.responsive.iconSizeSmall(),
                color: AppColors.primaryColor,
              ),
              const SizedBox(width: 6),
              Text(
                'In: ${attendance.checkIn}',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w500,
                      fontSize: context.adaptiveFont.bodySmall(),
                    ),
              ),
              if (attendance.checkOut != null) ...[
                const Spacer(),
                Icon(
                  Icons.logout,
                  size: context.responsive.iconSizeSmall(),
                  color: AppColors.textSecondary,
                ),
                const SizedBox(width: 6),
                Text(
                  'Out: ${attendance.checkOut}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w500,
                        fontSize: context.adaptiveFont.bodySmall(),
                      ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
