import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:outsera_challenge/src/infra/http/http_client.dart';
import 'package:outsera_challenge/src/infra/http/http_client_impl.dart';

void main() {
  late HttpClient sut;
  late Dio dio;
  late DioAdapter dioAdapter;

  setUp(() {
    dio = Dio(BaseOptions());
    dioAdapter = DioAdapter(dio: dio);
    sut = HttpClientImpl(dio: dio);
  });

  group('HttpClient >', () {
    test('should return a HttpResponse with status code 200', () async {
      dioAdapter.onGet(
        '/movies',
        (server) => server.reply(
          200,
          {'message': 'Success!'},
          // Reply would wait for one-sec before returning data.
          delay: const Duration(seconds: 1),
        ),
      );

      final response = await sut.get(path: '/movies');

      expect(response, isA<HttpResponse>());
    });

    test('should throw an Exception if Dio throws a error', () async {
      dioAdapter.onGet(
        '/movies',
        (server) => server.reply(
          404,
          {'message': 'Not Found!'},
          // Reply would wait for one-sec before returning data.
          delay: const Duration(seconds: 1),
        ),
      );

      expect(() async => await sut.get(path: '/movies'),
          throwsA(isA<Exception>()));
    });
  });
}
