// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:outsera_challenge/src/data/data_module.dart' as _i9;
import 'package:outsera_challenge/src/data/repositories/repositories.dart'
    as _i6;
import 'package:outsera_challenge/src/features/dashboard/cubit/cubit.dart'
    as _i3;
import 'package:outsera_challenge/src/features/features_module.dart' as _i7;
import 'package:outsera_challenge/src/features/movies/movies.dart' as _i4;
import 'package:outsera_challenge/src/infra/http/http.dart' as _i5;
import 'package:outsera_challenge/src/infra/infra_module.dart' as _i8;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final featuresModule = _$FeaturesModule();
    final infraModule = _$InfraModule();
    final dataModule = _$DataModule();
    gh.factory<_i3.DashboardCubit>(() => featuresModule.dashboardCubit);
    gh.factory<_i4.MoviesCubit>(() => featuresModule.moviesCubit);
    gh.lazySingleton<_i5.HttpClient>(() => infraModule.httpClient);
    gh.lazySingleton<_i6.MovieRepository>(() => dataModule.movieRepositoryImpl);
    gh.lazySingleton<_i6.YearRepository>(() => dataModule.yearRepository);
    gh.lazySingleton<_i6.StudioRepository>(() => dataModule.studioRepository);
    gh.lazySingleton<_i6.ProducerRepository>(
        () => dataModule.producerRepository);
    return this;
  }
}

class _$FeaturesModule extends _i7.FeaturesModule {}

class _$InfraModule extends _i8.InfraModule {}

class _$DataModule extends _i9.DataModule {}
