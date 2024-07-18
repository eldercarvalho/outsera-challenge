import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:outsera_challenge/src/data/repositories/repositories.dart';
import 'package:outsera_challenge/src/entities/failure_entity.dart';
import 'package:outsera_challenge/src/features/movies/cubit/cubit.dart';

import '../../../../mocks/mocks.dart';

class MovieRepositoryMock extends Mock implements MovieRepository {}

void main() {
  late MovieRepository movieRepository;
  late MoviesCubit sut;

  setUp(() {
    movieRepository = MovieRepositoryMock();
    sut = MoviesCubit(
      movieRepository: movieRepository,
    );
  });

  group('MoviesCubit >', () {
    group('getMovies >', () {
      blocTest(
        "should emits [MoviesStateLoading, MoviesStateLoaded] when success case",
        build: () => sut,
        act: (cubit) async {
          when(() => movieRepository.getAll(
                  page: any(named: 'page'),
                  winnersOnly: any(named: 'winnersOnly'),
                  year: any(named: 'year')))
              .thenAnswer((_) async => right(paginableMovies));

          await sut.getMovies();
        },
        expect: () => [
          isA<MoviesStateLoading>(),
          isA<MoviesStateLoaded>(),
        ],
      );

      blocTest(
        "should emits [MoviesStatePaginating, MoviesStateLoaded] if it is paginating",
        build: () => sut,
        act: (cubit) async {
          when(() => movieRepository.getAll(
                  page: any(named: 'page'),
                  winnersOnly: any(named: 'winnersOnly'),
                  year: any(named: 'year')))
              .thenAnswer((_) async => right(paginableMovies));

          await sut.getMovies(paginate: true);
        },
        expect: () => [
          isA<MoviesStatePaginating>(),
          isA<MoviesStateLoaded>(),
        ],
      );

      blocTest(
        "should emits [MoviesStatePaginating, MoviesStateFailure] if it is paginating and fails",
        build: () => sut,
        act: (cubit) async {
          when(() => movieRepository.getAll(
                  page: any(named: 'page'),
                  winnersOnly: any(named: 'winnersOnly'),
                  year: any(named: 'year')))
              .thenAnswer((_) async => left(Failure('message')));

          await sut.getMovies(paginate: true);
        },
        expect: () => [
          isA<MoviesStatePaginating>(),
          isA<MoviesStateFailure>(),
        ],
      );
    });
  });
}
