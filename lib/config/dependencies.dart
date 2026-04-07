import 'package:shared_preferences/shared_preferences.dart';
import 'package:coredesk/core/network/dio_client.dart';
import 'package:coredesk/features/authentication/data/datasources/auth_remote_data_source.dart';
import 'package:coredesk/features/authentication/domain/repositories/auth_repository.dart'
    as auth_repo;
import 'package:coredesk/features/authentication/domain/usecases/auth_use_cases.dart';
import 'package:coredesk/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:coredesk/features/dashboard/data/datasources/dashboard_remote_data_source.dart';
import 'package:coredesk/features/dashboard/data/repositories/dashboard_repository_impl.dart';
import 'package:coredesk/features/dashboard/domain/repositories/dashboard_repository.dart'
    as dashboard_repo;
import 'package:coredesk/features/dashboard/domain/usecases/dashboard_use_cases.dart';
import 'package:coredesk/features/dashboard/presentation/bloc/dashboard_bloc.dart';

class Dependencies {
  static late SharedPreferences _prefs;
  static late DioClient _dioClient;
  static late auth_repo.AuthRepository _authRepository;
  static late dashboard_repo.DashboardRepository _dashboardRepository;

  static Future<void> initialize(SharedPreferences prefs) async {
    _prefs = prefs;
    _dioClient = DioClient();


    final authRemoteDataSource = AuthRemoteDataSourceImpl(_dioClient);
    _authRepository = auth_repo.AuthRepositoryImpl(
      remoteDataSource: authRemoteDataSource,
      sharedPreferences: _prefs,
    );


    final dashboardRemoteDataSource = DashboardRemoteDataSourceImpl(_dioClient);
    _dashboardRepository = DashboardRepositoryImpl(
      remoteDataSource: dashboardRemoteDataSource,
    );
  }

  static AuthBloc createAuthBloc() {
    final loginUseCase = LoginUseCase(_authRepository);
    final logoutUseCase = LogoutUseCase(_authRepository);
    final isLoggedInUseCase = IsLoggedInUseCase(_authRepository);

    return AuthBloc(
      loginUseCase: loginUseCase,
      logoutUseCase: logoutUseCase,
      isLoggedInUseCase: isLoggedInUseCase,
    );
  }

  static DashboardBloc createDashboardBloc() {
    final getStatsUseCase = GetStatsUseCase(_dashboardRepository);
    final getLeavesUseCase = GetLeavesUseCase(_dashboardRepository);
    final getHolidaysUseCase = GetHolidaysUseCase(_dashboardRepository);
    final getAttendanceUseCase = GetAttendanceUseCase(_dashboardRepository);

    return DashboardBloc(
      getStatsUseCase: getStatsUseCase,
      getLeavesUseCase: getLeavesUseCase,
      getHolidaysUseCase: getHolidaysUseCase,
      getAttendanceUseCase: getAttendanceUseCase,
    );
  }

  static auth_repo.AuthRepository getAuthRepository() => _authRepository;
}
