import 'package:dartz/dartz.dart';
import 'package:outsera_challenge/src/data/dtos/year_dto.dart';
import 'package:outsera_challenge/src/entities/failure_entity.dart';
import 'package:outsera_challenge/src/entities/year_entity.dart';
import 'package:outsera_challenge/src/infra/http/http_client.dart';
import 'package:outsera_challenge/src/infra/http/safe_request.dart';

import 'year_repository.dart';

class YearRepositoryImpl implements YearRepository {
  late final HttpClient _httpClient;

  YearRepositoryImpl({required HttpClient httpClient}) {
    _httpClient = httpClient;
  }

  @override
  Future<Either<Failure, List<Year>>> getWithMoreThanOneWinner() async {
    try {
      final response = await safeRequest(
        request: () => _httpClient.get(
          path: '',
          queryParams: {
            'projection': 'years-with-multiple-winners',
          },
        ),
        dataKey: 'years',
        parseDataList: (data) {
          return data.map((e) => YearDto.fromJson(e)).toList();
        },
      );

      final result = YearDto.toEntityList(response);

      return right(result);
    } catch (error) {
      return left(Failure(''));
    }
  }
}
