import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:outsera_challenge/src/data/repositories/repositories.dart';

import 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  late final YearRepository _yearRepository;
  late final StudioRepository _studioRepository;

  DashboardCubit({
    required YearRepository yearRepository,
    required StudioRepository studioRepository,
  }) : super(DashboardInitial()) {
    _yearRepository = yearRepository;
    _studioRepository = studioRepository;
  }

  Future<void> getInitialContent() async {
    emit(DashboardLoading());

    final yearsResult = await _yearRepository.getWithMoreThanOneWinner();
    final studiosResult = await _studioRepository.getWithWins();

    yearsResult.fold(
      (failure) => emit(DashboardYearsFailure('')),
      (years) => emit(DashboardYearsLoaded(years)),
    );

    studiosResult.fold(
      (failure) => emit(DashboardYearsFailure('')),
      (studios) => emit(DashboardStudiosLoaded(studios)),
    );
  }
}
