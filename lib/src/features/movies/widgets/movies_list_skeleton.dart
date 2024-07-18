import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:outsera_challenge/src/shared/shared.dart';

class MoviesListSkeleton extends StatelessWidget {
  const MoviesListSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Skeleton(height: 85.h),
          12.height,
          Skeleton(height: 85.h),
          12.height,
          Skeleton(height: 85.h),
          12.height,
          Skeleton(height: 85.h),
          12.height,
          Skeleton(height: 85.h),
          12.height,
        ],
      ),
    );
  }
}
