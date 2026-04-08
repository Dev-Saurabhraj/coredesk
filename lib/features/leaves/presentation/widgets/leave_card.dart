 import 'package:flutter/material.dart';
import 'package:coredesk/core/index.dart';
import '../../data/models/leave_model.dart';

class LeaveCard extends StatelessWidget {
  final LeaveModel leave;

  const LeaveCard({super.key, required this.leave});

  Color _getStatusColor() {
    switch (leave.status.toLowerCase()) {
      case 'approved':
        return AppColors.successColor;
      case 'pending':
        return AppColors.warningColor;
      case 'rejected':
        return AppColors.errorColor;
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
                  leave.type,
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
                  leave.status,
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
                Icons.calendar_today,
                size: context.responsive.iconSizeSmall(),
                color: AppColors.primaryColor,
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  '${leave.startDate} to ${leave.endDate}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w500,
                        fontSize: context.adaptiveFont.bodySmall(),
                      ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
