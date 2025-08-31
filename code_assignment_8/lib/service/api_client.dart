import 'package:code_assignment_8/service/token_storage.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

final Dio dio = Dio(
  BaseOptions(
    baseUrl: "https://hsinote.donisaputra.com/api",
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
    headers: {
      "Content-Type": "application/json",
    },
  ),
)
  ..interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await TokenStorage.getToken();
        if (token != null) {
          options.headers["Authorization"] = "Bearer $token";
        }
        return handler.next(options);
      },
    ),
  )
  ..interceptors.add(
    LogInterceptor(
      request: true,
      requestBody: true,
      requestHeader: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      logPrint: (obj) {
        if (kDebugMode) {
          print("API DEBUG: $obj");
        }
      },
    ),
  );
