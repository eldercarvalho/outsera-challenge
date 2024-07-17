// ignore_for_file: prefer_final_fields

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:outsera_challenge/src/data/repositories/repositories.dart';
import 'package:outsera_challenge/src/entities/entities.dart';

import 'movies_state.dart';

class MoviesCubit extends Cubit<MoviesState> {
  late final MovieRepository _movieRepository;

  MoviesCubit({
    required MovieRepository movieRepository,
  }) : super(MoviesStateInitial()) {
    _movieRepository = movieRepository;
  }

  bool _hasReachTotalPages = false;
  PaginableResult<Movie> _lastResult = PaginableResult.empty();

  Future<void> getMovies({
    int? year,
    bool? winnersOnly,
    bool paginate = false,
  }) async {
    if (paginate) {
      if (_hasReachTotalPages) {
        return;
      }

      emit(MoviesStatePaginating(_lastResult));
    } else {
      _lastResult = PaginableResult.empty();
      emit(MoviesStateLoading());
    }

    final result = await _movieRepository.getAll(
      page: paginate ? _lastResult.page + 1 : 0,
      year: year,
      winnersOnly: winnersOnly,
    );

    result.fold(
      (failure) => emit(MoviesStateFailure('message')),
      (paginableMovies) {
        if (paginate) {
          _lastResult = _lastResult.copyWith(
            data: _lastResult.data + paginableMovies.data,
            page: paginableMovies.page,
            total: paginableMovies.total,
            totalPages: paginableMovies.totalPages,
          );

          if (_lastResult.page >= paginableMovies.totalPages) {
            _hasReachTotalPages = true;
          }

          emit(MoviesStateLoaded(_lastResult));

          return;
        }

        _lastResult = paginableMovies;
        _hasReachTotalPages = false;
        emit(MoviesStateLoaded(paginableMovies));
      },
    );
  }
}
