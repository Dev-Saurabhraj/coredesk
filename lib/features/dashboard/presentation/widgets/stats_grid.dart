import 'package:flutter/material.dart';
import 'package:coredesk/shared/widgets/stat_card.dart';
import 'package:coredesk/core/colors/app_colors.dart';

class StatsGrid extends StatelessWidget {
  final int attendanceCount;
  final int leavesCount;
  final int requestsCount;

  const StatsGrid({
    super.key,
    required this.attendanceCount,
    required this.leavesCount,
    required this.requestsCount,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StatCard(
          title: 'Attendance',
          value: attendanceCount.toString(),
          subtitle: 'Days present this month',
          icon: Icons.check_circle_outline,
          iconColor: AppColors.successColor,
        ),
        const SizedBox(height: 12),
        StatCard(
          title: 'Leaves',
          value: leavesCount.toString(),
          subtitle: 'Approved holidays taken',
          icon: Icons.beach_access_outlined,
          iconColor: AppColors.secondaryColor,
        ),
        const SizedBox(height: 12),
        StatCard(
          title: 'Requests',
          value: requestsCount.toString(),
          subtitle: 'Awaiting HR approval',
          icon: Icons.mail_outline,
          iconColor: AppColors.warningColor,
        ),
      ],
    );
  }
}
