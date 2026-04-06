import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../providers/health_provider.dart';
import '../../widgets/common/glass_card.dart';
import '../../widgets/common/section_header.dart';

class StatsScreen extends ConsumerStatefulWidget {
  const StatsScreen({super.key});

  @override
  ConsumerState<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends ConsumerState<StatsScreen> {
  int _selectedPeriod = 0;

  final List<String> _periods = [
    AppStrings.weekly,
    AppStrings.monthly,
    AppStrings.yearly,
  ];

  final List<String> _days = ['Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб', 'Вс'];

  @override
  Widget build(BuildContext context) {
    final weeklySteps = ref.watch(weeklyStepsProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: const Text(AppStrings.statistics),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSizes.paddingScreen),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Period selector
            _buildPeriodSelector(),
            const SizedBox(height: 20),

            // Steps chart
            const SectionHeader(title: AppStrings.stepsChart),
            const SizedBox(height: 12),
            weeklySteps.when(
              loading: () => const SizedBox(height: 200, child: Center(child: CircularProgressIndicator(color: AppColors.primary))),
              error: (_, __) => const SizedBox.shrink(),
              data: (steps) => _buildStepsChart(steps),
            ),
            const SizedBox(height: 20),

            // Calories chart
            const SectionHeader(title: 'График калорий'),
            const SizedBox(height: 12),
            _buildCaloriesChart(),
            const SizedBox(height: 20),

            // Personal records
            const SectionHeader(title: AppStrings.personalRecords),
            const SizedBox(height: 12),
            _buildPersonalRecords(),
            const SizedBox(height: 20),

            // Weekly summary
            const SectionHeader(title: 'Итоги недели'),
            const SizedBox(height: 12),
            _buildWeeklySummary(),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildPeriodSelector() {
    return Row(
      children: List.generate(_periods.length, (index) {
        final isSelected = _selectedPeriod == index;
        return GestureDetector(
          onTap: () => setState(() => _selectedPeriod = index),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            margin: const EdgeInsets.only(right: 8),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.primary : AppColors.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected ? AppColors.primary : AppColors.glassBorder,
              ),
            ),
            child: Text(
              _periods[index],
              style: TextStyle(
                color: isSelected ? Colors.white : AppColors.textSecondary,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                fontSize: 14,
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildStepsChart(List<int> steps) {
    final maxStep = steps.reduce((a, b) => a > b ? a : b).toDouble();

    return GlassCard(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(
              height: 180,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: maxStep == 0 ? 10000 : maxStep * 1.2,
                  barTouchData: BarTouchData(
                    touchTooltipData: BarTouchTooltipData(
                      tooltipRoundedRadius: 8,
                      getTooltipItem: (group, groupIndex, rod, rodIndex) {
                        return BarTooltipItem(
                          '${steps[groupIndex]}',
                          const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                        );
                      },
                    ),
                  ),
                  titlesData: FlTitlesData(
                    leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              _days[value.toInt()],
                              style: TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 12,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  gridData: FlGridData(
                    drawHorizontalLine: true,
                    drawVerticalLine: false,
                    horizontalInterval: 2500,
                    getDrawingHorizontalLine: (value) => FlLine(
                      color: AppColors.glassBorder,
                      strokeWidth: 1,
                      dashArray: [4, 4],
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  barGroups: List.generate(steps.length, (i) {
                    final isToday = i == 4;
                    return BarChartGroupData(
                      x: i,
                      barRods: [
                        BarChartRodData(
                          toY: steps[i].toDouble(),
                          width: 16,
                          borderRadius: BorderRadius.circular(6),
                          color: isToday ? AppColors.primary : AppColors.stepsColor.withOpacity(0.4),
                          backDrawRodData: BackgroundBarChartRodData(
                            show: true,
                            toY: maxStep == 0 ? 10000 : maxStep * 1.2,
                            color: AppColors.stepsColor.withOpacity(0.05),
                          ),
                        ),
                      ],
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCaloriesChart() {
    final data = [420.0, 530, 380, 610, 485, 0, 0];
    final spots = List.generate(data.length,
        (i) => FlSpot(i.toDouble(), data[i].toDouble()));

    return GlassCard(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: SizedBox(
          height: 160,
          child: LineChart(
            LineChartData(
              lineTouchData: LineTouchData(
                touchTooltipData: LineTouchTooltipData(
                  tooltipRoundedRadius: 8,
                  getTooltipItems: (touchedSpots) => touchedSpots.map((spot) {
                    return LineTooltipItem(
                      '${spot.y.toInt()} ккал',
                      const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                    );
                  }).toList(),
                ),
              ),
              gridData: FlGridData(
                drawVerticalLine: false,
                horizontalInterval: 200,
                getDrawingHorizontalLine: (value) => FlLine(
                  color: AppColors.glassBorder,
                  strokeWidth: 1,
                  dashArray: [4, 4],
                ),
              ),
              titlesData: FlTitlesData(
                leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, _) => Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(_days[value.toInt()],
                          style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                    ),
                  ),
                ),
              ),
              borderData: FlBorderData(show: false),
              lineBarsData: [
                LineChartBarData(
                  spots: spots,
                  isCurved: true,
                  color: AppColors.caloriesColor,
                  barWidth: 3,
                  isStrokeCapRound: true,
                  dotData: FlDotData(
                    show: true,
                    getDotPainter: (spot, _, __, ___) => FlDotCirclePainter(
                      radius: 4,
                      color: AppColors.caloriesColor,
                      strokeWidth: 2,
                      strokeColor: AppColors.background,
                    ),
                  ),
                  belowBarData: BarAreaData(
                    show: true,
                    gradient: LinearGradient(
                      colors: [
                        AppColors.caloriesColor.withOpacity(0.3),
                        AppColors.caloriesColor.withOpacity(0),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPersonalRecords() {
    final records = [
      _Record('Максимум шагов', '12 456', '🏃', AppColors.primary),
      _Record('Лучшее расстояние', '15.3 км', '📍', AppColors.success),
      _Record('Макс. калорий', '780 ккал', '🔥', AppColors.caloriesColor),
      _Record('Самая длинная тренировка', '85 мин', '⏱️', AppColors.sleepColor),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.6,
      ),
      itemCount: records.length,
      itemBuilder: (context, index) {
        final r = records[index];
        return GlassCard(
          borderColor: r.color.withOpacity(0.3),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(r.emoji, style: const TextStyle(fontSize: 22)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(r.value,
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: r.color)),
                    Text(r.label,
                        style: TextStyle(fontSize: 11, color: AppColors.textSecondary),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildWeeklySummary() {
    return GlassCard(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _SummaryItem('45 236', 'Шагов', AppColors.primary),
            _Divider(),
            _SummaryItem('2 295', 'Ккал', AppColors.caloriesColor),
            _Divider(),
            _SummaryItem('29.2', 'Км', AppColors.success),
            _Divider(),
            _SummaryItem('3', 'Тренировки', AppColors.sleepColor),
          ],
        ),
      ),
    );
  }
}

class _Record {
  final String label;
  final String value;
  final String emoji;
  final Color color;

  const _Record(this.label, this.value, this.emoji, this.color);
}

class _SummaryItem extends StatelessWidget {
  final String value;
  final String label;
  final Color color;

  const _SummaryItem(this.value, this.label, this.color);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: color)),
        Text(label, style: TextStyle(fontSize: 11, color: AppColors.textSecondary)),
      ],
    );
  }
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(height: 40, width: 1, color: AppColors.glassBorder);
  }
}
