import 'package:dartz/dartz.dart';
import 'package:outsera_challenge/src/entities/failure_entity.dart';
import 'package:outsera_challenge/src/entities/year_entity.dart';

abstract class YearRepository {
  Future<Either<Failure, List<Year>>> getWithMoreThanOneWinner();
}
