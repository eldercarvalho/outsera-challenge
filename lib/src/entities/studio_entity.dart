import 'package:equatable/equatable.dart';

class Studio extends Equatable {
  final String name;
  final int winCount;

  const Studio({
    required this.name,
    required this.winCount,
  });

  @override
  List<Object?> get props => [name, winCount];
}
