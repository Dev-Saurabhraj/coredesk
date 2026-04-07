import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:coredesk/core/colors/app_colors.dart';
import 'package:coredesk/core/responsive/responsive_extensions.dart';
import 'package:coredesk/shared/widgets/responsive_widgets.dart';
import 'package:coredesk/shared/widgets/error_widgets.dart' as error_ui;
import 'package:coredesk/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:coredesk/features/dashboard/presentation/bloc/dashboard_state.dart';
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
                    onPressed: () => Navigator.pop(context),
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

  Widget _buildSectionTitle(BuildContext context, String title, IconData icon) {
    return ResponsiveSection(title: title, child: SizedBox.shrink());
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
              userName: 'Saurabh',
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
              child: state.leaves.isEmpty
                  ? EmptyStateWidget(
                      title: 'No leaves',
                      subtitle: 'You have no leave records',
                    )
                  : Column(
                      children: state.leaves
                          .take(3)
                          .map((leave) => LeaveCard(leave: leave))
                          .toList(),
                    ),
            ),
            SizedBox(height: context.sectionSpacing),
            ResponsiveSection(
              title: 'Upcoming Holidays',
              child: state.holidays.isEmpty
                  ? EmptyStateWidget(
                      title: 'No holidays',
                      subtitle: 'No upcoming holidays',
                    )
                  : Column(
                      children: state.holidays
                          .take(3)
                          .map((holiday) => HolidayCard(holiday: holiday))
                          .toList(),
                    ),
            ),
            SizedBox(height: context.sectionSpacing),
            ResponsiveSection(
              title: 'Recent Attendance',
              child: state.attendance.isEmpty
                  ? EmptyStateWidget(
                      title: 'No records',
                      subtitle: 'No attendance records',
                    )
                  : Column(
                      children: state.attendance
                          .take(3)
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
        child: ErrorWidget(
          error: state.exception,
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
