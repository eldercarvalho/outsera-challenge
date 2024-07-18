import 'package:dartz/dartz.dart';
import 'package:outsera_challenge/src/entities/entities.dart';

abstract interface class MovieRepository {
  Future<Either<Failure, PaginableResult<Movie>>> getAll({
    int page = 0,
    int limit = 10,
    bool? winnersOnly,
    int? year,
  });
}
