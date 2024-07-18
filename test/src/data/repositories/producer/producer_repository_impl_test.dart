import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:outsera_challenge/src/data/repositories/producer/producer.dart';
import 'package:outsera_challenge/src/entities/entities.dart';
import 'package:outsera_challenge/src/infra/http/http.dart';

import '../../../../fixtures/fixtures_reader.dart';
import '../../../../mocks/mocks.dart';

class HttpClientMock extends Mock implements HttpClient {}

void main() {
  late ProducerRepository sut;
  late HttpClientMock httpClientMock;

  setUp(() {
    httpClientMock = HttpClientMock();
    sut = ProducerRepositoryImpl(httpClient: httpClientMock);
  });

  group('ProducerRepositoryImpl >', () {
    group('getMinMaxInterval >', () {
      test(
          'should return a MaxMinIntervalProducers when the request is successfull',
          () async {
        final response = jsonDecode(fixture('paginable_movies.json'));

        when(() => httpClientMock.get(
                path: '', queryParams: any(named: 'queryParams')))
            .thenAnswer((_) async => HttpResponse(
                  statusCode: 200,
                  data: response,
                  request: const RequestData(path: ''),
                ));

        final result = await sut.getMinMaxInterval();

        result.fold((_) => null, (producers) {
          expect(producers, minMaxIntervalProducers);
        });
      });

      test('should return a Failure on the left if he call fails', () async {
        when(() => httpClientMock.get(
            path: '/',
            queryParams: any(named: 'queryParams'))).thenThrow(Exception());

        final result = await sut.getMinMaxInterval();

        result.fold((failure) {
          expect(failure, isA<Failure>());
        }, (_) => null);
      });
    });
  });
}
