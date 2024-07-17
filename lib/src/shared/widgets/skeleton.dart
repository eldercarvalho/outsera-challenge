import 'package:flutter/material.dart';
import 'package:outsera_challenge/src/shared/extensions/extensions.dart';
import 'package:shimmer/shimmer.dart';

class Skeleton extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;
  final double opacity;

  const Skeleton({
    super.key,
    this.width = double.infinity,
    required this.height,
    this.borderRadius = 8,
    this.opacity = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacity,
      child: Shimmer.fromColors(
        baseColor: context.colorScheme.surfaceContainerHighest,
        highlightColor: const Color(0xFF54585E),
        period: const Duration(milliseconds: 900),
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: context.colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
      ),
    );
  }
}
