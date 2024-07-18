// coverage:ignore-file

import 'package:injectable/injectable.dart';
import 'package:outsera_challenge/src/config/injection/injection.dart';
import 'package:outsera_challenge/src/features/dashboard/cubit/cubit.dart';

import 'movies/movies.dart';

@module
abstract class FeaturesModule {
  @injectable
  DashboardCubit get dashboardCubit => DashboardCubit(
        yearRepository: getIt(),
        studioRepository: getIt(),
        producerRepository: getIt(),
        movieRepository: getIt(),
      );

  @injectable
  MoviesCubit get moviesCubit => MoviesCubit(
        movieRepository: getIt(),
      );
}
