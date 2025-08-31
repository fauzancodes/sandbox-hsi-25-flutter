
import 'package:code_assignment_8/service/api_client.dart';
import 'package:dio/dio.dart';

class LoginApiService {
  Future<Map<String, dynamic>> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      final response = await dio.post(
        "/login",
        data: {
          "email": email,
          "password": password,
        },
      );

      return response.data["data"];
    } on DioException catch (e) {
      throw Exception(e.response?.data["meta"]["message"] ?? "API request failed");
    }
  }
}