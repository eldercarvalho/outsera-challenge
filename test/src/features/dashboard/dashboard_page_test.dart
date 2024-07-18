import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:outsera_challenge/src/features/dashboard/cubit/cubit.dart';
import 'package:outsera_challenge/src/features/dashboard/dashboard_page.dart';
import 'package:outsera_challenge/src/features/dashboard/widgets/widgets.dart';
import 'package:outsera_challenge/src/features/movies/cubit/cubit.dart';

import '../../../utils/create_widget.dart';

class DashboardCubitMock extends MockCubit<DashboardState>
    implements DashboardCubit {}

class MoviesStateFake extends Fake implements MoviesState {}

void main() {
  late DashboardCubit dashboardCubit;

  setUp(() {
    dashboardCubit = DashboardCubitMock();
    GetIt.instance.registerFactory<DashboardCubit>(() => dashboardCubit);
  });

  setUpAll(() {
    registerFallbackValue(MoviesStateFake());
  });

  tearDown(() {
    GetIt.instance.unregister<DashboardCubit>();
  });

  group('DashboardPage >', () {
    testWidgets('should show the correct sections', (tester) async {
      when(() => dashboardCubit.state).thenReturn(DashboardInitial());
      when(() => dashboardCubit.getInitialContent()).thenAnswer((_) async {});

      await createWidget(
        tester: tester,
        widget: const DashboardPage(),
      );

      expect(find.byType(YearsWithWinners), findsOneWidget);
      expect(find.byType(StudiosWithWins), findsOneWidget);
      expect(find.byType(MinMaxIntervervalProducers), findsOneWidget);
      expect(find.byType(WinnerMoviesByYear), findsOneWidget);
    });
  });
}
