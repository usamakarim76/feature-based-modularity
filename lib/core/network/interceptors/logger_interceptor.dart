import 'package:clean_architecture/core/constants/app_logs.dart';
import 'package:dio/dio.dart';

class LoggerInterceptor extends Interceptor {
  AppLogger print = AppLogger(className: "Logger Interceptor");
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final options = err.requestOptions;
    final requestPath = '${options.baseUrl}${options.path}';
    print.warning('${options.method} request => $requestPath');
    print.error('Error: ${err.error}, Message: ${err.message}');
    return super.onError(err, handler);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final requestPath = '${options.baseUrl}${options.path}';
    print.warning('${options.method} request => $requestPath');
    print.debug('headers => ${options.headers}');
    if (options.data != null) {
      if (options.data is FormData) {
        FormData formData = options.data as FormData;
        print.debug("FormData fields: ${formData.fields}");
        print.debug(
          "FormData files: ${formData.files.map((f) => f.value.filename).toList()}",
        );
      } else {
        print.debug('body => ${options.data}');
      }
    }
    // Preserve the original onSendProgress and inject logging
    final originalOnSendProgress = options.onSendProgress;

    options.onSendProgress = (sent, total) {
      if (total > 0) {
        double progress = (sent / total) * 100;
        print.success(
          "LoggerInterceptor Upload progress: ${progress.toStringAsFixed(2)}%",
        );
        // Call original onSendProgress if it exists
        if (originalOnSendProgress != null) {
          originalOnSendProgress(sent, total);
        }
      }
    };
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print.success('StatusCode: ${response.statusCode}, Data: ${response.data}');
    return super.onResponse(response, handler);
  }
}
