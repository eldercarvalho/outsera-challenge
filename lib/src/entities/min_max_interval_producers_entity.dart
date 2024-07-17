import 'package:equatable/equatable.dart';
import 'package:outsera_challenge/src/entities/producer_entity.dart';

class MinMaxIntervalProducers extends Equatable {
  final List<Producer> min;
  final List<Producer> max;

  const MinMaxIntervalProducers({
    required this.min,
    required this.max,
  });

  @override
  List<Object?> get props => [min, max];
}
