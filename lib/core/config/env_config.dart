import 'package:flutter/foundation.dart';

/// Environment configurations for the app
/// Contains different settings for development, staging and production environments
class EnvConfig {
  /// Base API URL for the current environment
  final String apiBaseUrl;

  /// Environment name (dev, staging, prod)
  final String environmentName;

  /// Whether this is a development environment
  final bool isDevelopment;

  /// Constructor for environment configuration
  const EnvConfig({
    required this.apiBaseUrl,
    required this.environmentName,
    required this.isDevelopment,
  });

  /// Development environment configuration
  static const EnvConfig development = EnvConfig(
    apiBaseUrl: 'https://fitnect-api.onrender.com/api/v1',
    environmentName: 'dev',
    isDevelopment: true,
  );

  /// Staging environment configuration
  static const EnvConfig staging = EnvConfig(
    apiBaseUrl: 'https://staging-fitnect-api.onrender.com/api/v1',
    environmentName: 'staging',
    isDevelopment: false,
  );

  /// Production environment configuration
  static const EnvConfig production = EnvConfig(
    apiBaseUrl: 'https://api.fitnect.com/api/v1',
    environmentName: 'prod',
    isDevelopment: false,
  );

  /// Current environment configuration based on build mode
  static EnvConfig get current {
    if (kReleaseMode) {
      return production;
    } else if (kProfileMode) {
      return staging;
    } else {
      return development;
    }
  }

  @override
  String toString() =>
      'EnvConfig(environment: $environmentName, apiBaseUrl: $apiBaseUrl)';
}
