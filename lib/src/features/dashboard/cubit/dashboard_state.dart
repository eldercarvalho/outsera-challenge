import 'package:equatable/equatable.dart';
import 'package:outsera_challenge/src/entities/entities.dart';

sealed class DashboardState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DashboardInitial extends DashboardState {}

class DashboardLoading extends DashboardState {}

class DashboardYearsLoaded extends DashboardState {
  final List<Year> years;

  DashboardYearsLoaded(this.years);

  @override
  List<Object?> get props => [years];
}

class DashboardYearsFailure extends DashboardState {
  final String message;

  DashboardYearsFailure(this.message);

  @override
  List<Object?> get props => [message];
}

class DashboardStudiosLoaded extends DashboardState {
  final List<Studio> studios;

  DashboardStudiosLoaded(this.studios);

  @override
  List<Object?> get props => [studios];
}

class DashboardProducersLoaded extends DashboardState {
  final MinMaxIntervalProducers minMaxIntervalProducers;

  DashboardProducersLoaded(this.minMaxIntervalProducers);

  @override
  List<Object?> get props => [minMaxIntervalProducers];
}

class DashboardMoviesSearching extends DashboardState {}

class DashboardMoviesLoaded extends DashboardState {
  final PaginableResult<Movie> movies;

  DashboardMoviesLoaded(this.movies);

  @override
  List<Object?> get props => [movies];
}
