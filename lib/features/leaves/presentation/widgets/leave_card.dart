import 'package:flutter/material.dart';
import 'package:coredesk/core/index.dart';
import '../../data/models/leave_model.dart';

class LeaveCard extends StatefulWidget {
  final LeaveModel leave;

  const LeaveCard({super.key, required this.leave});

  @override
  State<LeaveCard> createState() => _LeaveCardState();
}

class _LeaveCardState extends State<LeaveCard>
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
    switch (widget.leave.status.toLowerCase()) {
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

  IconData _getLeaveIcon() {
    final type = widget.leave.type.toLowerCase();
    if (type.contains('sick') || type.contains('medical')) {
      return Icons.local_hospital_rounded;
    } else if (type.contains('casual') || type.contains('personal')) {
      return Icons.co_present_rounded;
    }
    return Icons.flight_takeoff_rounded;
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
              // Future: Navigate to detail
            },
            child: Padding(
              padding: EdgeInsets.all(context.responsive.verticalPadding()),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: statusColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(
                            context.borderRadiusMedium,
                          ),
                          border: Border.all(
                            color: statusColor.withOpacity(0.2),
                            width: 0.5,
                          ),
                        ),
                        child: Icon(
                          _getLeaveIcon(),
                          color: statusColor,
                          size: context.responsive.iconSizeMedium(),
                        ),
                      ),
                      SizedBox(width: context.elementSpacing),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.leave.type,
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.textPrimary,
                                    letterSpacing: -0.3,
                                    fontSize: context.adaptiveFont
                                        .titleMedium(),
                                  ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                Icon(
                                  Icons.calendar_today_rounded,
                                  size: 14,
                                  color: AppColors.textSecondary.withOpacity(
                                    0.6,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  widget.leave.startDate,
                                  style: Theme.of(context).textTheme.bodySmall
                                      ?.copyWith(
                                        color: AppColors.textSecondary,
                                        fontSize: context.adaptiveFont
                                            .bodySmall(),
                                      ),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  height: 4,
                                  width: 4,
                                  decoration: BoxDecoration(
                                    color: AppColors.textSecondary.withOpacity(
                                      0.4,
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Icon(
                                  Icons.schedule_rounded,
                                  size: 14,
                                  color: statusColor.withOpacity(0.7),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  widget.leave.duration ?? "N/A",
                                  style: Theme.of(context).textTheme.bodySmall
                                      ?.copyWith(
                                        color: statusColor,
                                        fontWeight: FontWeight.w600,
                                        fontSize: context.adaptiveFont
                                            .bodySmall(),
                                      ),
                                ),
                              ],
                            ),
                          ],
                        ),
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
                          widget.leave.status,
                          style: Theme.of(context).textTheme.labelSmall
                              ?.copyWith(
                                color: statusColor,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.3,
                                fontSize: context.adaptiveFont.labelSmall(),
                              ),
                        ),
                      ),
                    ],
                  ),
                  if (widget.leave.reason != null &&
                      widget.leave.reason!.isNotEmpty) ...[
                    Padding(
                      padding: const EdgeInsets.only(top: 14, bottom: 10),
                      child: Container(
                        height: 1,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AppColors.borderColor.withOpacity(0.3),
                              AppColors.borderColor.withOpacity(0.0),
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.description_rounded,
                          size: 16,
                          color: AppColors.textSecondary.withOpacity(0.6),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            widget.leave.reason!,
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  color: AppColors.textSecondary,
                                  fontStyle: FontStyle.italic,
                                  height: 1.4,
                                  fontSize: context.adaptiveFont.bodySmall(),
                                ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
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
