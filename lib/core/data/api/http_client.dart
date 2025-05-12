import 'package:fitnect/core/config/env_config.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final httpClientProvider = Provider<HttpClient>((ref) {
  return HttpClient.fromEnv();
});

class HttpClient with DioMixin implements Dio {
  String? authToken;

  HttpClient({required String baseUrl}) {
    options = BaseOptions(baseUrl: baseUrl);
    httpClientAdapter = HttpClientAdapter();
    interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          if (authToken != null) {
            options.headers.putIfAbsent(
              'Authorization',
              () => 'Bearer $authToken',
            );
          }
          return handler.next(options);
        },
      ),
    );
  }

  factory HttpClient.fromEnv() {
    final env = EnvConfig.current;
    return HttpClient(baseUrl: env.apiBaseUrl);
  }
}
