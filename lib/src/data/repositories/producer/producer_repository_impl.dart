import 'package:dartz/dartz.dart';
import 'package:outsera_challenge/src/data/dtos/min_max_interval_producers_dto.dart';
import 'package:outsera_challenge/src/entities/failure_entity.dart';
import 'package:outsera_challenge/src/entities/min_max_interval_producers_entity.dart';
import 'package:outsera_challenge/src/infra/http/http.dart';

import 'producer_repository.dart';

class ProducerRepositoryImpl implements ProducerRepository {
  late final HttpClient _httpClient;

  ProducerRepositoryImpl({required HttpClient httpClient}) {
    _httpClient = httpClient;
  }

  @override
  Future<Either<Failure, MinMaxIntervalProducers>> getMinMaxInterval() async {
    try {
      final response = await safeRequest(
        request: () => _httpClient.get(
          path: '',
          queryParams: {
            'projection': 'max-min-win-interval-for-producers',
          },
        ),
        parseData: (data) {
          return MinMaxIntervalProducersDto.fromJson(data);
        },
      );

      final result = response.toEntity();

      return right(result);
    } catch (error) {
      return left(Failure(''));
    }
  }
}
