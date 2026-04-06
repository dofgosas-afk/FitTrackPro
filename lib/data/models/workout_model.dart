import 'package:equatable/equatable.dart';

enum WorkoutType {
  running,
  cycling,
  swimming,
  gym,
  yoga,
  walking,
  hiit,
  other,
}

extension WorkoutTypeExtension on WorkoutType {
  String get name {
    switch (this) {
      case WorkoutType.running:
        return 'Бег';
      case WorkoutType.cycling:
        return 'Велосипед';
      case WorkoutType.swimming:
        return 'Плавание';
      case WorkoutType.gym:
        return 'Тренажёрный зал';
      case WorkoutType.yoga:
        return 'Йога';
      case WorkoutType.walking:
        return 'Ходьба';
      case WorkoutType.hiit:
        return 'HIIT';
      case WorkoutType.other:
        return 'Другое';
    }
  }

  String get emoji {
    switch (this) {
      case WorkoutType.running:
        return '🏃';
      case WorkoutType.cycling:
        return '🚴';
      case WorkoutType.swimming:
        return '🏊';
      case WorkoutType.gym:
        return '🏋️';
      case WorkoutType.yoga:
        return '🧘';
      case WorkoutType.walking:
        return '🚶';
      case WorkoutType.hiit:
        return '⚡';
      case WorkoutType.other:
        return '💪';
    }
  }
}

class WorkoutModel extends Equatable {
  final String id;
  final String name;
  final WorkoutType type;
  final int durationMinutes;
  final double caloriesBurned;
  final double distanceKm;
  final DateTime date;
  final int? avgHeartRate;
  final String? notes;

  const WorkoutModel({
    required this.id,
    required this.name,
    required this.type,
    required this.durationMinutes,
    required this.caloriesBurned,
    required this.distanceKm,
    required this.date,
    this.avgHeartRate,
    this.notes,
  });

  @override
  List<Object?> get props => [id, name, type, date];
}
