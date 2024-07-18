import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:outsera_challenge/src/data/repositories/studio/studio.dart';
import 'package:outsera_challenge/src/entities/entities.dart';
import 'package:outsera_challenge/src/infra/http/http.dart';

import '../../../../fixtures/fixtures_reader.dart';
import '../../../../mocks/studios.dart';

class HttpClientMock extends Mock implements HttpClient {}

void main() {
  late StudioRepository sut;
  late HttpClientMock httpClientMock;

  setUp(() {
    httpClientMock = HttpClientMock();
    sut = StudioRepositoryImpl(httpClient: httpClientMock);
  });

  group('StudioRepositoryImpl >', () {
    group('getWithWins >', () {
      test('should return a List<Studio> when the request is successfull',
          () async {
        final response = jsonDecode(fixture('studios_with_win.json'));

        when(() => httpClientMock.get(
                path: '', queryParams: any(named: 'queryParams')))
            .thenAnswer((_) async => HttpResponse(
                  statusCode: 200,
                  data: response,
                  request: const RequestData(path: ''),
                ));

        final result = await sut.getWithWins();

        result.fold((_) => null, (studios) {
          expect(studios, studiosWithWins);
        });
      });

      test('should return a Failure on the left if he call fails', () async {
        when(() => httpClientMock.get(
            path: '/',
            queryParams: any(named: 'queryParams'))).thenThrow(Exception());

        final result = await sut.getWithWins();

        result.fold((failure) {
          expect(failure, isA<Failure>());
        }, (_) => null);
      });
    });
  });
}
