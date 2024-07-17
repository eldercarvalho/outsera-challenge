import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:outsera_challenge/src/config/injection/injection.dart';

import 'cubit/cubit.dart';
import 'widgets/widgets.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final DashboardCubit _cubit = getIt();
  final _scrollController = ScrollController();

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
        child: SingleChildScrollView(
          controller: _scrollController,
          padding: EdgeInsets.only(top: 16.h, bottom: 30.h),
          child: Column(
            children: [
              const YearsWithWinners(),
              const StudiosWithWins(),
              const MinMaxIntervervalProducers(),
              WinnerMoviesByYear(onSearched: _onSearched),
            ],
          ),
        ),
      ),
    );
  }

  void _onSearched() async {
    await Future.delayed(const Duration(milliseconds: 100));
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }
}
