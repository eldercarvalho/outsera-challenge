import 'package:equatable/equatable.dart';
import 'package:outsera_challenge/src/entities/movie_entity.dart';

class MovieDto extends Equatable {
  final int id;
  final String title;
  final int year;
  final List<String> studios;
  final List<String> producers;
  final bool isWinner;

  const MovieDto({
    required this.id,
    required this.title,
    required this.year,
    required this.studios,
    required this.producers,
    required this.isWinner,
  });

  factory MovieDto.fromJson(Map<String, dynamic> json) {
    return MovieDto(
      id: json['id'],
      title: json['title'],
      year: json['year'],
      studios: List<String>.from(json['studios']),
      producers: List<String>.from(json['producers']),
      isWinner: json['winner'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'year': year,
      'studios': studios,
      'producers': producers,
      'winner': isWinner,
    };
  }

  Movie toEntity() {
    return Movie(
      id: id,
      title: title,
      year: year,
      studios: studios,
      producers: producers,
      isWinner: isWinner,
    );
  }

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
