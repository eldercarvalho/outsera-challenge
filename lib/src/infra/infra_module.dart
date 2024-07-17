import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'http/http.dart';

@module
abstract class InfraModule {
  @lazySingleton
  HttpClient get httpClient => HttpClientImpl(
        dio: Dio(),
      );
}
