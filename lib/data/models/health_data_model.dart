import 'package:equatable/equatable.dart';
import 'workout_model.dart';

class HealthDataModel extends Equatable {
  final String id;
  final String type;
  final double value;
  final String unit;
  final DateTime dateFrom;
  final DateTime dateTo;
  final String? sourceId;

  const HealthDataModel({
    required this.id,
    required this.type,
    required this.value,
    required this.unit,
    required this.dateFrom,
    required this.dateTo,
    this.sourceId,
  });

  @override
  List<Object?> get props => [id, type, value, unit, dateFrom, dateTo];
}

// Daily summary model
class DailySummary {
  final DateTime date;
  final int steps;
  final double caloriesBurned;
  final double caloriesConsumed;
  final double waterMl;
  final double sleepHours;
  final int heartRateAvg;
  final double oxygenSaturation;
  final double distanceKm;
  final List<WorkoutModel> workouts;

  const DailySummary({
    required this.date,
    this.steps = 0,
    this.caloriesBurned = 0,
    this.caloriesConsumed = 0,
    this.waterMl = 0,
    this.sleepHours = 0,
    this.heartRateAvg = 0,
    this.oxygenSaturation = 0,
    this.distanceKm = 0,
    this.workouts = const [],
  });

  factory DailySummary.empty(DateTime date) => DailySummary(date: date);
}

// Mock data for demo
class MockHealthData {
  static DailySummary getTodaySummary() {
    return DailySummary(
      date: DateTime.now(),
      steps: 7842,
      caloriesBurned: 485,
      caloriesConsumed: 1720,
      waterMl: 1500,
      sleepHours: 7.5,
      heartRateAvg: 72,
      oxygenSaturation: 98,
      distanceKm: 5.8,
      workouts: [
        WorkoutModel(
          id: '1',
          name: 'Утренний бег',
          type: WorkoutType.running,
          durationMinutes: 35,
          caloriesBurned: 280,
          distanceKm: 5.2,
          date: DateTime.now().subtract(const Duration(hours: 4)),
        ),
      ],
    );
  }

  static List<int> getWeeklySteps() {
    return [6200, 8100, 5400, 9300, 7842, 0, 0];
  }

  static List<double> getWeeklyCalories() {
    return [420, 530, 380, 610, 485, 0, 0];
  }
}
