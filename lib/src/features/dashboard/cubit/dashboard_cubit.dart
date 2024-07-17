import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:outsera_challenge/src/data/repositories/repositories.dart';

import 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  late final YearRepository _yearRepository;
  late final StudioRepository _studioRepository;
  late final ProducerRepository _producerRepository;
  late final MovieRepository _movieRepository;

  DashboardCubit({
    required YearRepository yearRepository,
    required StudioRepository studioRepository,
    required ProducerRepository producerRepository,
    required MovieRepository movieRepository,
  }) : super(DashboardInitial()) {
    _yearRepository = yearRepository;
    _studioRepository = studioRepository;
    _producerRepository = producerRepository;
    _movieRepository = movieRepository;
  }

  Future<void> getInitialContent() async {
    emit(DashboardLoading());

    final yearsResult = await _yearRepository.getWithMoreThanOneWinner();
    final studiosResult = await _studioRepository.getWithWins();
    final producersResult = await _producerRepository.getMinMaxInterval();

    yearsResult.fold(
      (failure) => emit(DashboardYearsFailure('')),
      (years) => emit(DashboardYearsLoaded(years)),
    );

    studiosResult.fold(
      (failure) => emit(DashboardYearsFailure('')),
      (studios) => emit(DashboardStudiosLoaded(studios)),
    );

    producersResult.fold(
      (failure) => emit(DashboardYearsFailure('')),
      (producers) => emit(DashboardProducersLoaded(producers)),
    );
  }

  Future<void> getWinnerMoviesByYear(int year) async {
    emit(DashboardMoviesSearching());

    final moviesResult = await _movieRepository.getAll(
      year: year,
      winnersOnly: true,
    );

    moviesResult.fold(
      (failure) => emit(DashboardYearsFailure('')),
      (movies) => emit(DashboardMoviesLoaded(movies)),
    );
  }
}
