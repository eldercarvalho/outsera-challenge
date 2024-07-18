import 'package:dio/dio.dart';

import 'http_client.dart';

const authHeader = "Authorization";

class HttpClientImpl implements HttpClient {
  HttpClientImpl({required Dio dio}) {
    _dio = dio;
    _dio.options.baseUrl = 'https://tools.texoit.com/backend-java/api/movies';
    _dio.options.connectTimeout = const Duration(seconds: 30);
    _dio.options.receiveTimeout = const Duration(seconds: 30);
    _dio.options.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    // _dio.interceptors.add(PrettyDioLogger(
    //   requestHeader: true,
    //   requestBody: true,
    // ));
  }

  late final Dio _dio;

  @override
  Future<HttpResponse> get({
    required String path,
    bool authenticated = false,
    Map<String, dynamic> queryParams = const {},
  }) async {
    final response = await _dio.get(
      path,
      queryParameters: queryParams,
    );
    return HttpResponse(
      statusCode: response.statusCode,
      data: response.data,
      request: RequestData(
        path: response.requestOptions.path,
        headers: response.requestOptions.headers,
        queryParams: response.requestOptions.queryParameters,
      ),
    );
  }
}
