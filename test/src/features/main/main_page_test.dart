import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:hrk_flutter_test_batteries/hrk_flutter_test_batteries.dart';
import 'package:mocktail/mocktail.dart';
import 'package:outsera_challenge/src/features/dashboard/cubit/cubit.dart';
import 'package:outsera_challenge/src/features/main/main_page.dart';
import 'package:outsera_challenge/src/features/movies/cubit/cubit.dart';
import 'package:outsera_challenge/src/features/movies/movies_page.dart';

import '../../../utils/create_widget.dart';

class DashboardCubitMock extends MockCubit<DashboardState>
    implements DashboardCubit {}

class MoviesCubitMock extends MockCubit<MoviesState> implements MoviesCubit {}

void main() {
  late DashboardCubit dashboardCubit;
  late MoviesCubit moviesCubit;

  setUp(() {
    dashboardCubit = DashboardCubitMock();
    moviesCubit = MoviesCubitMock();
    GetIt.instance.registerFactory<DashboardCubit>(() => dashboardCubit);
    GetIt.instance.registerFactory<MoviesCubit>(() => moviesCubit);
  });

  tearDown(() {
    GetIt.instance.unregister<DashboardCubit>();
    GetIt.instance.unregister<MoviesCubit>();
  });

  group('MainPage >', () {
    testWidgets('should show a BottomNavigationBar with correct items',
        (tester) async {
      when(() => dashboardCubit.state).thenReturn(DashboardInitial());
      when(() => dashboardCubit.getInitialContent()).thenAnswer((_) async {});

      await createWidget(
        tester: tester,
        widget: const MainPage(),
      );

      expect(find.byType(BottomNavigationBar), findsOneWidget);
      expect(find.byIcon(Icons.dashboard_outlined), findsOneWidget);
      expect(find.byIcon(Icons.movie_outlined), findsNWidgets(2));
    });

    testWidgets('should change page when tapping on BottomNavigationBar item',
        (tester) async {
      disableOverflowError();
      when(() => dashboardCubit.state).thenReturn(DashboardInitial());
      when(() => dashboardCubit.getInitialContent()).thenAnswer((_) async {});
      when(() => moviesCubit.state).thenReturn(MoviesStateInitial());
      when(() => moviesCubit.getMovies()).thenAnswer((_) async {});

      await createWidget(
        tester: tester,
        widget: const MainPage(),
      );

      await tester.tap(find.byKey(const Key('nav_movies')));
      await tester.pumpAndSettle();

      expect(find.byType(MoviesPage), findsOneWidget);
    });
  });
}
