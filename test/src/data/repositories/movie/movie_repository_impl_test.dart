import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:outsera_challenge/src/data/repositories/movie/movie.dart';
import 'package:outsera_challenge/src/entities/failure_entity.dart';
import 'package:outsera_challenge/src/infra/http/http.dart';

import '../../../../fixtures/fixtures_reader.dart';
import '../../../../mocks/paginable_movies.dart';

class HttpClientMock extends Mock implements HttpClient {}

void main() {
  late MovieRepository sut;
  late HttpClientMock httpClientMock;

  setUp(() {
    httpClientMock = HttpClientMock();
    sut = MovieRepositoryImpl(httpClient: httpClientMock);
  });

  group('MovieRepository >', () {
    group('getAll >', () {
      test(
          'should return a PaginableResult<Movie> when the request is successful',
          () async {
        final response = jsonDecode(fixture('paginable_movies.json'));

        when(() => httpClientMock.get(
                path: '', queryParams: any(named: 'queryParams')))
            .thenAnswer((_) async => HttpResponse(
                  statusCode: 200,
                  data: response,
                  request: const RequestData(path: ''),
                ));

        final result = await sut.getAll();

        result.fold((_) => null, (movies) {
          expect(movies, paginableMovies);
        });
      });

      test('should return a Failure on the left if he call fails', () async {
        when(() => httpClientMock.get(
            path: '/',
            queryParams: any(named: 'queryParams'))).thenThrow(Exception());

        final result = await sut.getAll();

        result.fold((failure) {
          expect(failure, isA<Failure>());
        }, (_) => null);
      });
    });
  });
}
