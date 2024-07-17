import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:outsera_challenge/src/entities/studio_entity.dart';
import 'package:outsera_challenge/src/shared/shared.dart';

import '../cubit/cubit.dart';
import 'dashboard_panel.dart';
import 'studio_card.dart';

class ProducersWithWitnInterval extends StatelessWidget {
  const ProducersWithWitnInterval({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: BlocProvider.of<DashboardCubit>(context),
      builder: (context, state) {
        if (state is DashboardLoading) {
          return _buildSkeleton();
        }

        if (state is DashboardStudiosLoaded) {
          List<Studio> studios = state.studios;
          studios.sort((a, b) => b.winCount.compareTo(a.winCount));
          studios = studios.take(3).toList();

          return Padding(
            padding: EdgeInsets.only(top: 24.h),
            child: DashboardPanel(
              iconColor: Colors.purpleAccent,
              titleIcon: Icons.movie_outlined,
              title: 'Top 3 studios with winners',
              child: SizedBox(
                height: 120.h,
                child: ListView.separated(
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (context, index) => 16.width,
                  itemCount: studios.length,
                  itemBuilder: (context, index) {
                    final studio = studios[index];

                    return StudioCard(studio: studio);
                  },
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
