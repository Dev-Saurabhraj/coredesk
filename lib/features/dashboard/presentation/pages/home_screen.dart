import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:coredesk/core/colors/app_colors.dart';
import 'package:coredesk/shared/widgets/widgets.dart';
import 'package:coredesk/shared/widgets/error_widget.dart' as app_error;
import 'package:coredesk/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:coredesk/features/dashboard/presentation/bloc/dashboard_state.dart';
import 'package:coredesk/features/dashboard/presentation/helpers/responsive_helpers.dart';
import 'package:coredesk/features/dashboard/presentation/widgets/enhanced_greeting_card.dart';
import 'package:coredesk/features/dashboard/presentation/widgets/stats_grid.dart';
import 'package:coredesk/features/attendance/presentation/widgets/attendance_card.dart';
import '../bloc/dashboard_event.dart';
import '../widgets/holiday_card.dart';
import 'package:coredesk/features/leaves/presentation/widgets/leave_card.dart';

class HomeScreen extends StatefulWidget {
  final String token;

  const HomeScreen({super.key, required this.token});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _showNotificationsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppColors.surfaceColor,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Notifications',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _buildNotificationItem(context, Icons.check_circle, 'Attendance Marked', 'Your attendance was marked today', AppColors.successColor),
              const SizedBox(height: 12),
              _buildNotificationItem(context, Icons.info, 'Leave Request Approved', 'Your leave request has been approved', AppColors.infoColor),
              const SizedBox(height: 12),
              _buildNotificationItem(context, Icons.calendar_today, 'Holiday Reminder', 'Tomorrow is a public holiday', AppColors.warningColor),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Close', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationItem(BuildContext context, IconData icon, String title, String subtitle, Color color) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
          child: Icon(icon, color: color, size: 20),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600)),
              Text(subtitle, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.textSecondary)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: AppColors.primaryColor, size: 18),
          ),
          const SizedBox(width: 12),
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.5,
                ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        if (state is DashboardLoading) {
          final horizontalPadding = ResponsivePadding.getHorizontalPadding(MediaQuery.of(context).size.width);
          return SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(
              horizontalPadding,
              ResponsivePadding.topPadding,
              horizontalPadding,
              ResponsivePadding.bottomPadding + 80,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const LoadingShimmer(height: 104, borderRadius: 24, width: double.infinity),
                _buildSectionTitle('Overview', Icons.dashboard_rounded),
                const SizedBox(height: 12),
                Column(
                  children: [
                    const LoadingShimmer(height: 90, borderRadius: 20, width: double.infinity),
                    const SizedBox(height: 12),
                    const LoadingShimmer(height: 90, borderRadius: 20, width: double.infinity),
                    const SizedBox(height: 12),
                    const LoadingShimmer(height: 90, borderRadius: 20, width: double.infinity),
                  ],
                ),
                const SizedBox(height: 16),
                const LoadingShimmer(height: 70, borderRadius: 12, width: double.infinity),
                const SizedBox(height: 12),
                const LoadingShimmer(height: 70, borderRadius: 12, width: double.infinity),
                const SizedBox(height: 12),
                const LoadingShimmer(height: 70, borderRadius: 12, width: double.infinity),
              ],
            ),
          );
        } else if (state is DashboardSuccess) {
          final horizontalPadding = ResponsivePadding.getHorizontalPadding(MediaQuery.of(context).size.width);

          return RefreshIndicator(
            onRefresh: () async {
              context.read<DashboardBloc>().add(RefreshDashboardEvent(widget.token));
            },
            child: SingleChildScrollView(
              controller: _scrollController,
              padding: EdgeInsets.fromLTRB(
                horizontalPadding,
                ResponsivePadding.topPadding,
                horizontalPadding,
                ResponsivePadding.bottomPadding + 80,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  EnhancedGreetingCard(
                    userName: 'Saurabh',
                    onProfileTap: () {},
                    onNotificationsTap: () => _showNotificationsDialog(context),
                  ),
                  _buildSectionTitle('Overview', Icons.dashboard_rounded),
                  const SizedBox(height: 12),

                  StatsGrid(
                    attendanceCount: state.stats.attendance,
                    leavesCount: state.stats.leaves,
                    requestsCount: state.stats.requests,
                  ),
                  const SizedBox(height: 16),
                  ExpandableCard(
                    title: 'Recent Leaves',
                    isExpanded: false,
                    child: state.leaves.isEmpty
                        ? const EmptyStateWidget(title: 'No leaves', subtitle: 'You have no leave records', icon: Icons.beach_access)
                        : Column(children: state.leaves.take(3).map((leave) => LeaveCard(leave: leave)).toList()),
                  ),
                  ExpandableCard(
                    title: 'Upcoming Holidays',
                    isExpanded: false,
                    child: state.holidays.isEmpty
                        ? const EmptyStateWidget(title: 'No holidays', subtitle: 'No upcoming holidays', icon: Icons.calendar_today)
                        : Column(children: state.holidays.take(3).map((holiday) => HolidayCard(holiday: holiday)).toList()),
                  ),
                  ExpandableCard(
                    title: 'Recent Attendance',
                    isExpanded: false,
                    child: state.attendance.isEmpty
                        ? const EmptyStateWidget(title: 'No records', subtitle: 'No attendance records', icon: Icons.history)
                        : Column(children: state.attendance.take(3).map((att) => AttendanceCard(attendance: att)).toList()),
                  ),
                ],
              ),
            ),
          );
        } else if (state is DashboardError) {
          return app_error.ErrorWidget(message: state.message, onRetry: () {});
        }
        return const SizedBox.shrink();
      },
    );
  }
}
