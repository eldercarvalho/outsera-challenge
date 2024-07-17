class ServerException implements Exception {
  final String? code;
  final String? message;
  final int? statusCode;

  ServerException({
    required this.code,
    required this.message,
    this.statusCode,
  });
}

class ConnectionException implements Exception {}

class TimeoutException implements Exception {}

class UnknownException implements Exception {
  final Object? error;

  UnknownException({required this.error});
}

class ParsingException implements Exception {
  ParsingException({this.error, this.stackTrace});

  final Object? error;
  final Object? stackTrace;
}
