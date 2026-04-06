import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String id;
  final String name;
  final String? photoUrl;
  final double weightKg;
  final double heightCm;
  final int age;
  final String gender;
  final int dailyStepsGoal;
  final double dailyCaloriesGoal;
  final double dailyWaterGoal;
  final double targetWeightKg;

  const UserModel({
    required this.id,
    required this.name,
    this.photoUrl,
    this.weightKg = 70,
    this.heightCm = 170,
    this.age = 25,
    this.gender = 'male',
    this.dailyStepsGoal = 10000,
    this.dailyCaloriesGoal = 2000,
    this.dailyWaterGoal = 2000,
    this.targetWeightKg = 65,
  });

  double get bmi => weightKg / ((heightCm / 100) * (heightCm / 100));

  String get bmiCategory {
    if (bmi < 18.5) return 'Недостаточный вес';
    if (bmi < 25) return 'Норма';
    if (bmi < 30) return 'Избыточный вес';
    return 'Ожирение';
  }

  UserModel copyWith({
    String? name,
    String? photoUrl,
    double? weightKg,
    double? heightCm,
    int? age,
    String? gender,
    int? dailyStepsGoal,
    double? dailyCaloriesGoal,
    double? dailyWaterGoal,
    double? targetWeightKg,
  }) {
    return UserModel(
      id: id,
      name: name ?? this.name,
      photoUrl: photoUrl ?? this.photoUrl,
      weightKg: weightKg ?? this.weightKg,
      heightCm: heightCm ?? this.heightCm,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      dailyStepsGoal: dailyStepsGoal ?? this.dailyStepsGoal,
      dailyCaloriesGoal: dailyCaloriesGoal ?? this.dailyCaloriesGoal,
      dailyWaterGoal: dailyWaterGoal ?? this.dailyWaterGoal,
      targetWeightKg: targetWeightKg ?? this.targetWeightKg,
    );
  }

  factory UserModel.demo() {
    return const UserModel(
      id: 'demo_user',
      name: 'Камилла',
      weightKg: 62,
      heightCm: 168,
      age: 23,
      gender: 'female',
      dailyStepsGoal: 10000,
      dailyCaloriesGoal: 1800,
      dailyWaterGoal: 2000,
      targetWeightKg: 58,
    );
  }

  @override
  List<Object?> get props => [id, name, weightKg, heightCm, age];
}
