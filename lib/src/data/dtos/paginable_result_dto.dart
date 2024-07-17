import 'package:equatable/equatable.dart';
import 'package:outsera_challenge/src/entities/paginable_result.dart';

class PaginableResultDto<T> extends Equatable {
  final int total;
  final int page;
  final int totalPages;
  final List<T> data;

  const PaginableResultDto({
    required this.total,
    required this.page,
    required this.data,
    required this.totalPages,
  });

  factory PaginableResultDto.fromJson(
    Map<String, dynamic> json, {
    required T Function(Map<String, dynamic> data) parseData,
  }) {
    final data =
        List.from(json['content']).map((data) => parseData(data)).toList();

    return PaginableResultDto(
      total: json['totalElements'],
      totalPages: json['totalPages'],
      page: json['pageable']['pageNumber'],
      data: data,
    );
  }

  PaginableResult<R> toEntity<R>({
    required R Function(T data) parseDataToEntity,
  }) {
    return PaginableResult(
      total: total,
      page: page,
      totalPages: totalPages,
      data: data.map((data) => parseDataToEntity(data)).toList(),
    );
  }

  @override
  List<Object?> get props => [
        total,
        page,
        data,
      ];
}
