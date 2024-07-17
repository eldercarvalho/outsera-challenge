import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:outsera_challenge/src/entities/producer_entity.dart';
import 'package:outsera_challenge/src/features/dashboard/widgets/result_value.dart';
import 'package:outsera_challenge/src/shared/extensions/extensions.dart';

class ProducerCard extends StatelessWidget {
  const ProducerCard({super.key, required this.producer});

  final Producer producer;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200.w,
      height: 170.h,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Producer:',
            style: context.textTheme.bodySmall?.copyWith(
              color: context.colorScheme.primary,
            ),
          ),
          3.height,
          Text(
            producer.name,
            style: context.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          16.height,
          ResultValue(
            label: 'Interval:',
            value: producer.intervalBetweenWins.toString(),
          ),
          ResultValue(
            label: 'Previous Year:',
            value: producer.previousWinYear.toString(),
          ),
          ResultValue(
            label: 'Following Year:',
            value: producer.followingWinYear.toString(),
          ),
        ],
      ),
    );
  }
}
