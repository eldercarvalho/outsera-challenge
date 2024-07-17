import 'package:dartz/dartz.dart';
import 'package:outsera_challenge/src/entities/failure_entity.dart';
import 'package:outsera_challenge/src/entities/studio_entity.dart';

abstract class StudioRepository {
  Future<Either<Failure, List<Studio>>> getWithWins();
}
