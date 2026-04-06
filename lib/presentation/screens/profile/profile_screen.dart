import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../providers/health_provider.dart';
import '../../widgets/common/glass_card.dart';
import '../../../app/routes.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          // Header with avatar
          SliverToBoxAdapter(
            child: _buildHeader(context, user),
          ),

          // Stats row
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingScreen),
              child: _buildStatsRow(user),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 20)),

          // Goals section
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingScreen),
              child: _buildGoals(user),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 20)),

          // Achievements
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingScreen),
              child: _buildAchievements(),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 20)),

          // Settings link
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingScreen),
              child: _buildMenuItems(context),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 48)),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, user) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        AppSizes.paddingScreen,
        MediaQuery.of(context).padding.top + 16,
        AppSizes.paddingScreen,
        24,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.surface, AppColors.background],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                AppStrings.myProfile,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.edit_rounded, color: AppColors.primary),
                onPressed: () {},
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Avatar
          Stack(
            children: [
              Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: AppColors.primaryGradient,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.4),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: const Center(
                  child: Text('👩', style: TextStyle(fontSize: 40)),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.background, width: 2),
                  ),
                  child: const Icon(Icons.camera_alt_rounded, color: Colors.white, size: 14),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            user.name,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          Text(
            '${user.age} лет · ${user.gender == 'female' ? 'Женщина' : 'Мужчина'}',
            style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsRow(user) {
    return GlassCard(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _ProfileStat('${user.weightKg.toInt()}', AppStrings.kg, AppStrings.weight),
            _StatDivider(),
            _ProfileStat('${user.heightCm.toInt()}', AppStrings.cm, AppStrings.height),
            _StatDivider(),
            _ProfileStat(user.bmi.toStringAsFixed(1), AppStrings.bmi, ''),
            _StatDivider(),
            _ProfileStat('${user.age}', AppStrings.age, ''),
          ],
        ),
      ),
    );
  }

  Widget _buildGoals(user) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          AppStrings.myGoals,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _GoalCard(
                icon: Icons.directions_walk_rounded,
                label: 'Шаги',
                value: '${user.dailyStepsGoal ~/ 1000}K',
                color: AppColors.primary,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _GoalCard(
                icon: Icons.local_fire_department_rounded,
                label: 'Калории',
                value: '${user.dailyCaloriesGoal.toInt()}',
                color: AppColors.caloriesColor,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _GoalCard(
                icon: Icons.water_drop_rounded,
                label: 'Вода',
                value: '${user.dailyWaterGoal.toInt()}мл',
                color: AppColors.waterColor,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAchievements() {
    final achievements = [
      _Achievement('🏅', 'Первая тренировка', true),
      _Achievement('🔥', '7 дней подряд', true),
      _Achievement('👟', '50 000 шагов', true),
      _Achievement('⚡', 'HIIT мастер', false),
      _Achievement('🏊', 'Пловец', false),
      _Achievement('🏔️', '100 км', false),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          AppStrings.achievements,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: achievements.map((a) {
            return Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: a.unlocked ? AppColors.cardBackground : AppColors.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: a.unlocked ? AppColors.primary.withOpacity(0.4) : AppColors.glassBorder,
                ),
              ),
              child: Column(
                children: [
                  Text(a.emoji, style: TextStyle(fontSize: 28, color: a.unlocked ? null : null),),
                  const SizedBox(height: 4),
                  Text(
                    a.name,
                    style: TextStyle(
                      fontSize: 10,
                      color: a.unlocked ? Colors.white : AppColors.textHint,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildMenuItems(BuildContext context) {
    return Column(
      children: [
        _MenuItem(
          icon: Icons.settings_rounded,
          label: AppStrings.settings,
          onTap: () => context.push(AppRoutes.settings),
        ),
        const SizedBox(height: 8),
        _MenuItem(
          icon: Icons.help_rounded,
          label: 'Помощь',
          onTap: () {},
        ),
        const SizedBox(height: 8),
        _MenuItem(
          icon: Icons.info_rounded,
          label: AppStrings.about,
          onTap: () {},
        ),
      ],
    );
  }
}

class _ProfileStat extends StatelessWidget {
  final String value;
  final String unit;
  final String label;

  const _ProfileStat(this.value, this.unit, this.label);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white)),
            Padding(
              padding: const EdgeInsets.only(bottom: 2, left: 2),
              child: Text(unit, style: TextStyle(fontSize: 12, color: AppColors.primary)),
            ),
          ],
        ),
        if (label.isNotEmpty)
          Text(label, style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
      ],
    );
  }
}

class _StatDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(height: 36, width: 1, color: AppColors.glassBorder);
  }
}

class _GoalCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _GoalCard({required this.icon, required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 22),
          const SizedBox(height: 6),
          Text(value, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: color)),
          Text(label, style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
        ],
      ),
    );
  }
}

class _Achievement {
  final String emoji;
  final String name;
  final bool unlocked;

  const _Achievement(this.emoji, this.name, this.unlocked);
}

class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _MenuItem({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.glassBorder),
        ),
        child: Row(
          children: [
            Icon(icon, color: AppColors.textSecondary, size: 20),
            const SizedBox(width: 14),
            Text(label, style: const TextStyle(fontSize: 15, color: Colors.white)),
            const Spacer(),
            Icon(Icons.chevron_right_rounded, color: AppColors.textSecondary, size: 20),
          ],
        ),
      ),
    );
  }
}
