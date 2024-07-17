import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:injectable/injectable.dart';
import 'package:outsera_challenge/app.dart';
import 'package:outsera_challenge/src/config/injection/injection.dart';

Future<void> main() async {
  await configureDependencyInjection(Environment.dev);

  await ScreenUtil.ensureScreenSize();
  runApp(const App());
}
