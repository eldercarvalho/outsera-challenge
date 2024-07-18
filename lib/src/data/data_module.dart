// coverage:ignore-file

import 'package:injectable/injectable.dart';
import 'package:outsera_challenge/src/config/injection/injection.dart';

import 'repositories/repositories.dart';

@module
abstract class DataModule {
  @lazySingleton
  MovieRepository get movieRepositoryImpl => MovieRepositoryImpl(
        httpClient: getIt(),
      );

  @lazySingleton
  YearRepository get yearRepository => YearRepositoryImpl(
        httpClient: getIt(),
      );

  @lazySingleton
  StudioRepository get studioRepository => StudioRepositoryImpl(
        httpClient: getIt(),
      );

  @lazySingleton
  ProducerRepository get producerRepository => ProducerRepositoryImpl(
        httpClient: getIt(),
      );
}
