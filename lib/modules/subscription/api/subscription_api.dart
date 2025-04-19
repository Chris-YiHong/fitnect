import 'package:fitnect/core/data/api/base_api_exceptions.dart';
import 'package:fitnect/core/data/api/http_client.dart';
import 'package:fitnect/modules/subscription/api/entities/subscription_entity.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

final subscriptionApiProvider = Provider(
  (ref) =>
      SubscriptionApi(client: ref.read(httpClientProvider), logger: Logger()),
);

/// Subscription API
/// Your backend should handle a webhook from the payment provider
/// to update the subscription status
/// Don't save the subscription status in the app,
/// always do this from a webhook call between you backend and the payment provider
class SubscriptionApi {
  final Logger _logger;
  final HttpClient _client;

  SubscriptionApi({required HttpClient client, required Logger logger})
    : _client = client,
      _logger = logger;

  Future<SubscriptionEntity?> get(String userId) async {
    try {
      final response = await _client.get('/user/$userId/subscription');
      // final json = jsonDecode(response.data) as Map<String, dynamic>;
      return SubscriptionEntity.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e, stackTrace) {
      _logger.e(
        "Error while getting user subscription from backend: $e",
        stackTrace: stackTrace,
      );
      throw ApiError.fromDioException(e);
    } catch (e) {
      _logger.e(e);
      throw ApiError(code: 0, message: '$e');
    }
  }
}
