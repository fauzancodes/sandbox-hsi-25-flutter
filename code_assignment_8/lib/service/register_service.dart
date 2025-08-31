
import 'package:code_assignment_8/service/api_client.dart';
import 'package:dio/dio.dart';

class RegisterApiService {
  Future<void> registerUser({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      await dio.post(
        "/register",
        data: {
          "name": name,
          "email": email,
          "password": password,
        },
      );
    } on DioException catch (e) {
      throw Exception(e.response?.data["meta"]["message"] ?? "API request failed");
    }
  }
}