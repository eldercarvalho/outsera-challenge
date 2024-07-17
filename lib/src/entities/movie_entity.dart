import 'package:equatable/equatable.dart';

class Movie extends Equatable {
  final int id;
  final String title;
  final int year;
  final List<String> studios;
  final List<String> producers;
  final bool isWinner;

  const Movie({
    required this.id,
    required this.title,
    required this.year,
    required this.studios,
    required this.producers,
    required this.isWinner,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        year,
        studios,
        producers,
        isWinner,
      ];
}
