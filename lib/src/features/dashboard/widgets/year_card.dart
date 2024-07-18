import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:outsera_challenge/src/entities/year_entity.dart';
import 'package:outsera_challenge/src/shared/extensions/extensions.dart';

import 'result_value.dart';

class YearCard extends StatelessWidget {
  const YearCard({super.key, required this.year});

  final Year year;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200.w,
      height: 120.h,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Year:',
            style: context.textTheme.bodySmall?.copyWith(
              color: context.colorScheme.primary,
            ),
          ),
          3.height,
          Text(
            year.year.toString(),
            style: context.textTheme.titleLarge,
          ),
          16.height,
          ResultValue(
            label: 'Winners:',
            value: year.winnersCount.toString(),
          ),
        ],
      ),
    );
  }
}
