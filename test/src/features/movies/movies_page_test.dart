import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:outsera_challenge/src/features/movies/cubit/cubit.dart';
import 'package:outsera_challenge/src/features/movies/movies_page.dart';
import 'package:outsera_challenge/src/shared/widgets/movie_card.dart';
import 'package:outsera_challenge/src/shared/widgets/years_dropdown.dart';

import '../../../mocks/paginable_movies.dart';
import '../../../utils/create_widget.dart';

class MoviesCubitMock extends MockCubit<MoviesState> implements MoviesCubit {}

class MoviesStateFake extends Fake implements MoviesState {}

void main() {
  late MoviesCubit moviesCubit;

  setUp(() {
    moviesCubit = MoviesCubitMock();
    GetIt.instance.registerFactory<MoviesCubit>(() => moviesCubit);
  });

  setUpAll(() {
    registerFallbackValue(MoviesStateFake());
  });

  tearDown(() {
    GetIt.instance.unregister<MoviesCubit>();
  });

  group('MoviesPage >', () {
    testWidgets('should show the corrent number of movie cards',
        (tester) async {
      when(() => moviesCubit.state).thenReturn(MoviesStateInitial());
      when(() => moviesCubit.getMovies()).thenAnswer((_) async {});
      when(() => moviesCubit.state)
          .thenReturn(MoviesStateLoaded(paginableMovies));

      await createWidget(
        tester: tester,
        widget: const MoviesPage(),
      );

      expect(find.byType(MovieCard), findsNWidgets(2));
    });

    testWidgets('should show a messsage when there are no movies',
        (tester) async {
      when(() => moviesCubit.state).thenReturn(MoviesStateInitial());
      when(() => moviesCubit.getMovies()).thenAnswer((_) async {
        when(() => moviesCubit.state)
            .thenReturn(MoviesStateLoaded(paginableMovies.copyWith(data: [])));
      });

      await createWidget(
        tester: tester,
        widget: const MoviesPage(),
      );

      expect(find.text('No movies found'), findsOneWidget);
    });

    testWidgets('should show filters chip if filter are active',
        (tester) async {
      when(() => moviesCubit.state).thenReturn(MoviesStateInitial());
      when(() => moviesCubit.getMovies()).thenAnswer((_) async {
        when(() => moviesCubit.state)
            .thenReturn(MoviesStateLoaded(paginableMovies.copyWith(data: [])));
      });

      await createWidget(
        tester: tester,
        widget: const MoviesPage(),
      );

      when(() => moviesCubit.getMovies(
          year: any(named: 'year'),
          winnersOnly: any(named: 'winnersOnly'))).thenAnswer((_) async {
        when(() => moviesCubit.state)
            .thenReturn(MoviesStateLoaded(paginableMovies.copyWith(data: [])));
      });

      await tester.tap(find.byIcon(Icons.filter_list_outlined));
      await tester.pump();
      await tester.tap(find.byType(YearsDropdown));
      await tester.pumpAndSettle();
      await tester.tap(find.text('2024'));
      await tester.pump();
      await tester.tap(find.text('Apply'));
      await tester.pump();

      expect(find.byKey(const Key('active_filters_year_chip')), findsOneWidget);
    });

    testWidgets('should a loading when paginating', (tester) async {
      final initialState = MoviesStateLoaded(paginableMovies.copyWith(
        page: 1,
        data: [
          ...paginableMovies.data,
          ...paginableMovies.data,
          ...paginableMovies.data,
          ...paginableMovies.data,
        ],
        total: 100,
        totalPages: 90,
      ));

      whenListen(
        moviesCubit,
        Stream.fromIterable([
          initialState,
          MoviesStatePaginating(initialState.movies),
        ]),
        initialState: initialState,
      );

      when(() => moviesCubit.getMovies()).thenAnswer((_) async {});

      await createWidget(
        tester: tester,
        widget: const MoviesPage(),
      );

      await tester.fling(
        find.byType(ListView),
        const Offset(0.0, -500.0),
        2000.0,
      );
      await tester.pump();
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });
}
