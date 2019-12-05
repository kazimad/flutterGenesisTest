import 'package:dio/dio.dart';
import 'package:flutter_genesis_test/exception/custom_exception.dart';

String handleError(Exception exception) {
  String errorDescription = "";
  if (exception is DioError) {
    switch (exception.type) {
      case DioErrorType.CANCEL:
        errorDescription = "Request to API server was cancelled";
        break;
      case DioErrorType.CONNECT_TIMEOUT:
        errorDescription = "Connection timeout with API server";
        break;
      case DioErrorType.DEFAULT:
        errorDescription = "Connection to API server failed due to internet connection";
        break;
      case DioErrorType.RECEIVE_TIMEOUT:
        errorDescription = "Receive timeout in connection with API server";
        break;
      case DioErrorType.RESPONSE:
        errorDescription = "Received invalid status code: ${exception.response.statusCode}";
        break;
      case DioErrorType.SEND_TIMEOUT:
        errorDescription = "Send timeout in connection with API server";
        break;
    }
  } else if ((exception is CustomException)) {
    errorDescription = exception.cause;
  } else {
    errorDescription = "something went wrong";
  }
  return errorDescription;
}
