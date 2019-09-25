import 'package:dio/dio.dart';
import 'package:flutter_genesis_test/data_classes/response/MovieParseResult.dart';
import 'package:flutter_genesis_test/ui/utils/handlers/ErrorHandler.dart';

class PostApiProvider {
  // endpoint for posts - delete after
//  final String _endpoint = "https://jsonplaceholder.typicode.com/posts";
  final String _endpoint = "https://api.themoviedb.org/3/discover/movie";
  Dio _dio;

  PostApiProvider() {
    BaseOptions options = BaseOptions(receiveTimeout: 5000, sendTimeout: 5000);
    _dio = Dio(options);
    _setupLoggingInterceptor();
  }

  Future<MovieParceResult> getPosts(String apiKey, String sortBy,
      String primaryReleaseDateGte, String primaryReleaseDateLte) async {
    try {
      Response response = await _dio.get(_endpoint, queryParameters: {
        "api_key": apiKey,
        "sort_by": sortBy,
        "primary_release_date.gte": primaryReleaseDateGte,
        "primary_release_date.lte": primaryReleaseDateLte
      });
      return MovieParceResult.fromJson(response.data);
    } catch (error, stacktrace) {
//      print(
//          "Exception occured: $error  error as DioError.type ${(error).type}");
      print(
          "Exception occured: $error  error as DioError.type ${(error).toString()}");
      return MovieParceResult.withError(handleError(error));
    }
  }

// interceptors
  void _setupLoggingInterceptor() {
    int maxCharactersPerLine = 200;
    var requestInterceptor = (Options options) {
      print(
          "--> ${options.method} ${options.extra.toString()} ${options.headers.toString()} "
          "${options.responseType.toString()} ${options.contentType.toString()} ${options.validateStatus.toString()} ${options.requestEncoder}");
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
