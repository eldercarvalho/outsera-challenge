import 'package:equatable/equatable.dart';
import 'package:outsera_challenge/src/entities/producer_entity.dart';

class ProducerDto extends Equatable {
  final String name;
  final int intervalBetweenWins;
  final int previousWinYear;
  final int followingWinYear;

  const ProducerDto({
    required this.name,
    required this.intervalBetweenWins,
    required this.previousWinYear,
    required this.followingWinYear,
  });

  factory ProducerDto.fromJson(Map<String, dynamic> json) {
    return ProducerDto(
      name: json['producer'] as String,
      intervalBetweenWins: json['interval'] as int,
      previousWinYear: json['previousWin'] as int,
      followingWinYear: json['followingWin'] as int,
    );
  }

  Producer toEntity() {
    return Producer(
      name: name,
      intervalBetweenWins: intervalBetweenWins,
      previousWinYear: previousWinYear,
      followingWinYear: followingWinYear,
    );
  }

  @override
  List<Object?> get props => [
        name,
        intervalBetweenWins,
        previousWinYear,
        followingWinYear,
      ];
}
