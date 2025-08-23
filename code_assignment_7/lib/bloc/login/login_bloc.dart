import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'login_event.dart';
import 'login_state.dart';
import '../../models/user.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginState()) {
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
      var box = Hive.box<User>('users');

      User? foundUser = box.values.firstWhere(
        (user) => user.email == email && user.password == password,
        orElse: () => User(id: '', fullName: '', email: '', password: ''),
      );

      if (foundUser.email.isNotEmpty) {
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
