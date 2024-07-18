import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:hrk_flutter_test_batteries/hrk_flutter_test_batteries.dart';
import 'package:mocktail/mocktail.dart';
import 'package:outsera_challenge/src/features/dashboard/cubit/cubit.dart';
import 'package:outsera_challenge/src/features/dashboard/widgets/studio_card.dart';
import 'package:outsera_challenge/src/features/dashboard/widgets/widgets.dart';
import 'package:outsera_challenge/src/shared/shared.dart';

import '../../../../mocks/mocks.dart';
import '../../../../utils/create_widget.dart';

class DashboardCubitMock extends MockCubit<DashboardState>
    implements DashboardCubit {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late DashboardCubit dashboardCubit;

  setUp(() {
    dashboardCubit = DashboardCubitMock();
    GetIt.instance.registerFactory<DashboardCubit>(() => dashboardCubit);
  });

  tearDown(() {
    GetIt.instance.unregister<DashboardCubit>();
  });

  group('StudiosWithWins >', () {
    testWidgets('should show a skeleton loading while fetching data',
        (tester) async {
      when(() => dashboardCubit.state).thenReturn(DashboardLoading());

      await createWidget(
        tester: tester,
        widget: BlocProvider(
          create: (context) => dashboardCubit,
          child: const StudiosWithWins(),
        ),
      );

      expect(find.byType(Skeleton), findsAny);
    });

    testWidgets('should show the correct number of StudioCards widgets',
        (tester) async {
      disableOverflowError();
      when(() => dashboardCubit.state)
          .thenReturn(DashboardStudiosLoaded(studiosWithWins.take(2).toList()));

      await createWidget(
        tester: tester,
        widget: BlocProvider(
          create: (context) => dashboardCubit,
          child: const StudiosWithWins(),
        ),
      );

      expect(find.byType(StudioCard), findsNWidgets(2));
    });
  });
}
