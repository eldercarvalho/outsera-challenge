import 'package:dartz/dartz.dart';
import 'package:outsera_challenge/src/data/dtos/studio_dto.dart';
import 'package:outsera_challenge/src/entities/failure_entity.dart';
import 'package:outsera_challenge/src/entities/studio_entity.dart';
import 'package:outsera_challenge/src/infra/http/http.dart';

import 'studio_repository.dart';

class StudioRepositoryImpl implements StudioRepository {
  late final HttpClient _httpClient;

  StudioRepositoryImpl({required HttpClient httpClient}) {
    _httpClient = httpClient;
  }

  @override
  Future<Either<Failure, List<Studio>>> getWithWins() async {
    try {
      final response = await safeRequest(
        request: () => _httpClient.get(
          path: '',
          queryParams: {
            'projection': 'studios-with-win-count',
          },
        ),
        dataKey: 'studios',
        parseDataList: (data) => StudioDto.fromJsonList(data),
      );

      final result = StudioDto.toEtitiesList(response);

      return right(result);
    } catch (error) {
      return left(Failure(''));
    }
  }
}
