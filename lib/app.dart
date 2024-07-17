import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:outsera_challenge/src/config/config.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      useInheritedMediaQuery: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'Outsera Challenge',
          debugShowCheckedModeBanner: false,
          darkTheme: AppTheme.dark,
          themeMode: ThemeMode.dark,
          // home: const MoviesPage(),
          onGenerateRoute: (settings) => AppRouter.generateRoutes(settings),
        );
      },
    );
  }
}
