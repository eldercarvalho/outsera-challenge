import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension SpaceExtension on num {
  SizedBox get height => SizedBox(height: h.toDouble());
  SizedBox get width => SizedBox(width: w.toDouble());
}
