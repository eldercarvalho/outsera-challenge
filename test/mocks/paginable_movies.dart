import 'package:outsera_challenge/src/entities/entities.dart';

const paginableMovies = PaginableResult<Movie>(
  data: [
    Movie(
      id: 1,
      title: 'The Shawshank Redemption',
      year: 1994,
      isWinner: true,
      studios: ['Castle Rock Entertainment'],
      producers: ['Niki Marvin'],
    ),
    Movie(
      id: 2,
      title: 'The Godfather',
      year: 1972,
      isWinner: true,
      studios: ['Paramount Pictures'],
      producers: ['Albert S. Ruddy'],
    ),
  ],
  page: 1,
  total: 999,
  totalPages: 99,
);
