import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:outsera_challenge/src/shared/shared.dart';

import '../cubit/cubit.dart';
import 'dashboard_panel.dart';
import 'year_card.dart';

class YearsWithWinners extends StatelessWidget {
  const YearsWithWinners({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: context.read<DashboardCubit>(),
      buildWhen: _buildWhen,
      builder: (context, state) {
        if (state is DashboardLoading) {
          return _buildSkeleton();
        }

        if (state is DashboardYearsLoaded) {
          return DashboardPanel(
            titleIcon: Icons.emoji_events_outlined,
            iconColor: Colors.amber,
            title: 'Years with multiple winners',
            child: SizedBox(
              height: 120.h,
              child: ListView.separated(
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) => 16.width,
                itemCount: state.years.length,
                itemBuilder: (context, index) {
                  final year = state.years[index];

                  return YearCard(year: year);
                },
              ),
            ),
          );
        }

        return const SizedBox();
      },
    );
  }

  bool _buildWhen(_, DashboardState state) =>
      state is DashboardYearsLoaded ||
      state is DashboardYearsFailure ||
      state is DashboardLoading;

  Widget _buildSkeleton() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      scrollDirection: Axis.horizontal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Skeleton(
            width: 250.w,
            height: 18.h,
          ),
          16.height,
          Row(
            children: [
              Skeleton(
                width: 200.w,
                height: 120.h,
              ),
              16.width,
              Skeleton(
                width: 200.w,
                height: 120.h,
              ),
            ],
          )
        ],
      ),
    );
  }
}
