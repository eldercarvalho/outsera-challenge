import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:outsera_challenge/src/shared/shared.dart';

class DashboardPanel extends StatelessWidget {
  const DashboardPanel({
    super.key,
    required this.title,
    required this.child,
    required this.titleIcon,
    required this.iconColor,
    this.withPading = false,
  });

  final String title;
  final Widget child;
  final IconData titleIcon;
  final Color iconColor;
  final bool withPading;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // color: context.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              children: [
                Icon(
                  titleIcon,
                  size: 24.sp,
                  color: iconColor,
                ),
                8.width,
                Expanded(
                  child: Text(
                    title,
                    style: context.textTheme.titleLarge,
                  ),
                ),
              ],
            ),
          ),
          16.height,
          withPading
              ? Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w), child: child)
              : child,
        ],
      ),
    );
  }
}
