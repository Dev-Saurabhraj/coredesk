import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:coredesk/core/exceptions/exceptions.dart';
import 'package:coredesk/features/authentication/domain/usecases/auth_use_cases.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final LogoutUseCase logoutUseCase;
  final IsLoggedInUseCase isLoggedInUseCase;

  AuthBloc({
    required this.loginUseCase,
    required this.logoutUseCase,
    required this.isLoggedInUseCase,
  }) : super(const AuthInitial()) {
    on<LoginEvent>(_onLogin);
    on<LogoutEvent>(_onLogout);
    on<CheckAuthStatusEvent>(_onCheckAuthStatus);
  }

  Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());
    try {
      final auth = await loginUseCase(event.email, event.password);
      emit(AuthSuccess(auth));
    } on ValidationException catch (e) {
      emit(AuthError(e.message));
    } on AuthException catch (e) {
      emit(AuthError(e.message));
    } on ServerException catch (e) {
      emit(AuthError(e.message));
    } on NetworkException catch (e) {
      emit(AuthError('Network error: ${e.message}'));
    } catch (e) {
      emit(const AuthError('An unexpected error occurred'));
    }
  }

  Future<void> _onLogout(LogoutEvent event, Emitter<AuthState> emit) async {
    try {
      await logoutUseCase();
      emit(const AuthLoggedOut());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onCheckAuthStatus(
    CheckAuthStatusEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      final isLoggedIn = await isLoggedInUseCase();
      if (!isLoggedIn) {
        emit(const AuthLoggedOut());
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}
