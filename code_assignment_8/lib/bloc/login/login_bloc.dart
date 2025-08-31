import 'package:code_assignment_8/service/login_service.dart';
import 'package:code_assignment_8/service/token_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginApiService apiService;
  LoginBloc({required this.apiService}) : super(const LoginState()) {
    on<LoginSubmitted>(_onLoginSubmitted);
  }

  Future<void> _onLoginSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(status: LoginStatus.loading));

    final email = event.email.trim();
    final password = event.password.trim();

    if (email.isEmpty || password.isEmpty) {
      emit(state.copyWith(
        status: LoginStatus.failure, message: "Please fill all fields"
      ));
      return;
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(email)) {
      emit(state.copyWith(
        status: LoginStatus.failure,
        message: "Please enter a valid email address"
      ));
      return;
    }

    try {
      final result = await apiService.loginUser(
        email: email,
        password: password,
      );

      final token = result["token"];

      if (token != null) {
        await TokenStorage.saveToken(token);

        emit(state.copyWith(
          status: LoginStatus.success,
          message: "Login successful",
        ));
      } else {
        emit(state.copyWith(
          status: LoginStatus.failure,
          message: "Invalid email or password",
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: LoginStatus.failure,
        message: "Error: ${e.toString()}",
      ));
    }
  }
}
