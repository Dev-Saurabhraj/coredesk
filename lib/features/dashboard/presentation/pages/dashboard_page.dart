import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:coredesk/features/dashboard/presentation/index.dart';
import 'package:coredesk/shared/widgets/app_bottom_navigation_bar.dart'
    show BottomNavItem, AppBottomNavigationBar;
import 'package:coredesk/features/leaves/presentation/index.dart';
import 'package:coredesk/features/attendance/presentation/index.dart';

class DashboardPage extends StatefulWidget {
  final String token;

  const DashboardPage({super.key, required this.token});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    // Check if data is already loaded to prevent duplicate fetches
    final dashboardBloc = context.read<DashboardBloc>();
    if (dashboardBloc.state is! DashboardSuccess) {
      dashboardBloc.add(FetchDashboardDataEvent(widget.token));
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onNavItemTapped(BottomNavItem item) {
    final index = item.index;
    setState(() {
      _currentIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  BottomNavItem get _currentItem => BottomNavItem.values[_currentIndex];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: [
          HomeScreen(token: widget.token),
          const LeavesScreen(),
          const AttendanceScreen(),
          const ProfileScreen(),
        ],
      ),
      bottomNavigationBar: AppBottomNavigationBar(
        currentItem: _currentItem,
        onItemSelected: _onNavItemTapped,
      ),
    );
  }
}
