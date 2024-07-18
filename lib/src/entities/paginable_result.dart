import 'package:equatable/equatable.dart';

class PaginableResult<T> extends Equatable {
  final List<T> data;
  final int page;
  final int total;
  final int totalPages;

  bool get hasReachedTotalPages => page >= totalPages;
  bool get isFirstPage => page == 1;

  static PaginableResult<T> empty<T, R>() => const PaginableResult(
        data: [],
        page: -1,
        total: 0,
        totalPages: 0,
      );

  const PaginableResult({
    required this.data,
    required this.page,
    required this.total,
    required this.totalPages,
  });

  PaginableResult<T> copyWith({
    List<T>? data,
    int? page,
    int? total,
    int? totalPages,
  }) {
    return PaginableResult(
      data: data ?? this.data,
      page: page ?? this.page,
      total: total ?? this.total,
      totalPages: totalPages ?? this.totalPages,
    );
  }

  @override
  List<Object?> get props => [data, page, total, totalPages];
}
