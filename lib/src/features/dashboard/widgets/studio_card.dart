import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:outsera_challenge/src/entities/studio_entity.dart';
import 'package:outsera_challenge/src/shared/extensions/extensions.dart';

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
            style: context.textTheme.bodySmall,
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
          16.height,
          Text(
            'Wins Count: ${studio.winCount.toString()}',
            style: context.textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}
