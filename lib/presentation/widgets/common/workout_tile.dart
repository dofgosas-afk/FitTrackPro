import 'package:flutter/material.dart';
import '../../../data/models/workout_model.dart';
import '../../../core/constants/app_colors.dart';
import 'glass_card.dart';

class WorkoutTile extends StatelessWidget {
  final WorkoutModel workout;

  const WorkoutTile({super.key, required this.workout});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Emoji + color indicator
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: _getWorkoutColor(workout.type).withOpacity(0.15),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: _getWorkoutColor(workout.type).withOpacity(0.3),
                ),
              ),
              child: Center(
                child: Text(
                  workout.type.emoji,
                  style: const TextStyle(fontSize: 22),
                ),
              ),
            ),
            const SizedBox(width: 14),

            // Name and stats
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    workout.name,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      _Stat(
                        icon: Icons.timer_rounded,
                        value: '${workout.durationMinutes} мин',
                      ),
                      if (workout.distanceKm > 0) ...[
                        const SizedBox(width: 12),
                        _Stat(
                          icon: Icons.straighten_rounded,
                          value: '${workout.distanceKm} км',
                        ),
                      ],
                      const SizedBox(width: 12),
                      _Stat(
                        icon: Icons.local_fire_department_rounded,
                        value: '${workout.caloriesBurned.toInt()} ккал',
                        color: AppColors.caloriesColor,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Date
            Text(
              _formatDate(workout.date),
              style: TextStyle(
                fontSize: 12,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getWorkoutColor(WorkoutType type) {
    switch (type) {
      case WorkoutType.running:
        return AppColors.primary;
      case WorkoutType.cycling:
        return AppColors.success;
      case WorkoutType.swimming:
        return AppColors.waterColor;
      case WorkoutType.gym:
        return AppColors.caloriesColor;
      case WorkoutType.yoga:
        return AppColors.sleepColor;
      case WorkoutType.walking:
        return AppColors.oxygenColor;
      default:
        return AppColors.accent;
    }
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);
    if (diff.inHours < 24) return 'Сегодня';
    if (diff.inDays == 1) return 'Вчера';
    return '${date.day}.${date.month.toString().padLeft(2, '0')}';
  }
}

class _Stat extends StatelessWidget {
  final IconData icon;
  final String value;
  final Color? color;

  const _Stat({required this.icon, required this.value, this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 13, color: color ?? AppColors.textSecondary),
        const SizedBox(width: 3),
        Text(
          value,
          style: TextStyle(
            fontSize: 12,
            color: color ?? AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}
