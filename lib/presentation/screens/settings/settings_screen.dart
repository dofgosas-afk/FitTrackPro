import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../widgets/common/glass_card.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notifications = true;
  bool _healthConnected = false;
  bool _darkMode = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: const Text(AppStrings.settings),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSizes.paddingScreen),
        children: [
          // Health Connection
          _SettingsSection(
            title: 'Здоровье',
            children: [
              _buildHealthCard(),
            ],
          ),
          const SizedBox(height: 20),

          // Notifications
          _SettingsSection(
            title: AppStrings.notifications,
            children: [
              _ToggleTile(
                icon: Icons.notifications_rounded,
                iconColor: AppColors.primary,
                label: 'Напоминания',
                subtitle: 'Напоминания о тренировках и воде',
                value: _notifications,
                onChanged: (v) => setState(() => _notifications = v),
              ),
              _ToggleTile(
                icon: Icons.alarm_rounded,
                iconColor: AppColors.caloriesColor,
                label: 'Дневные цели',
                subtitle: 'Уведомления о прогрессе целей',
                value: true,
                onChanged: (_) {},
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Appearance
          _SettingsSection(
            title: 'Внешний вид',
            children: [
              _ToggleTile(
                icon: Icons.dark_mode_rounded,
                iconColor: AppColors.sleepColor,
                label: 'Тёмная тема',
                subtitle: 'Рекомендуется для экономии батареи',
                value: _darkMode,
                onChanged: (v) => setState(() => _darkMode = v),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Units
          _SettingsSection(
            title: AppStrings.units,
            children: [
              _SelectTile(
                icon: Icons.straighten_rounded,
                iconColor: AppColors.success,
                label: 'Дистанция',
                value: 'Километры (км)',
              ),
              _SelectTile(
                icon: Icons.monitor_weight_rounded,
                iconColor: AppColors.accent,
                label: 'Вес',
                value: 'Килограммы (кг)',
              ),
            ],
          ),
          const SizedBox(height: 20),

          // About
          _SettingsSection(
            title: AppStrings.about,
            children: [
              _InfoTile(label: 'Версия', value: '1.0.0'),
              _InfoTile(label: 'Разработчик', value: 'FitTrack Team'),
              _ActionTile(
                icon: Icons.star_rounded,
                iconColor: AppColors.caloriesColor,
                label: 'Оценить приложение',
                onTap: () {},
              ),
              _ActionTile(
                icon: Icons.privacy_tip_rounded,
                iconColor: AppColors.textSecondary,
                label: 'Политика конфиденциальности',
                onTap: () {},
              ),
            ],
          ),

          const SizedBox(height: 48),
        ],
      ),
    );
  }

  Widget _buildHealthCard() {
    return GlassCard(
      borderColor: _healthConnected
          ? AppColors.success.withOpacity(0.4)
          : AppColors.glassBorder,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.heartRateColor.withOpacity(0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.favorite_rounded, color: AppColors.heartRateColor, size: 22),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Google Fit / Apple Health',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.white),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    _healthConnected ? '✅ Подключено' : 'Не подключено',
                    style: TextStyle(
                      fontSize: 13,
                      color: _healthConnected ? AppColors.success : AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () => setState(() => _healthConnected = !_healthConnected),
              style: ElevatedButton.styleFrom(
                backgroundColor: _healthConnected
                    ? AppColors.surface
                    : AppColors.primary,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                minimumSize: Size.zero,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              child: Text(
                _healthConnected ? AppStrings.disconnect : AppStrings.connect,
                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SettingsSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _SettingsSection({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 10),
          child: Text(
            title.toUpperCase(),
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: AppColors.textSecondary,
              letterSpacing: 1.2,
            ),
          ),
        ),
        GlassCard(
          child: Column(
            children: List.generate(children.length * 2 - 1, (i) {
              if (i.isOdd) {
                return Divider(
                  height: 1,
                  color: AppColors.glassBorder,
                  indent: 56,
                );
              }
              return children[i ~/ 2];
            }),
          ),
        ),
      ],
    );
  }
}

class _ToggleTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _ToggleTile({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: iconColor.withOpacity(0.15),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: iconColor, size: 18),
      ),
      title: Text(label, style: const TextStyle(fontSize: 15, color: Colors.white)),
      subtitle: Text(subtitle, style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: AppColors.primary,
        activeTrackColor: AppColors.primary.withOpacity(0.3),
      ),
    );
  }
}

class _SelectTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final String value;

  const _SelectTile({required this.icon, required this.iconColor, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: iconColor.withOpacity(0.15),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: iconColor, size: 18),
      ),
      title: Text(label, style: const TextStyle(fontSize: 15, color: Colors.white)),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(value, style: TextStyle(fontSize: 13, color: AppColors.textSecondary)),
          const SizedBox(width: 4),
          Icon(Icons.chevron_right_rounded, color: AppColors.textSecondary, size: 18),
        ],
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final String label;
  final String value;

  const _InfoTile({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(label, style: const TextStyle(fontSize: 15, color: Colors.white)),
      trailing: Text(value, style: TextStyle(fontSize: 13, color: AppColors.textSecondary)),
    );
  }
}

class _ActionTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final VoidCallback onTap;

  const _ActionTile({required this.icon, required this.iconColor, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: iconColor.withOpacity(0.15),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: iconColor, size: 18),
      ),
      title: Text(label, style: const TextStyle(fontSize: 15, color: Colors.white)),
      trailing: Icon(Icons.chevron_right_rounded, color: AppColors.textSecondary, size: 18),
    );
  }
}
