import 'package:dio/dio.dart';
import 'package:flutter_genesis_test/generated/i18n.dart';

String handleError(DioError dioError) {
  String errorDescription = "";
  switch (dioError.type) {
    case DioErrorType.CANCEL:
      errorDescription = S.of(context).request_to_api_server_was_cancelled;
      break;
    case DioErrorType.CONNECT_TIMEOUT:
      errorDescription = "Connection timeout with API server";
      break;
    case DioErrorType.DEFAULT:
      errorDescription =
          "Connection to API server failed due to internet connection";
      break;
    case DioErrorType.RECEIVE_TIMEOUT:
      errorDescription = "Receive timeout in connection with API server";
      break;
    case DioErrorType.RESPONSE:
      errorDescription =
          "Received invalid status code: ${dioError.response.statusCode}";
      break;
    case DioErrorType.SEND_TIMEOUT:
      errorDescription = "Send timeout in connection with API server";
      break;
  }
  return errorDescription;
}
