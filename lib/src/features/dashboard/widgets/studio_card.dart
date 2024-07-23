import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:outsera_challenge/src/entities/studio_entity.dart';
import 'package:outsera_challenge/src/shared/extensions/extensions.dart';

import 'result_value.dart';

class StudioCard extends StatelessWidget {
  const StudioCard({super.key, required this.studio});

  final Studio studio;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200.w,
      // height: 120.h,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Studio:',
            style: context.textTheme.bodySmall?.copyWith(
              color: context.colorScheme.primary,
            ),
          ),
          3.height,
          Text(
            studio.name,
            style: context.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const Spacer(),
          ResultValue(
            label: 'Wins Count:',
            value: studio.winCount.toString(),
          ),
        ],
      ),
    );
  }
}
