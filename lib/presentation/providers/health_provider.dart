import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/health_data_model.dart';
import '../../data/models/user_model.dart';
import '../../data/models/workout_model.dart';
import '../../data/services/health_service.dart';

// Health Service provider
final healthServiceProvider = Provider<HealthService>((ref) => HealthService());

// User provider
final userProvider = StateProvider<UserModel>((ref) => UserModel.demo());

// Daily summary provider
final dailySummaryProvider = FutureProvider<DailySummary>((ref) async {
  final healthService = ref.watch(healthServiceProvider);
  
  final steps = await healthService.getTodaySteps();
  final heartRate = await healthService.getHeartRate();
  final calories = await healthService.getActiveCalories();
  final oxygen = await healthService.getOxygenSaturation();
  final distance = await healthService.getDistanceKm();
  
  return DailySummary(
    date: DateTime.now(),
    steps: steps,
    heartRateAvg: heartRate,
    caloriesBurned: calories,
    oxygenSaturation: oxygen,
    distanceKm: distance,
    waterMl: 1500,
    sleepHours: 7.5,
    caloriesConsumed: 1720,
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
});

// Weekly steps provider
final weeklyStepsProvider = FutureProvider<List<int>>((ref) async {
  final healthService = ref.watch(healthServiceProvider);
  return healthService.getWeeklySteps();
});

// Workout history provider
final workoutHistoryProvider = StateProvider<List<WorkoutModel>>((ref) {
  return [
    WorkoutModel(
      id: '1',
      name: 'Утренний бег',
      type: WorkoutType.running,
      durationMinutes: 35,
      caloriesBurned: 280,
      distanceKm: 5.2,
      date: DateTime.now().subtract(const Duration(hours: 4)),
      avgHeartRate: 145,
    ),
    WorkoutModel(
      id: '2',
      name: 'Велотренировка',
      type: WorkoutType.cycling,
      durationMinutes: 50,
      caloriesBurned: 380,
      distanceKm: 18.5,
      date: DateTime.now().subtract(const Duration(days: 1)),
      avgHeartRate: 135,
    ),
    WorkoutModel(
      id: '3',
      name: 'Йога',
      type: WorkoutType.yoga,
      durationMinutes: 45,
      caloriesBurned: 150,
      distanceKm: 0,
      date: DateTime.now().subtract(const Duration(days: 2)),
    ),
    WorkoutModel(
      id: '4',
      name: 'Тренажёрный зал',
      type: WorkoutType.gym,
      durationMinutes: 60,
      caloriesBurned: 420,
      distanceKm: 0,
      date: DateTime.now().subtract(const Duration(days: 3)),
      avgHeartRate: 128,
    ),
  ];
});

// Water intake provider
final waterIntakeProvider = StateProvider<double>((ref) => 1500.0);

// Selected tab index
final selectedTabProvider = StateProvider<int>((ref) => 0);
