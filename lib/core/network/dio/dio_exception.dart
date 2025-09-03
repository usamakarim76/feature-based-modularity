import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';

class DioExceptions implements Exception {
  late String errorMessage;

  DioExceptions.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.cancel:
        errorMessage = 'Request to the server was cancelled.';
        break;
      case DioExceptionType.connectionTimeout:
        errorMessage = 'Connection timed out.';
        break;
      case DioExceptionType.receiveTimeout:
        errorMessage = 'Receiving timeout occurred';
        break;
      case DioExceptionType.sendTimeout:
        errorMessage = 'Request send timeout.';
        break;
      case DioExceptionType.badResponse:
        log(dioError.response.toString());
        errorMessage = dioError.response!.data['message'];
        // _handleStatusCode(dioError.response?.statusCode ?? 400);
        break;
      case DioExceptionType.unknown:
        if (dioError.message?.contains('SocketException') ?? false) {
          errorMessage = 'No Internet Connection';
          break;
        }
        errorMessage = 'Unexpected error occurred.';
        break;
      default:
        if (dioError.error is SocketException) {
          errorMessage = 'No Internet Connection.';
          break;
        }
        errorMessage = 'Something went wrong';
        break;
    }
  }

  String handleStatusCode(int? statusCode) {
    switch (statusCode) {
      case 400:
        return 'Bad request.';
      case 401:
        // return 'Authentication failed.';
        return 'Invalid Credentials';
      case 403:
        return 'The authenticated user is not allowed to access the specified API endpoint.';
      case 404:
        return 'The requested resource does not exist.';
      case 405:
        return 'Method not allowed. Please check the Allow header for the allowed HTTP methods.';
      case 415:
        return 'Unsupported media type. The requested content type or version number is invalid.';
      case 422:
        return 'Data validation failed.';
      case 429:
        return 'Too many requests.';
      case 500:
        return 'Internal server error.';
      default:
        return 'Oops something went wrong!';
    }
  }

  @override
  String toString() => errorMessage;
}
