import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:outsera_challenge/src/features/movies/widgets/filters_dialog.dart';
import 'package:outsera_challenge/src/shared/extensions/extensions.dart';

class ActiveFilters extends StatelessWidget {
  const ActiveFilters({
    super.key,
    required this.filters,
    required this.onClearYear,
    required this.onClearWinnersOnly,
  });

  final Filters filters;
  final Function() onClearYear;
  final Function() onClearWinnersOnly;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Row(
        children: [
          if (filters.hasYear)
            Chip(
              key: const Key('active_filters_year_chip'),
              label: Text(
                'Year: ${filters.year}',
                style: context.textTheme.labelMedium?.copyWith(
                  color: context.colorScheme.onPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onDeleted: onClearYear,
              backgroundColor: context.colorScheme.primary,
              deleteIconColor: context.colorScheme.onPrimary,
              side: BorderSide.none,
            ),
          if (filters.winnersOnly)
            Padding(
              padding: EdgeInsets.only(left: 8.w),
              child: Chip(
                key: const Key('active_filters_winners_chip'),
                label: Text(
                  'Winners Only',
                  style: context.textTheme.labelMedium?.copyWith(
                    color: context.colorScheme.onPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onDeleted: onClearWinnersOnly,
                backgroundColor: context.colorScheme.primary,
                deleteIconColor: context.colorScheme.onPrimary,
                side: BorderSide.none,
              ),
            ),
        ],
      ),
    );
  }
}
