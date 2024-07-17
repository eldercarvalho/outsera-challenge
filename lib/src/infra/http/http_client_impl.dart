import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

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
      'charset': 'utf-8',
      'Accept-Language': "pt_BR",
    };
    _dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
    ));
  }

  late final Dio _dio;

  @override
  Future<HttpResponse> get({
    required String path,
    bool authenticated = false,
    Map<String, dynamic> queryParams = const {},
  }) async {
    if (authenticated) _addAuthotizationHeader();
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

  @override
  Future<HttpResponse> post({
    required String path,
    bool authenticated = false,
    Map<String, dynamic> queryParams = const {},
    data,
  }) async {
    if (authenticated) _addAuthotizationHeader();
    final response = await _dio.post(
      path,
      data: data,
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

  @override
  Future<HttpResponse> patch({
    required String path,
    bool authenticated = false,
    Map<String, dynamic> queryParams = const {},
    data,
  }) async {
    if (authenticated) _addAuthotizationHeader();
    final response = await _dio.patch(
      path,
      data: data,
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

  @override
  Future<HttpResponse> delete({
    required String path,
    bool authenticated = false,
  }) async {
    if (authenticated) _addAuthotizationHeader();
    final response = await _dio.delete(path);
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

  @override
  Future<HttpResponse> download({
    required String url,
    required String path,
    bool authenticated = false,
  }) {
    throw UnimplementedError();
  }

  void _addAuthotizationHeader() {
    _dio.options.headers.putIfAbsent(authHeader, () => null);
  }

  @override
  Future<HttpResponse> put({
    required String path,
    bool authenticated = false,
    Map<String, dynamic> queryParams = const {},
    data,
  }) async {
    if (authenticated) _addAuthotizationHeader();
    final response = await _dio.put(
      path,
      data: data,
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
