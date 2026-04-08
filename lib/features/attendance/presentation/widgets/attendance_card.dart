import 'package:flutter/material.dart';
import 'package:coredesk/core/index.dart';
import '../../data/models/attendance_model.dart';

class AttendanceCard extends StatefulWidget {
  final AttendanceModel attendance;

  const AttendanceCard({super.key, required this.attendance});

  @override
  State<AttendanceCard> createState() => _AttendanceCardState();
}

class _AttendanceCardState extends State<AttendanceCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.98).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Color _getStatusColor() {
    switch (widget.attendance.status.toLowerCase()) {
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

  IconData _getLocationIcon(String location) {
    if (location.toLowerCase().contains('remote') ||
        location.toLowerCase().contains('home')) {
      return Icons.home_work_rounded;
    } else if (location.toLowerCase().contains('client')) {
      return Icons.groups_rounded;
    }
    return Icons.business_rounded;
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = _getStatusColor();

    return ScaleTransition(
      scale: _scaleAnimation,
      child: Container(
        margin: EdgeInsets.only(bottom: context.elementSpacing),
        decoration: BoxDecoration(
          color: AppColors.surfaceColor,
          borderRadius: BorderRadius.circular(context.borderRadiusLarge),
          border: Border.all(color: statusColor.withOpacity(0.15), width: 1.2),
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(context.borderRadiusLarge),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: () {
              HapticsService.lightTap();
              _animationController.forward().then((_) {
                _animationController.reverse();
              });
            },
            child: Padding(
              padding: EdgeInsets.all(context.responsive.verticalPadding()),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.date_range_rounded,
                            size: context.responsive.iconSizeSmall(),
                            color: AppColors.textSecondary,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            widget.attendance.date,
                            style: Theme.of(context).textTheme.titleSmall
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: context.adaptiveFont.titleSmall(),
                                  color: AppColors.textPrimary,
                                ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: statusColor.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: statusColor.withOpacity(0.3),
                            width: 0.5,
                          ),
                        ),
                        child: Text(
                          widget.attendance.status,
                          style: Theme.of(context).textTheme.labelSmall
                              ?.copyWith(
                                color: statusColor,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 0.3,
                                fontSize: context.adaptiveFont.labelSmall(),
                              ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: context.elementSpacing),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: statusColor.withOpacity(0.08),
                      border: Border.all(
                        color: statusColor.withOpacity(0.15),
                        width: 0.5,
                      ),
                      borderRadius: BorderRadius.circular(
                        context.borderRadiusMedium,
                      ),
                    ),
                    child: Row(
                      children: [
                        // Check In Block
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.login_rounded,
                                    size: 14,
                                    color: AppColors.successColor.withOpacity(
                                      0.7,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    'Check In',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall
                                        ?.copyWith(
                                          color: AppColors.textSecondary,
                                          fontWeight: FontWeight.w600,
                                          fontSize: context.adaptiveFont
                                              .labelSmall(),
                                        ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Text(
                                widget.attendance.checkIn,
                                style: Theme.of(context).textTheme.bodyLarge
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.successColor,
                                      fontSize: context.adaptiveFont
                                          .bodyLarge(),
                                    ),
                              ),
                            ],
                          ),
                        ),
                        // Timeline connect
                        Container(
                          height: 40,
                          width: 2,
                          decoration: BoxDecoration(
                            color: statusColor.withOpacity(0.35),
                            borderRadius: BorderRadius.circular(1),
                          ),
                        ),
                        // Check Out Block
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.logout_rounded,
                                      size: 14,
                                      color: AppColors.errorColor.withOpacity(
                                        0.7,
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      'Check Out',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall
                                          ?.copyWith(
                                            color: AppColors.textSecondary,
                                            fontWeight: FontWeight.w600,
                                            fontSize: context.adaptiveFont
                                                .labelSmall(),
                                          ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  widget.attendance.checkOut ?? '--:--',
                                  style: Theme.of(context).textTheme.bodyLarge
                                      ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color:
                                            widget.attendance.checkOut != null
                                            ? AppColors.errorColor
                                            : AppColors.textSecondary,
                                        fontSize: context.adaptiveFont
                                            .bodyLarge(),
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (widget.attendance.workHours != null)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor.withOpacity(0.1),
                            border: Border.all(
                              color: AppColors.primaryColor.withOpacity(0.2),
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.timer_outlined,
                                size: 16,
                                color: AppColors.primaryColor,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                widget.attendance.workHours!,
                                style: Theme.of(context).textTheme.bodySmall
                                    ?.copyWith(
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.primaryColor,
                                      fontSize: context.adaptiveFont
                                          .bodySmall(),
                                    ),
                              ),
                            ],
                          ),
                        ),
                      if (widget.attendance.location != null)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: statusColor.withOpacity(0.1),
                            border: Border.all(
                              color: statusColor.withOpacity(0.2),
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                _getLocationIcon(widget.attendance.location!),
                                size: 14,
                                color: statusColor,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                widget.attendance.location!,
                                style: Theme.of(context).textTheme.labelSmall
                                    ?.copyWith(
                                      color: statusColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: context.adaptiveFont
                                          .labelSmall(),
                                    ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                  if (widget.attendance.notes != null &&
                      widget.attendance.notes!.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.textSecondary.withOpacity(0.05),
                        border: Border.all(
                          color: AppColors.borderColor.withOpacity(0.2),
                        ),
                        borderRadius: BorderRadius.circular(
                          context.borderRadiusMedium,
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.sticky_note_2_rounded,
                            size: 16,
                            color: AppColors.textSecondary.withOpacity(0.6),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              widget.attendance.notes!,
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(
                                    color: AppColors.textSecondary,
                                    fontStyle: FontStyle.italic,
                                    height: 1.3,
                                    fontSize: context.adaptiveFont.bodySmall(),
                                  ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
