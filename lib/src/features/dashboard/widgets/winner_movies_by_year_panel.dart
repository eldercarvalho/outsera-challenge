import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:outsera_challenge/src/shared/shared.dart';

import '../cubit/cubit.dart';
import 'dashboard_panel.dart';

class WinnerMoviesByYear extends StatefulWidget {
  const WinnerMoviesByYear({super.key, required this.onSearched});

  final Function() onSearched;

  @override
  State<WinnerMoviesByYear> createState() => _WinnerMoviesByYearState();
}

class _WinnerMoviesByYearState extends State<WinnerMoviesByYear> {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DashboardCubit>();

    return Padding(
      padding: EdgeInsets.only(top: 24.h),
      child: DashboardPanel(
        title: 'Winner Movies per Year',
        titleIcon: Icons.movie_outlined,
        iconColor: Colors.blueAccent,
        withPading: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            YearsDropdown(
              onChanged: (year) => cubit.getWinnerMoviesByYear(year),
            ),
            20.height,
            BlocConsumer<DashboardCubit, DashboardState>(
              bloc: cubit,
              listener: (context, state) {
                if (state is DashboardMoviesLoaded) {
                  widget.onSearched();
                }
              },
              buildWhen: (_, state) =>
                  state is DashboardMoviesSearching ||
                  state is DashboardMoviesLoaded,
              builder: (context, state) {
                if (state is DashboardMoviesSearching) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is DashboardMoviesLoaded) {
                  if (state.movies.data.isEmpty) {
                    return Center(
                      child: Text(
                        'No movies found',
                        style: context.textTheme.titleLarge,
                      ),
                    );
                  }

                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    separatorBuilder: (_, __) => 8.height,
                    itemCount: state.movies.data.length,
                    itemBuilder: (context, index) {
                      final movie = state.movies.data[index];

                      return MovieCard(movie: movie);
                    },
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}
