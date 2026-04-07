import 'package:flutter/material.dart';
import 'package:coredesk/core/colors/app_colors.dart';
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
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: AppColors.dividerColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                attendance.date,
                style: Theme.of(
                  context,
                ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _getStatusColor().withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  attendance.status,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: _getStatusColor(),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.access_time, size: 14, color: AppColors.textSecondary),
              const SizedBox(width: 4),
              Text(
                'In: ${attendance.checkIn}',
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: AppColors.textSecondary),
              ),
              if (attendance.checkOut != null) ...[
                const SizedBox(width: 16),
                Icon(Icons.logout, size: 14, color: AppColors.textSecondary),
                const SizedBox(width: 4),
                Text(
                  'Out: ${attendance.checkOut}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
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
