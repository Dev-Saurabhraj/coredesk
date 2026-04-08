import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:coredesk/core/index.dart';
import 'package:coredesk/config/dependencies.dart';
import 'package:coredesk/routes/app_router.dart';
import 'package:coredesk/shared/services/index.dart';
import 'package:coredesk/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:coredesk/features/dashboard/presentation/bloc/dashboard_bloc.dart';

class CoreDeskApp extends StatefulWidget {
  const CoreDeskApp({super.key});

  @override
  State<CoreDeskApp> createState() => _CoreDeskAppState();
}

class _CoreDeskAppState extends State<CoreDeskApp> {
  late AuthService _authService;
  late final _router = createRouter(_authService);

  @override
  void initState() {
    super.initState();
    _authService = AuthService(
      authRepository: Dependencies.getAuthRepository(),
    );
  }

  ThemeData _buildTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: AppColors.primaryColor,
      scaffoldBackgroundColor: AppColors.backgroundColor,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.surfaceColor,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: AppTextStyles.appBarTitle,
        iconTheme: AppIcons.appBarIcons,
      ),
      textTheme: TextTheme(
        headlineLarge: AppTextStyles.headlineLarge,
        headlineMedium: AppTextStyles.headlineMedium,
        headlineSmall: AppTextStyles.headlineSmall,
        titleLarge: AppTextStyles.titleLarge,
        titleMedium: AppTextStyles.titleMedium,
        titleSmall: AppTextStyles.titleSmall,
        bodyLarge: AppTextStyles.bodyLarge,
        bodyMedium: AppTextStyles.bodyMedium,
        bodySmall: AppTextStyles.bodySmall,
        labelLarge: AppTextStyles.labelLarge,
      ),
      colorScheme: ColorScheme.light(
        primary: AppColors.primaryColor,
        secondary: AppColors.secondaryColor,
        tertiary: AppColors.accentColor,
        surface: AppColors.surfaceColor,
        error: AppColors.errorColor,
        scrim: AppColors.dividerColor,
      ),
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        filled: true,
        fillColor: AppColors.dividerColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.primaryColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.errorColor),
        ),
        hintStyle: AppTextStyles.hintStyle,
        labelStyle: AppTextStyles.labelStyle,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          textStyle: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          elevation: 0,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primaryColor,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          textStyle: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          side: const BorderSide(color: AppColors.primaryColor),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => Dependencies.createAuthBloc(),
        ),
        BlocProvider<DashboardBloc>(
          create: (context) => Dependencies.createDashboardBloc(),
        ),
      ],
      child: MaterialApp.router(
        title: 'CoreDesk',
        debugShowCheckedModeBanner: false,
        theme: _buildTheme(),
        routerConfig: _router,
      ),
    );
  }
}
