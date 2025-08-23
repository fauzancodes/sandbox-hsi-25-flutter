import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import 'package:hive/hive.dart';
import 'register_event.dart';
import 'register_state.dart';
import '../../models/user.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(const RegisterState()) {
    on<RegisterSubmitted>(_onRegisterSubmitted);
  }

  Future<void> _onRegisterSubmitted(
    RegisterSubmitted event,
    Emitter<RegisterState> emit,
  ) async {
    emit(state.copyWith(status: RegisterStatus.loading));

    final fullName = event.fullName.trim();
    final email = event.email.trim();
    final password = event.password.trim();

    if (fullName.isEmpty || email.isEmpty || password.isEmpty) {
      emit(state.copyWith(
        status: RegisterStatus.failure, message: "Please fill all fields"
      ));
      return;
    }

    if (fullName.length < 3) {
      emit(state.copyWith(
        status: RegisterStatus.failure,
        message: "Full name must be at least 3 characters long"
      ));
      return;
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(email)) {
      emit(state.copyWith(
        status: RegisterStatus.failure,
        message: "Please enter a valid email address"
      ));
      return;
    }

    final passwordRegex = RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@#!$%&?])[A-Za-z\d@#!$%&?]{8,}$'
    );
    if (!passwordRegex.hasMatch(password)) {
      emit(state.copyWith(
        status: RegisterStatus.failure,
        message: "Password must be at least 8 chars, with upper/lowercase, number, and symbol"
      ));
      return;
    }

    try {
      var box = Hive.box<User>('users');
      final uuid = Uuid();
      User newUser = User(
        id: uuid.v4(),
        fullName: fullName,
        email: email,
        password: password,
      );
      await box.put(newUser.id, newUser);

      emit(state.copyWith(
        status: RegisterStatus.success, message: "Registration successful"
      ));
    } catch (e) {
      emit(state.copyWith(
        status: RegisterStatus.failure, message: "Error: ${e.toString()}"
      ));
    }
  }
}
