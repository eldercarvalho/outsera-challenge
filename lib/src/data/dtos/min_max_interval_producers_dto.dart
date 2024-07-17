import 'package:equatable/equatable.dart';
import 'package:outsera_challenge/src/entities/min_max_interval_producers_entity.dart';

import 'producer_dto.dart';

class MinMaxIntervalProducersDto extends Equatable {
  final List<ProducerDto> min;
  final List<ProducerDto> max;

  const MinMaxIntervalProducersDto({
    required this.min,
    required this.max,
  });

  factory MinMaxIntervalProducersDto.fromJson(Map<String, dynamic> json) {
    return MinMaxIntervalProducersDto(
      min: (json['min'] as List)
          .map((e) => ProducerDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      max: (json['max'] as List)
          .map((e) => ProducerDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  MinMaxIntervalProducers toEntity() {
    return MinMaxIntervalProducers(
      min: min.map((e) => e.toEntity()).toList(),
      max: max.map((e) => e.toEntity()).toList(),
    );
  }

  @override
  List<Object?> get props => [min, max];
}
