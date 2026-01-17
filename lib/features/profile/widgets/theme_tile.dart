import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:northpoint_church_app/core/theme/theme_controller.dart';
import 'settings_tile.dart';

class ThemeTile extends ConsumerWidget {
  const ThemeTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeControllerProvider);
    final controller = ref.read(themeControllerProvider.notifier);

    const labels = ['Device', 'Light', 'Dark'];
    final modes = [AppThemeMode.system, AppThemeMode.light, AppThemeMode.dark];

    return SettingsTile(
      icon: Icons.color_lens,
      title: 'Theme',
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(labels.length, (index) {
          final isSelected = themeMode == modes[index];
          return GestureDetector(
            onTap: () => controller.setTheme(modes[index]),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
              decoration: BoxDecoration(
                color: isSelected
                    ? Theme.of(context).colorScheme.primary
                    : Colors.transparent,
                borderRadius: BorderRadius.horizontal(
                  left: index == 0 ? const Radius.circular(6) : Radius.zero,
                  right: index == modes.length - 1
                      ? const Radius.circular(6)
                      : Radius.zero,
                ),
                border: Border.all(
                  color: isSelected
                      ? Theme.of(context).colorScheme.primary
                      : Colors.grey.shade400,
                ),
              ),
              child: Text(
                labels[index],
                style: TextStyle(
                  color: isSelected
                      ? Colors.white
                      : Theme.of(context).textTheme.headlineLarge?.color,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          );
        }),
      ),
      onTap: () {}, // optional: tap on the tile itself does nothing
    );
  }
}
