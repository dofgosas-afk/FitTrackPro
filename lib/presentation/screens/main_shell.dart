import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/health_provider.dart';
import '../../app/routes.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';

class MainShell extends ConsumerWidget {
  final Widget child;

  const MainShell({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(selectedTabProvider);

    return Scaffold(
      body: child,
      bottomNavigationBar: _buildBottomNav(context, ref, selectedIndex),
    );
  }

  Widget _buildBottomNav(BuildContext context, WidgetRef ref, int selectedIndex) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavItem(
                icon: Icons.home_rounded,
                label: AppStrings.navHome,
                isSelected: selectedIndex == 0,
                onTap: () {
                  ref.read(selectedTabProvider.notifier).state = 0;
                  context.go(AppRoutes.home);
                },
              ),
              _NavItem(
                icon: Icons.fitness_center_rounded,
                label: AppStrings.navActivity,
                isSelected: selectedIndex == 1,
                onTap: () {
                  ref.read(selectedTabProvider.notifier).state = 1;
                  context.go(AppRoutes.activity);
                },
              ),
              _NavItem(
                icon: Icons.restaurant_rounded,
                label: AppStrings.navNutrition,
                isSelected: selectedIndex == 2,
                onTap: () {
                  ref.read(selectedTabProvider.notifier).state = 2;
                  context.go(AppRoutes.nutrition);
                },
              ),
              _NavItem(
                icon: Icons.bar_chart_rounded,
                label: AppStrings.navStats,
                isSelected: selectedIndex == 3,
                onTap: () {
                  ref.read(selectedTabProvider.notifier).state = 3;
                  context.go(AppRoutes.stats);
                },
              ),
              _NavItem(
                icon: Icons.person_rounded,
                label: AppStrings.navProfile,
                isSelected: selectedIndex == 4,
                onTap: () {
                  ref.read(selectedTabProvider.notifier).state = 4;
                  context.go(AppRoutes.profile);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        padding: EdgeInsets.symmetric(
          horizontal: isSelected ? 16 : 12,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary.withOpacity(0.15) : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 22,
              color: isSelected ? AppColors.primary : AppColors.textSecondary,
            ),
            if (isSelected) ...[
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
