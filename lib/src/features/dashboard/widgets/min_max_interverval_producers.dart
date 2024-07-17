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
          final maxProducer = state.minMaxIntervalProducers.max.first;
          final minProducer = state.minMaxIntervalProducers.min.first;

          return Padding(
            padding: EdgeInsets.only(top: 24.h),
            child: DashboardPanel(
              iconColor: Colors.greenAccent,
              titleIcon: Icons.schedule_outlined,
              title: 'Producers with long and short interval between wins',
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w)
                              .copyWith(bottom: 8.h),
                          child: Text(
                            'Maximun',
                            style: context.textTheme.bodyLarge
                                ?.copyWith(color: Colors.redAccent),
                          ),
                        ),
                        ProducerCard(producer: maxProducer),
                      ],
                    ),
                    16.width,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w)
                              .copyWith(bottom: 8.h),
                          child: Text(
                            'Minimum',
                            style: context.textTheme.bodyLarge
                                ?.copyWith(color: Colors.greenAccent),
                          ),
                        ),
                        ProducerCard(producer: minProducer),
                      ],
                    ),
                  ],
                ),
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
            height: 30.h,
          ),
          16.height,
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Skeleton(
                    width: 100.w,
                    height: 10.h,
                  ),
                  8.height,
                  Skeleton(
                    width: 200.w,
                    height: 170.h,
                  ),
                ],
              ),
              16.width,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Skeleton(
                    width: 100.w,
                    height: 10.h,
                  ),
                  8.height,
                  Skeleton(
                    width: 200.w,
                    height: 170.h,
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
