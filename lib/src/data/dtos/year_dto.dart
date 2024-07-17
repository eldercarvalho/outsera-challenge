import 'package:equatable/equatable.dart';
import 'package:outsera_challenge/src/entities/year_entity.dart';

class YearDto extends Equatable {
  const YearDto({
    required this.year,
    required this.winnersCount,
  });

  final int year;
  final int winnersCount;

  factory YearDto.fromJson(Map<String, dynamic> json) {
    return YearDto(
      year: json['year'] as int,
      winnersCount: json['winnerCount'] as int,
    );
  }

  static List<Year> toEntityList(List<YearDto> dtos) {
    return dtos.map((e) => e.toEntity()).toList();
  }

  Year toEntity() {
    return Year(
      year: year,
      winnersCount: winnersCount,
    );
  }

  @override
  List<Object> get props => [winnersCount, year];
}
