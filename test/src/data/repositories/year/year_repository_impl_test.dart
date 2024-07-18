import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:outsera_challenge/src/data/repositories/year/year.dart';
import 'package:outsera_challenge/src/entities/entities.dart';
import 'package:outsera_challenge/src/infra/http/http.dart';

import '../../../../fixtures/fixtures_reader.dart';
import '../../../../mocks/years.dart';

class HttpClientMock extends Mock implements HttpClient {}

void main() {
  late YearRepository sut;
  late HttpClientMock httpClientMock;

  setUp(() {
    httpClientMock = HttpClientMock();
    sut = YearRepositoryImpl(httpClient: httpClientMock);
  });

  group('YearRepositoryImpl >', () {
    group('getWithMoreThanOneWinner >', () {
      test('should return a List<Year> when the request is successfull',
          () async {
        final response = jsonDecode(fixture('years_with_winners.json'));

        when(() => httpClientMock.get(
                path: '', queryParams: any(named: 'queryParams')))
            .thenAnswer((_) async => HttpResponse(
                  statusCode: 200,
                  data: response,
                  request: const RequestData(path: ''),
                ));

        final result = await sut.getWithMoreThanOneWinner();

        result.fold((_) => null, (years) {
          expect(years, yearsWithWinners);
        });
      });

      test('should return a Failure on the left if he call fails', () async {
        when(() => httpClientMock.get(
            path: '/',
            queryParams: any(named: 'queryParams'))).thenThrow(Exception());

        final result = await sut.getWithMoreThanOneWinner();

        result.fold((failure) {
          expect(failure, isA<Failure>());
        }, (_) => null);
      });
    });
  });
}
