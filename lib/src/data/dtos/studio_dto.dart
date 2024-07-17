import 'package:equatable/equatable.dart';
import 'package:outsera_challenge/src/entities/studio_entity.dart';

class StudioDto extends Equatable {
  final String name;
  final int winCount;

  const StudioDto({
    required this.name,
    required this.winCount,
  });

  factory StudioDto.fromJson(Map<String, dynamic> json) {
    return StudioDto(
      name: json['name'],
      winCount: json['winCount'],
    );
  }

  static List<StudioDto> fromJsonList(List<Map<String, dynamic>> json) {
    return json.map((studio) => StudioDto.fromJson(studio)).toList();
  }

  static List<Studio> toEtitiesList(List<StudioDto> studios) {
    return studios.map((studio) => studio.toEntity()).toList();
  }

  Studio toEntity() {
    return Studio(
      name: name,
      winCount: winCount,
    );
  }

  @override
  List<Object?> get props => [name, winCount];
}
