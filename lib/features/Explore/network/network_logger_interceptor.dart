import 'package:dio/dio.dart';

/// Interceptor that prints full network details to the console.
/// Logs: method, URL, headers, query params, request body,
/// response status, response body, and errors.
class NetworkLoggerInterceptor extends Interceptor {
  static final String _separator = '─' * 60;
  static final String _thinSep  = '┄' * 60;

  // ──────────────────────────────── REQUEST ──────────────────
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _log('');
    _log(_separator);
    _log('📤  REQUEST');
    _log(_separator);
    _log('Method   : ${options.method}');
    _log('URL      : ${options.uri}');
    _log('Base URL : ${options.baseUrl}');
    _log('Path     : ${options.path}');

    _logSection('Headers', options.headers);
    _logSection('Query Params', options.queryParameters);

    if (options.data != null) {
      _log('');
      _log('Body:');
      _log(options.data.toString());
    }

    _log(_separator);
    super.onRequest(options, handler);
  }

  // ──────────────────────────────── RESPONSE ─────────────────
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _log('');
    _log(_separator);
    _log('📥  RESPONSE');
    _log(_separator);
    _log('Status   : ${response.statusCode} ${response.statusMessage}');
    _log('URL      : ${response.realUri}');

    _logSection('Headers', response.headers.map);

    _log('');
    _log('Body:');
    _logBody(response.data);

    _log(_separator);
    super.onResponse(response, handler);
  }

  // ──────────────────────────────── ERROR ────────────────────
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _log('');
    _log(_separator);
    _log('❌  ERROR');
    _log(_separator);
    _log('Type     : ${err.type}');
    _log('Message  : ${err.message}');

    if (err.response != null) {
      _log('Status   : ${err.response?.statusCode}');
      _log('URL      : ${err.response?.realUri}');
      _log('');
      _log('Error Body:');
      _logBody(err.response?.data);
    }

    if (err.error != null) {
      _log('');
      _log('Cause    : ${err.error}');
    }

    _log(_separator);
    super.onError(err, handler);
  }

  // ──────────────────────────────── HELPERS ──────────────────
  void _log(String message) => print(message);   // ignore: avoid_print

  void _logSection(String title, Map<String, dynamic>? map) {
    if (map == null || map.isEmpty) return;
    _log('');
    _log('$title:');
    _log(_thinSep);
    map.forEach((key, value) => _log('  $key: $value'));
  }

  void _logBody(dynamic data) {
    if (data == null) {
      _log('  (empty)');
      return;
    }
    if (data is List) {
      _log('  List<${data.isEmpty ? 'dynamic' : data.first.runtimeType}>'
          ' — ${data.length} item(s)');
      if (data.isNotEmpty) {
        _log('  First item: ${data.first}');
      }
    } else {
      _log('  $data');
    }
  }
}