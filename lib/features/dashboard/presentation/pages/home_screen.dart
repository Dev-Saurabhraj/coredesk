import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:coredesk/core/index.dart';
import 'package:coredesk/shared/widgets/error_widgets.dart' as error_ui;
import 'package:coredesk/shared/widgets/responsive_widgets.dart';
import 'package:coredesk/features/dashboard/presentation/index.dart';
import 'package:coredesk/features/attendance/presentation/index.dart';
import 'package:coredesk/features/leaves/presentation/index.dart';

class HomeScreen extends StatefulWidget {
  final String token;

  const HomeScreen({super.key, required this.token});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ScrollController _scrollController;
  bool _expandedLeaves = false;
  bool _expandedHolidays = false;
  bool _expandedAttendance = false;

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
    HapticsService.lightTap();
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(context.borderRadiusLarge),
        ),
        child: ResponsivePaddingContainer(
          customPadding: EdgeInsets.all(context.cardPadding),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Notifications',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: context.adaptiveFont.titleLarge(),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      HapticsService.lightTap();
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              SizedBox(height: context.elementSpacing),
              _buildNotificationItem(
                context,
                Icons.check_circle,
                'Attendance Marked',
                'Your attendance was marked today',
                AppColors.successColor,
              ),
              SizedBox(height: context.elementSpacing),
              _buildNotificationItem(
                context,
                Icons.info,
                'Leave Request Approved',
                'Your leave request has been approved',
                AppColors.infoColor,
              ),
              SizedBox(height: context.elementSpacing),
              _buildNotificationItem(
                context,
                Icons.calendar_today,
                'Holiday Reminder',
                'Tomorrow is a public holiday',
                AppColors.warningColor,
              ),
              SizedBox(height: context.sectionSpacing),
              ResponsiveButton(
                label: 'Close',
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationItem(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle,
    Color color,
  ) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(context.responsive.verticalPadding()),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(context.borderRadiusMedium),
          ),
          child: Icon(
            icon,
            color: color,
            size: context.responsive.iconSizeSmall(),
          ),
        ),
        SizedBox(width: context.elementSpacing),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: context.adaptiveFont.bodyMedium(),
                ),
              ),
              SizedBox(height: 2),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondary,
                  fontSize: context.adaptiveFont.bodySmall(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        if (state is DashboardLoading) {
          return _buildLoadingState(context);
        } else if (state is DashboardSuccess) {
          return _buildSuccessState(context, state);
        } else if (state is DashboardError) {
          return _buildErrorState(context, state);
        }
        return SizedBox.shrink();
      },
    );
  }

  Widget _buildLoadingState(BuildContext context) {
    return SingleChildScrollView(
      padding: context.screenPadding.copyWith(
        bottom: context.screenPadding.bottom + 80,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 120,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(context.borderRadiusLarge),
            ),
          ),
          SizedBox(height: context.sectionSpacing),
          Text(
            'Overview',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontSize: context.adaptiveFont.titleLarge(),
            ),
          ),
          SizedBox(height: context.elementSpacing),
          _buildShimmerCards(context, 3),
        ],
      ),
    );
  }

  Widget _buildShimmerCards(BuildContext context, int count) {
    return Column(
      children: List.generate(
        count,
        (index) => Padding(
          padding: EdgeInsets.only(bottom: context.elementSpacing),
          child: Container(
            height: 90,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(context.borderRadiusMedium),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSuccessState(BuildContext context, DashboardSuccess state) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<DashboardBloc>().add(RefreshDashboardEvent(widget.token));
      },
      child: SingleChildScrollView(
        controller: _scrollController,
        padding: context.screenPadding.copyWith(
          bottom: context.screenPadding.bottom + 80,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            EnhancedGreetingCard(
              userName: state.user?.fullName ?? 'User',
              onProfileTap: () {},
              onNotificationsTap: () => _showNotificationsDialog(context),
            ),
            SizedBox(height: context.sectionSpacing),
            ResponsiveSection(
              title: 'Overview',
              child: StatsGrid(
                attendanceCount: state.stats.attendance,
                leavesCount: state.stats.leaves,
                requestsCount: state.stats.requests,
              ),
            ),
            SizedBox(height: context.sectionSpacing),
            ResponsiveSection(
              title: 'Recent Leaves',
              onViewMore: _expandedLeaves && state.leaves.length > 1
                  ? () {
                      HapticsService.lightTap();
                      setState(() => _expandedLeaves = false);
                    }
                  : state.leaves.length > 1
                  ? () {
                      HapticsService.lightTap();
                      setState(() => _expandedLeaves = true);
                    }
                  : null,
              child: state.leaves.isEmpty
                  ? error_ui.EmptyStateWidget(
                      title: 'No leaves',
                      subtitle: 'You have no leave records',
                    )
                  : Column(
                      children: _expandedLeaves
                          ? state.leaves
                                .map((leave) => LeaveCard(leave: leave))
                                .toList()
                          : state.leaves
                                .take(1)
                                .map((leave) => LeaveCard(leave: leave))
                                .toList(),
                    ),
            ),
            SizedBox(height: context.sectionSpacing),
            ResponsiveSection(
              title: 'Upcoming Holidays',
              onViewMore: _expandedHolidays && state.holidays.length > 1
                  ? () {
                      HapticsService.lightTap();
                      setState(() => _expandedHolidays = false);
                    }
                  : state.holidays.length > 1
                  ? () {
                      HapticsService.lightTap();
                      setState(() => _expandedHolidays = true);
                    }
                  : null,
              child: state.holidays.isEmpty
                  ? error_ui.EmptyStateWidget(
                      title: 'No holidays',
                      subtitle: 'No upcoming holidays',
                    )
                  : Column(
                      children: _expandedHolidays
                          ? state.holidays
                                .map((holiday) => HolidayCard(holiday: holiday))
                                .toList()
                          : state.holidays
                                .take(1)
                                .map((holiday) => HolidayCard(holiday: holiday))
                                .toList(),
                    ),
            ),
            SizedBox(height: context.sectionSpacing),
            ResponsiveSection(
              title: 'Recent Attendance',
              onViewMore: _expandedAttendance && state.attendance.length > 1
                  ? () {
                      HapticsService.lightTap();
                      setState(() => _expandedAttendance = false);
                    }
                  : state.attendance.length > 1
                  ? () {
                      HapticsService.lightTap();
                      setState(() => _expandedAttendance = true);
                    }
                  : null,
              child: state.attendance.isEmpty
                  ? error_ui.EmptyStateWidget(
                      title: 'No records',
                      subtitle: 'No attendance records',
                    )
                  : Column(
                      children: _expandedAttendance
                          ? state.attendance
                                .map((att) => AttendanceCard(attendance: att))
                                .toList()
                          : state.attendance
                                .take(1)
                                .map((att) => AttendanceCard(attendance: att))
                                .toList(),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, DashboardError state) {
    return Center(
      child: Padding(
        padding: context.screenPadding,
        child: error_ui.ErrorWidget(
          error: UnknownException(message: state.message),
          onRetry: () {
            context.read<DashboardBloc>().add(
              RefreshDashboardEvent(widget.token),
            );
          },
        ),
      ),
    );
  }
}
