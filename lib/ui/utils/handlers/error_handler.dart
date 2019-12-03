import 'package:dio/dio.dart';

String handleError(DioError dioError) {
  String errorDescription = "";
  switch (dioError.type) {
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
      errorDescription = "Received invalid status code: ${dioError.response.statusCode}";
      break;
    case DioErrorType.SEND_TIMEOUT:
      errorDescription = "Send timeout in connection with API server";
      break;
  }
  return errorDescription;
}
