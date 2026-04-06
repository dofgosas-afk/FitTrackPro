import '../models/health_data_model.dart';

/// Health Service — интеграция с Google Fit / Apple HealthKit
/// На реальном устройстве использует пакет `health`
/// В режиме демо возвращает mock-данные
class HealthService {
  bool _hasPermissions = false;

  /// Запрос разрешений на доступ к данным здоровья
  Future<bool> requestPermissions() async {
    // TODO: На реальном Android/iOS устройстве:
    // final health = Health();
    // return await health.requestAuthorization([
    //   HealthDataType.STEPS,
    //   HealthDataType.HEART_RATE,
    //   HealthDataType.ACTIVE_ENERGY_BURNED,
    //   HealthDataType.BLOOD_OXYGEN,
    //   HealthDataType.SLEEP_ASLEEP,
    // ]);
    _hasPermissions = true;
    return true;
  }

  /// Получение количества шагов за сегодня
  Future<int> getTodaySteps() async {
    // TODO (реальное устройство):
    // final steps = await health.getTotalStepsInInterval(midnight, now);
    await Future.delayed(const Duration(milliseconds: 500));
    return _mockSteps();
  }

  /// Получение пульса
  Future<int> getHeartRate() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _mockHeartRate();
  }

  /// Получение сожжённых калорий
  Future<double> getActiveCalories() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _mockCalories();
  }

  /// Насыщение кислородом
  Future<double> getOxygenSaturation() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return 98.0;
  }

  /// Пройденное расстояние
  Future<double> getDistanceKm() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return 5.8;
  }

  /// Данные за неделю для графиков
  Future<List<int>> getWeeklySteps() async {
    await Future.delayed(const Duration(milliseconds: 600));
    return MockHealthData.getWeeklySteps();
  }

  // Mock данные для демо
  int _mockSteps() => 7842;
  int _mockHeartRate() => 72;
  double _mockCalories() => 485.0;
}
