import 'package:equatable/equatable.dart';

class Year extends Equatable {
  const Year({
    required this.year,
    required this.winnersCount,
  });

  final int year;
  final int winnersCount;

  @override
  List<Object> get props => [winnersCount, year];
}
