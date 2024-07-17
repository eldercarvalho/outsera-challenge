import 'package:equatable/equatable.dart';
import 'package:outsera_challenge/src/entities/entities.dart';

sealed class MoviesState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class MoviesStateInitial extends MoviesState {}

final class MoviesStateLoading extends MoviesState {}

final class MoviesStatePaginating extends MoviesState {
  final PaginableResult<Movie> movies;

  MoviesStatePaginating(this.movies);

  @override
  List<Object?> get props => [movies];
}

final class MoviesStateLoaded extends MoviesState {
  final PaginableResult<Movie> movies;

  MoviesStateLoaded(this.movies);

  @override
  List<Object?> get props => [movies];
}

final class MoviesStateFailure extends MoviesState {
  final String message;

  MoviesStateFailure(this.message);

  @override
  List<Object?> get props => [message];
}
