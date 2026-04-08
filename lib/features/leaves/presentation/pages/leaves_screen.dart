import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:coredesk/core/index.dart';
import 'package:coredesk/shared/widgets/widgets.dart';
import 'package:coredesk/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:coredesk/features/dashboard/presentation/bloc/dashboard_state.dart';
import 'package:coredesk/features/dashboard/presentation/bloc/dashboard_event.dart';
import 'package:coredesk/features/dashboard/presentation/helpers/responsive_helpers.dart';
import 'package:coredesk/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:coredesk/features/authentication/presentation/bloc/auth_state.dart';
import '../widgets/leave_card.dart';

class LeavesScreen extends StatefulWidget {
  const LeavesScreen({super.key});

  @override
  State<LeavesScreen> createState() => _LeavesScreenState();
}

class _LeavesScreenState extends State<LeavesScreen> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 100) {
      final state = context.read<DashboardBloc>().state;
      if (state is DashboardSuccess && !state.isLoadingMoreLeaves && !state.hasReachedMaxLeaves) {
        final authState = context.read<AuthBloc>().state;
        if (authState is AuthSuccess) {
          context.read<DashboardBloc>().add(LoadMoreLeavesEvent(authState.auth.token));
        }
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        if (state is DashboardSuccess) {
          final screenWidth = MediaQuery.of(context).size.width;
          final horizontalPadding = ResponsivePadding.getHorizontalPadding(
            screenWidth,
          );

          final total = state.leaves.length;
          final approved = state.leaves
              .where((l) => l.status.toLowerCase() == 'approved')
              .length;
          final pending = state.leaves
              .where((l) => l.status.toLowerCase() == 'pending')
              .length;

          return SingleChildScrollView(
            controller: _scrollController,
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                horizontalPadding,
                ResponsivePadding.topPadding,
                horizontalPadding,
                ResponsivePadding.bottomPadding + 80,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Leaves',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _buildMiniStatCard(
                          context,
                          'Total',
                          '$total',
                          AppColors.primaryColor,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildMiniStatCard(
                          context,
                          'Approved',
                          '$approved',
                          AppColors.successColor,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildMiniStatCard(
                          context,
                          'Pending',
                          '$pending',
                          AppColors.warningColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  if (state.leaves.isEmpty)
                    EmptyStateWidget(
                      title: 'No leaves',
                      subtitle: 'You have no leave records',
                      icon: Icons.beach_access_outlined,
                    )
                  else
                    Column(
                      children: state.leaves
                          .map((leave) => LeaveCard(leave: leave))
                          .toList(),
                    ),
                  if (state.isLoadingMoreLeaves)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 24),
                      child: Center(
                        child: LoadingShimmer(
                          height: 100,
                          width: double.infinity,
                          borderRadius: 16,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        }
        if (state is DashboardLoading) {
          final horizontalPadding = ResponsivePadding.getHorizontalPadding(
            MediaQuery.of(context).size.width,
          );
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
                const LoadingShimmer(height: 32, width: 120, borderRadius: 8),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: const LoadingShimmer(
                        height: 100,
                        borderRadius: 16,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: const LoadingShimmer(
                        height: 100,
                        borderRadius: 16,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: const LoadingShimmer(
                        height: 100,
                        borderRadius: 16,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                const LoadingShimmer(
                  height: 100,
                  width: double.infinity,
                  borderRadius: 12,
                ),
                const SizedBox(height: 12),
                const LoadingShimmer(
                  height: 100,
                  width: double.infinity,
                  borderRadius: 12,
                ),
                const SizedBox(height: 12),
                const LoadingShimmer(
                  height: 100,
                  width: double.infinity,
                  borderRadius: 12,
                ),
              ],
            ),
          );
        }
        return Center(
          child: CircularProgressIndicator(color: AppColors.primaryColor),
        );
      },
    );
  }

  Widget _buildMiniStatCard(
    BuildContext context,
    String title,
    String value,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
