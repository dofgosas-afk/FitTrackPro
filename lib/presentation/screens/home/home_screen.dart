import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_sizes.dart';
import '../../providers/health_provider.dart';
import '../../widgets/common/glass_card.dart';
import '../../widgets/common/metric_card.dart';
import '../../widgets/common/section_header.dart';
import '../../widgets/common/workout_tile.dart';
import '../../../app/routes.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final summary = ref.watch(dailySummaryProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          // Header
          SliverToBoxAdapter(
            child: _buildHeader(context, user.name),
          ),

          // Main metrics grid
          SliverToBoxAdapter(
            child: summary.when(
              loading: () => _buildLoadingGrid(),
              error: (e, _) => _buildErrorWidget(),
              data: (data) => _buildMetricsGrid(data),
            ),
          ),

          // Quick actions
          SliverToBoxAdapter(
            child: _buildQuickActions(context),
          ),

          // Recent workouts
          SliverToBoxAdapter(
            child: _buildRecentWorkouts(context, ref),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 32)),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, String name) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        AppSizes.paddingScreen,
        MediaQuery.of(context).padding.top + 24,
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
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${_getGreeting()}, $name! 👋',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Как ты сегодня?',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          // Notification & settings icons
          Row(
            children: [
              _HeaderIcon(
                icon: Icons.notifications_rounded,
                onTap: () {},
              ),
              const SizedBox(width: 8),
              _HeaderIcon(
                icon: Icons.settings_rounded,
                onTap: () => context.push(AppRoutes.settings),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricsGrid(data) {
    final stepsPercent = (data.steps / 10000).clamp(0.0, 1.0);
    final calPercent = (data.caloriesBurned / 500).clamp(0.0, 1.0);
    final waterPercent = (data.waterMl / 2000).clamp(0.0, 1.0);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingScreen),
      child: Column(
        children: [
          // Steps - large card
          GlassCard(
            child: _buildStepsCard(data.steps, stepsPercent),
          ),
          const SizedBox(height: 12),

          // Row of 3 small cards
          Row(
            children: [
              Expanded(
                child: MetricCard(
                  icon: Icons.local_fire_department_rounded,
                  label: AppStrings.calories,
                  value: '${data.caloriesBurned.toInt()}',
                  unit: AppStrings.kcal,
                  color: AppColors.caloriesColor,
                  progress: calPercent,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: MetricCard(
                  icon: Icons.favorite_rounded,
                  label: AppStrings.heartRate,
                  value: '${data.heartRateAvg}',
                  unit: AppStrings.bpm,
                  color: AppColors.heartRateColor,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: MetricCard(
                  icon: Icons.water_drop_rounded,
                  label: AppStrings.water,
                  value: '${data.waterMl.toInt()}',
                  unit: AppStrings.ml,
                  color: AppColors.waterColor,
                  progress: waterPercent,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Row of 2 more cards
          Row(
            children: [
              Expanded(
                child: MetricCard(
                  icon: Icons.nightlight_round,
                  label: AppStrings.sleep,
                  value: '${data.sleepHours}',
                  unit: AppStrings.hours,
                  color: AppColors.sleepColor,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: MetricCard(
                  icon: Icons.air_rounded,
                  label: AppStrings.oxygen,
                  value: '${data.oxygenSaturation.toInt()}',
                  unit: AppStrings.percent,
                  color: AppColors.oxygenColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStepsCard(int steps, double progress) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.stepsColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.directions_walk_rounded,
                  color: AppColors.stepsColor,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.steps,
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${steps.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]} ')}',
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4, left: 4),
                        child: Text(
                          '/ 10 000',
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Spacer(),
              SizedBox(
                width: 64,
                height: 64,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CircularProgressIndicator(
                      value: progress,
                      strokeWidth: 6,
                      backgroundColor: AppColors.stepsColor.withOpacity(0.15),
                      valueColor: const AlwaysStoppedAnimation<Color>(
                          AppColors.stepsColor),
                    ),
                    Text(
                      '${(progress * 100).toInt()}%',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 6,
              backgroundColor: AppColors.stepsColor.withOpacity(0.15),
              valueColor:
                  const AlwaysStoppedAnimation<Color>(AppColors.stepsColor),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSizes.paddingScreen, 24, AppSizes.paddingScreen, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(title: AppStrings.quickStart),
          const SizedBox(height: 12),
          SizedBox(
            height: 100,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _QuickActionChip(
                  emoji: '🏃',
                  label: 'Бег',
                  color: AppColors.primary,
                ),
                _QuickActionChip(
                  emoji: '🚴',
                  label: 'Велик',
                  color: AppColors.accent,
                ),
                _QuickActionChip(
                  emoji: '🏋️',
                  label: 'Зал',
                  color: AppColors.caloriesColor,
                ),
                _QuickActionChip(
                  emoji: '🧘',
                  label: 'Йога',
                  color: AppColors.sleepColor,
                ),
                _QuickActionChip(
                  emoji: '🏊',
                  label: 'Плавание',
                  color: AppColors.waterColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentWorkouts(BuildContext context, WidgetRef ref) {
    final workouts = ref.watch(workoutHistoryProvider);
    final recent = workouts.take(3).toList();

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSizes.paddingScreen, 24, AppSizes.paddingScreen, 0),
      child: Column(
        children: [
          SectionHeader(
            title: AppStrings.recentWorkouts,
            actionLabel: AppStrings.seeAll,
            onAction: () => context.go(AppRoutes.activity),
          ),
          const SizedBox(height: 12),
          ...recent.map((w) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: WorkoutTile(workout: w),
              )),
        ],
      ),
    );
  }

  Widget _buildLoadingGrid() {
    return const Padding(
      padding: EdgeInsets.all(AppSizes.paddingScreen),
      child: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
        ),
      ),
    );
  }

  Widget _buildErrorWidget() {
    return const Padding(
      padding: EdgeInsets.all(AppSizes.paddingScreen),
      child: Center(
        child: Text(
          'Не удалось загрузить данные',
          style: TextStyle(color: AppColors.textSecondary),
        ),
      ),
    );
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Доброе утро';
    if (hour < 17) return 'Добрый день';
    return 'Добрый вечер';
  }
}

class _HeaderIcon extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _HeaderIcon({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.glassBorder),
        ),
        child: Icon(icon, color: AppColors.textSecondary, size: 20),
      ),
    );
  }
}

class _QuickActionChip extends StatelessWidget {
  final String emoji;
  final String label;
  final Color color;

  const _QuickActionChip({
    required this.emoji,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 28)),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
