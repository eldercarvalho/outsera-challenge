import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:outsera_challenge/src/entities/movie_entity.dart';
import 'package:outsera_challenge/src/shared/extensions/extensions.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({super.key, required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: context.colorScheme.surfaceContainerHighest,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${movie.id} ${movie.title}',
                  style: context.textTheme.titleMedium?.copyWith(
                    color: context.colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                12.height,
                Row(
                  children: [
                    Text(
                      'Ano: ${movie.year}',
                      style: context.textTheme.bodySmall,
                    ),
                    12.width,
                    Expanded(
                      child: Text(
                        'Produtores: ${movie.producers.join(', ')}',
                        style: context.textTheme.bodySmall,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          if (movie.isWinner)
            Icon(
              Icons.emoji_events_outlined,
              color: Colors.amber,
              size: 26.sp,
            ),
        ],
      ),
    );
  }
}
