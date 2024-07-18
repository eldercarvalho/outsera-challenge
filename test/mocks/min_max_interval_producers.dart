import 'package:outsera_challenge/src/entities/min_max_interval_producers_entity.dart';
import 'package:outsera_challenge/src/entities/producer_entity.dart';

const minMaxIntervalProducers = MinMaxIntervalProducers(
  min: [
    Producer(
      name: 'Joel Silver',
      intervalBetweenWins: 1,
      previousWinYear: 1990,
      followingWinYear: 1991,
    ),
  ],
  max: [
    Producer(
      name: 'Matthew Vaughn',
      intervalBetweenWins: 13,
      previousWinYear: 2002,
      followingWinYear: 2015,
    ),
  ],
);
