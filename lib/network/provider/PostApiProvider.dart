import 'package:dio/dio.dart';
import 'package:flutter_genesis_test/data_classes/response/PostResponse.dart';
import 'package:flutter_genesis_test/ui/utils/handlers/ErrorHandler.dart';

class PostApiProvider {
  final String _endpoint = "https://jsonplaceholder.typicode.com/posts";
  Dio _dio;

  PostApiProvider() {
    BaseOptions options = BaseOptions(receiveTimeout: 5000, sendTimeout: 5000);
    _dio = Dio(options);
    _setupLoggingInterceptor();
  }

  Future<PostResponse> getPosts() async {
    try {
      Response response = await _dio.get(_endpoint);
      return PostResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print(
          "Exception occured: $error  error as DioError.type ${(error as DioError).type}");
      print("Exception error.runtimeType ${error.runtimeType}");
      return PostResponse.withError(handleError(error));
    }
  }

  void _setupLoggingInterceptor() {
    int maxCharactersPerLine = 200;
    var requestInterceptor = (Options options) {
      print("--> ${options.method} ${options.method}");
      print("Content type: ${options.contentType}");
      print("<-- END HTTP");
      return options;
    };

    var responseInterceptor = (Response response) {
      print(
          "<-- ${response.statusCode} ${response.request.method} ${response.request.path}");
      String responseAsString = response.data.toString();
      if (responseAsString.length > maxCharactersPerLine) {
        int iterations =
            (responseAsString.length / maxCharactersPerLine).floor();
        for (int i = 0; i <= iterations; i++) {
          int endingIndex = i * maxCharactersPerLine + maxCharactersPerLine;
          if (endingIndex > responseAsString.length) {
            endingIndex = responseAsString.length;
          }
          print(responseAsString.substring(
              i * maxCharactersPerLine, endingIndex));
        }
      } else {
        print(response.data);
      }
      print("<-- END HTTP");
    };

    var errorInterceptor = (DioError error) {
      try {
        print("--> ${error.response.statusCode} ${error.response}");
      } catch (error, stacktrace) {
        print("--> Unexpected error ocured ${stacktrace}");
      }
    };
    _dio
      ..interceptors.add(InterceptorsWrapper(
          onRequest: (RequestOptions options) => requestInterceptor(options),
          onResponse: (Response response) => responseInterceptor(response)
//          onError: (DioError dioError) => errorInterceptor(dioError)
          ));
  }
}
