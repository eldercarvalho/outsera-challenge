import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:outsera_challenge/src/config/injection/injection.dart';
import 'package:outsera_challenge/src/features/dashboard/widgets/widgets.dart';

import 'cubit/cubit.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final DashboardCubit _cubit = getIt();

  @override
  void initState() {
    _cubit.getInitialContent();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: BlocProvider(
        create: (context) => _cubit,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16.w),
          child: const SingleChildScrollView(
            child: Column(
              children: [
                YearsWithWinners(),
                StudiosWithWins(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
