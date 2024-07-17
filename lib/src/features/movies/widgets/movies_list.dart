import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:outsera_challenge/src/entities/movie_entity.dart';
import 'package:outsera_challenge/src/shared/shared.dart';

import '../cubit/cubit.dart';

class MoviesList extends StatelessWidget {
  const MoviesList({
    super.key,
    required this.movies,
    required this.controller,
  });

  final List<Movie> movies;
  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView.separated(
          controller: controller,
          padding: EdgeInsets.all(16.w),
          itemCount: movies.length,
          itemBuilder: (context, index) {
            final movie = movies[index];
            return MovieCard(
              key: ObjectKey(movie),
              movie: movie,
            );
          },
          separatorBuilder: (context, index) {
            return 12.height;
          },
        ),
        _buildLoadingIndicator(context),
      ],
    );
  }

  Widget _buildLoadingIndicator(BuildContext context) {
    final isPaginating =
        context.watch<MoviesCubit>().state is MoviesStatePaginating;

    return isPaginating
        ? Positioned(
            bottom: 16.h,
            right: 0,
            left: 0,
            child: Center(
              child: Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: context.colorScheme.surface,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: SizedBox(
                  width: 30.w,
                  height: 30.w,
                  child: const CircularProgressIndicator(),
                ),
              ),
            ),
          )
        : const SizedBox.shrink();
  }
}
