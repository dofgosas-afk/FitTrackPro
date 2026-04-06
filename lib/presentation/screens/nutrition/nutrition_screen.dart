import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../providers/health_provider.dart';
import '../../widgets/common/glass_card.dart';
import '../../widgets/common/section_header.dart';

class NutritionScreen extends ConsumerStatefulWidget {
  const NutritionScreen({super.key});

  @override
  ConsumerState<NutritionScreen> createState() => _NutritionScreenState();
}

class _NutritionScreenState extends ConsumerState<NutritionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: AppColors.background,
            floating: true,
            title: const Text(AppStrings.todayNutrition),
            actions: [
              IconButton(
                icon: const Icon(Icons.add_circle_rounded, color: AppColors.primary),
                onPressed: _showAddMeal,
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(AppSizes.paddingScreen),
              child: Column(
                children: [
                  _buildCaloriesSummary(),
                  const SizedBox(height: 20),
                  _buildMacros(),
                  const SizedBox(height: 24),
                  const SectionHeader(title: 'Приёмы пищи'),
                  const SizedBox(height: 12),
                  _buildMealCard(AppStrings.breakfast, '🥣', 420, [
                    _MealItem('Овсяная каша', 350),
                    _MealItem('Яблоко', 70),
                  ]),
                  const SizedBox(height: 12),
                  _buildMealCard(AppStrings.lunch, '🍽️', 680, [
                    _MealItem('Куриная грудка', 280),
                    _MealItem('Гречка', 250),
                    _MealItem('Салат', 150),
                  ]),
                  const SizedBox(height: 12),
                  _buildMealCard(AppStrings.dinner, '🥗', 520, [
                    _MealItem('Рыба', 300),
                    _MealItem('Овощи на пару', 120),
                    _MealItem('Йогурт', 100),
                  ]),
                  const SizedBox(height: 12),
                  _buildMealCard(AppStrings.snack, '🍎', 100, [
                    _MealItem('Банан', 100),
                  ]),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCaloriesSummary() {
    const goal = 1800;
    const consumed = 1720;
    const burned = 485;
    const remaining = goal - consumed + burned;

    return GlassCard(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              'Калории',
              style: TextStyle(
                fontSize: 16,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _CalorieBlock(
                  label: AppStrings.caloriesGoal,
                  value: '$goal',
                  color: AppColors.primary,
                ),
                // Big center circle
                SizedBox(
                  width: 120,
                  height: 120,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CircularProgressIndicator(
                        value: (consumed / goal).clamp(0, 1),
                        strokeWidth: 8,
                        backgroundColor: AppColors.caloriesColor.withOpacity(0.15),
                        valueColor: const AlwaysStoppedAnimation<Color>(
                            AppColors.caloriesColor),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            '$consumed',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'ккал',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                _CalorieBlock(
                  label: AppStrings.caloriesLeft,
                  value: '$remaining',
                  color: AppColors.success,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMacros() {
    return GlassCard(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: _MacroBar(
                label: AppStrings.protein,
                current: 95,
                goal: 120,
                color: AppColors.heartRateColor,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _MacroBar(
                label: AppStrings.carbs,
                current: 180,
                goal: 220,
                color: AppColors.caloriesColor,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _MacroBar(
                label: AppStrings.fat,
                current: 48,
                goal: 65,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMealCard(
      String title, String emoji, int calories, List<_MealItem> items) {
    return GlassCard(
      child: ExpansionTile(
        leading: Text(emoji, style: const TextStyle(fontSize: 24)),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        trailing: Text(
          '$calories ккал',
          style: TextStyle(
            fontSize: 13,
            color: AppColors.caloriesColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        iconColor: AppColors.textSecondary,
        collapsedIconColor: AppColors.textSecondary,
        children: [
          ...items.map((item) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(item.name,
                        style:
                            TextStyle(color: AppColors.textSecondary)),
                    Text('${item.calories} ккал',
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w500)),
                  ],
                ),
              )),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  void _showAddMeal() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Добавить приём пищи',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white),
            ),
            const SizedBox(height: 24),
            TextField(
              decoration: InputDecoration(
                hintText: 'Введите продукт...',
                hintStyle: TextStyle(color: AppColors.textSecondary),
                prefixIcon: const Icon(Icons.search_rounded, color: AppColors.primary),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class _CalorieBlock extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _CalorieBlock({required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: color)),
        Text(label, style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
      ],
    );
  }
}

class _MacroBar extends StatelessWidget {
  final String label;
  final int current;
  final int goal;
  final Color color;

  const _MacroBar({required this.label, required this.current, required this.goal, required this.color});

  @override
  Widget build(BuildContext context) {
    final progress = (current / goal).clamp(0.0, 1.0);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: TextStyle(fontSize: 13, color: AppColors.textSecondary)),
            Text('${current}г', style: TextStyle(fontSize: 13, color: color, fontWeight: FontWeight.w600)),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 6,
            backgroundColor: color.withOpacity(0.15),
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ),
        const SizedBox(height: 2),
        Text('/ ${goal}г', style: TextStyle(fontSize: 11, color: AppColors.textHint)),
      ],
    );
  }
}

class _MealItem {
  final String name;
  final int calories;

  const _MealItem(this.name, this.calories);
}
