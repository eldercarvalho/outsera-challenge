import 'package:equatable/equatable.dart';

class RequestData extends Equatable {
  final String path;
  final Map<String, dynamic>? headers;
  final Map<String, dynamic>? queryParams;

  const RequestData({
    required this.path,
    this.headers,
    this.queryParams,
  });

  @override
  List<Object?> get props => [path, queryParams];
}

class HttpResponse extends Equatable {
  final int? statusCode;
  final Map<String, dynamic> data;
  final RequestData request;

  const HttpResponse({
    required this.statusCode,
    required this.data,
    required this.request,
  });

  @override
  List<Object?> get props => [statusCode, data];
}

abstract class HttpClient {
  Future<HttpResponse> get({
    required String path,
    bool authenticated = false,
    Map<String, dynamic> queryParams = const {},
  });

  Future<HttpResponse> post({
    required String path,
    bool authenticated = false,
    Map<String, dynamic> queryParams = const {},
    dynamic data,
  });

  Future<HttpResponse> patch({
    required String path,
    bool authenticated = false,
    Map<String, dynamic> queryParams = const {},
    dynamic data,
  });

  Future<HttpResponse> put({
    required String path,
    bool authenticated = false,
    Map<String, dynamic> queryParams = const {},
    dynamic data,
  });

  Future<HttpResponse> delete({
    required String path,
    bool authenticated = false,
  });

  Future<HttpResponse> download({
    required String url,
    required String path,
    bool authenticated = false,
  });
}
