import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:outsera_challenge/src/data/repositories/repositories.dart';
import 'package:outsera_challenge/src/features/dashboard/cubit/cubit.dart';

import '../../../../mocks/mocks.dart';

class MovieRepositoryMock extends Mock implements MovieRepository {}

class StudioRepositoryMock extends Mock implements StudioRepository {}

class YearRepositoryMock extends Mock implements YearRepository {}

class ProducerRepositoryMock extends Mock implements ProducerRepository {}

void main() {
  late MovieRepository movieRepository;
  late StudioRepository studioRepository;
  late YearRepository yearRepository;
  late ProducerRepository producerRepository;
  late DashboardCubit sut;

  setUp(() {
    movieRepository = MovieRepositoryMock();
    studioRepository = StudioRepositoryMock();
    yearRepository = YearRepositoryMock();
    producerRepository = ProducerRepositoryMock();
    sut = DashboardCubit(
      movieRepository: movieRepository,
      studioRepository: studioRepository,
      yearRepository: yearRepository,
      producerRepository: producerRepository,
    );
  });

  group('DashboardCubit >', () {
    group('getInitialContent >', () {
      blocTest(
        "Should emits [DashboardLoading, DashboardYearsLoaded, DashboardStudiosLoaded, DashboardProducersLoaded] when success case",
        build: () => sut,
        act: (cubit) async {
          when(() => studioRepository.getWithWins())
              .thenAnswer((_) async => right(studiosWithWins));
          when(() => yearRepository.getWithMoreThanOneWinner())
              .thenAnswer((_) async => right(yearsWithWinners));
          when(() => producerRepository.getMinMaxInterval())
              .thenAnswer((_) async => right(minMaxIntervalProducers));

          await sut.getInitialContent();
        },
        expect: () => [
          isA<DashboardLoading>(),
          isA<DashboardYearsLoaded>(),
          isA<DashboardStudiosLoaded>(),
          isA<DashboardProducersLoaded>(),
        ],
      );
    });

    group('getWinnerMoviesByYear >', () {
      blocTest(
        "Should emits [DashboardMoviesSearching, DashboardMoviesLoaded] when success case",
        build: () => sut,
        act: (cubit) async {
          when(() => movieRepository.getAll(
                  winnersOnly: true, year: any(named: 'year')))
              .thenAnswer((_) async => right(paginableMovies));

          await sut.getWinnerMoviesByYear(1994);
        },
        expect: () => [
          isA<DashboardMoviesSearching>(),
          isA<DashboardMoviesLoaded>(),
        ],
      );
    });
  });
}
