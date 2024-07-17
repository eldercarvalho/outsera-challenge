import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:outsera_challenge/src/shared/shared.dart';

import '../cubit/cubit.dart';
import 'dashboard_panel.dart';
import 'producer_card.dart';

class MinMaxIntervervalProducers extends StatelessWidget {
  const MinMaxIntervervalProducers({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: BlocProvider.of<DashboardCubit>(context),
      buildWhen: (_, state) =>
          state is DashboardProducersLoaded || state is DashboardLoading,
      builder: (context, state) {
        if (state is DashboardLoading) {
          return _buildSkeleton();
        }

        if (state is DashboardProducersLoaded) {
          return Padding(
            padding: EdgeInsets.only(top: 24.h),
            child: DashboardPanel(
              iconColor: Colors.greenAccent,
              titleIcon: Icons.schedule_outlined,
              title: 'Producers with long and short interval between wins',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w)
                        .copyWith(bottom: 16.h),
                    child: Text(
                      'Maximun',
                      style: context.textTheme.bodyLarge
                          ?.copyWith(color: Colors.redAccent),
                    ),
                  ),
                  SizedBox(
                    height: 170.h,
                    child: ListView.separated(
                      shrinkWrap: true,
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (context, index) => 16.width,
                      itemCount: state.minMaxIntervalProducers.max.length,
                      itemBuilder: (context, index) {
                        final producer =
                            state.minMaxIntervalProducers.max[index];

                        return ProducerCard(producer: producer);
                      },
                    ),
                  ),
                  20.height,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w)
                        .copyWith(bottom: 16.h),
                    child: Text(
                      'Minimum',
                      style: context.textTheme.bodyLarge
                          ?.copyWith(color: Colors.greenAccent),
                    ),
                  ),
                  SizedBox(
                    height: 170.h,
                    child: ListView.separated(
                      shrinkWrap: true,
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (context, index) => 16.width,
                      itemCount: state.minMaxIntervalProducers.min.length,
                      itemBuilder: (context, index) {
                        final producer =
                            state.minMaxIntervalProducers.min[index];

                        return ProducerCard(producer: producer);
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        return const SizedBox();
      },
    );
  }

  Widget _buildSkeleton() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16.w).copyWith(top: 24.h),
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
