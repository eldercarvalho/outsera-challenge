import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final textTheme = ThemeData.dark().textTheme.copyWith(
      headlineLarge: TextStyle(
        fontFamily: 'Quicksand',
        fontSize: 30.sp,
        fontWeight: FontWeight.w500,
      ),
      headlineMedium: TextStyle(
        fontFamily: 'Quicksand',
        fontSize: 26.sp,
        color: const Color(0xFF5F5F5F),
        fontWeight: FontWeight.w500,
      ),
      headlineSmall: TextStyle(
        fontFamily: 'Quicksand',
        fontSize: 20.sp,
        color: const Color(0xFF5F5F5F),
        fontWeight: FontWeight.w500,
      ),
      titleLarge: TextStyle(
        fontFamily: 'Quicksand',
        fontSize: 18.sp,
        fontWeight: FontWeight.bold,
        // color: const Color(0xFFA0CAFD),
      ),
      titleMedium: TextStyle(
        fontFamily: 'Quicksand',
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        height: 1.4,
      ),
      titleSmall: TextStyle(
        fontFamily: 'Quicksand',
        fontSize: 14.sp,
        fontWeight: FontWeight.w700,
      ),
      labelLarge: TextStyle(
        fontFamily: 'Quicksand',
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        height: 1,
      ),
      labelMedium: TextStyle(
        fontFamily: 'Quicksand',
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        height: 1,
      ),
      labelSmall: TextStyle(
        fontFamily: 'Quicksand',
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'Quicksand',
        fontSize: 16.sp,
        fontWeight: FontWeight.w300,
      ),
      bodySmall: TextStyle(
        fontFamily: 'Quicksand',
        fontSize: 14.sp,
        fontWeight: FontWeight.w300,
      ),
    );
