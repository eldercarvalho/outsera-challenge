import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:outsera_challenge/src/config/config.dart';

Future createWidget({
  required WidgetTester tester,
  required Widget widget,
  bool usePumpAndSettle = false,
}) async {
  // await tester.binding.setSurfaceSize(const Size(372, 812));

  await tester.pumpWidget(
    ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'Coursera Challenge',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.dark,
          themeMode: ThemeMode.dark,
          home: Scaffold(
            body: SafeArea(
              child: widget,
            ),
          ),
          onGenerateRoute: (settings) => AppRouter.generateRoutes(settings),
        );
      },
    ),
  );

  if (usePumpAndSettle) {
    await tester.pumpAndSettle();
  } else {
    await tester.pump();
  }
}

Future<void> waitFor(
  WidgetTester tester,
  Finder finder, {
  Duration timeout = const Duration(seconds: 20),
}) async {
  final end = tester.binding.clock.now().add(timeout);

  do {
    if (tester.binding.clock.now().isAfter(end)) {
      throw Exception('Timed out waiting for $finder');
    }

    await tester.pumpAndSettle();
    await Future.delayed(const Duration(milliseconds: 100));
  } while (finder.evaluate().isEmpty);
}
