import 'package:flutter/foundation.dart';

class ApiConfig {
  ApiConfig._();

  static const String _defaultLocalApiUrl = 'http://localhost:3000';

  // URL API production — dùng khi deploy web lên Render
  static const String _productionApiUrl = 'https://fellow4udb.onrender.com';

  static const String _envBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: '',
  );
  static const String _envAuthBaseUrl = String.fromEnvironment(
    'AUTH_BASE_URL',
    defaultValue: '',
  );

  static String get baseUrl {
    // 1. Ưu tiên --dart-define nếu có
    if (_envBaseUrl.isNotEmpty) return _envBaseUrl;
    // 2. Khi chạy local dev (localhost) → dùng localhost:3000
    if (_isLocalOrigin) return _defaultLocalApiUrl;
    // 3. Khi deploy production web → dùng URL API production cố định
    return _productionApiUrl;
  }

  static String get authBaseUrl {
    if (_envAuthBaseUrl.isNotEmpty) return _envAuthBaseUrl;
    if (_isLocalOrigin) return _defaultLocalApiUrl;
    return _productionApiUrl;
  }

  /// true khi chạy trên localhost (dev mode)
  static bool get _isLocalOrigin {
    if (!kIsWeb) return false;
    final host = Uri.base.host;
    return host == 'localhost' || host == '127.0.0.1';
  }

  static const int timeoutMs = int.fromEnvironment(
    'API_TIMEOUT_MS',
    defaultValue: 15000,
  );

  static bool get isLocalApi =>
      baseUrl == _defaultLocalApiUrl || authBaseUrl == _defaultLocalApiUrl;

  static bool get hasCustomApiUrl =>
      baseUrl != _defaultLocalApiUrl || authBaseUrl != _defaultLocalApiUrl;
}
