import 'package:dartz/dartz.dart';
import 'package:outsera_challenge/src/data/dtos/dtos.dart';
import 'package:outsera_challenge/src/entities/entities.dart';
import 'package:outsera_challenge/src/infra/http/http.dart';

import 'movie_repository.dart';

class MovieRepositoryImpl implements MovieRepository {
  late final HttpClient _httpClient;

  MovieRepositoryImpl({required HttpClient httpClient}) {
    _httpClient = httpClient;
  }

  @override
  Future<Either<Failure, PaginableResult<Movie>>> getAll({
    int page = 1,
    int limit = 20,
    bool? winnersOnly,
    int? year,
  }) async {
    try {
      final response = await _httpClient.get(
        path: '',
        queryParams: {
          'page': page,
          'size': limit,
          if (winnersOnly != null && winnersOnly) 'winner': winnersOnly,
          if (year != null) 'year': year,
        },
      );

      final resultDto = PaginableResultDto<MovieDto>.fromJson(
        response.data,
        parseData: (data) => MovieDto.fromJson(data),
      );

      final resultEntity = resultDto.toEntity(
        parseDataToEntity: (data) => data.toEntity(),
      );

      return right(resultEntity);
    } catch (error) {
      return left(Failure(''));
    }
  }
}
