import 'package:dartz/dartz.dart';
import 'package:outsera_challenge/src/entities/failure_entity.dart';
import 'package:outsera_challenge/src/entities/min_max_interval_producers_entity.dart';

abstract class ProducerRepository {
  Future<Either<Failure, MinMaxIntervalProducers>> getMinMaxInterval();
}
