import 'package:equatable/equatable.dart';

class Producer extends Equatable {
  final String name;
  final int intervalBetweenWins;
  final int previousWinYear;
  final int followingWinYear;

  const Producer({
    required this.name,
    required this.intervalBetweenWins,
    required this.previousWinYear,
    required this.followingWinYear,
  });

  @override
  List<Object?> get props => [];
}
