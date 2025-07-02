import 'package:flutter/material.dart';

import '../../utils/consts/app_strings.dart';
import '../../utils/routes/route_names.dart';
import '../../utils/themes/theme.dart';

class BottomPaginationBar extends StatelessWidget {
  final String? selectedRoute;

  const BottomPaginationBar({super.key, this.selectedRoute});

  @override
  Widget build(BuildContext context) {
    final pages = [
      _PageItem(
          routeName: RouteNames.instance.characterList,
          icon: Icons.person_2_outlined,
          activeIcon: Icons.person_2_rounded,
          label: AppStrings.instance.characterList)
    ];

    final theme = Theme.of(context);
    final brightness = theme.brightness;

    final currentIndex =
        pages.indexWhere((page) => page.routeName == selectedRoute);

    const backgroundColor = AppTheme.background;

    return Container(
        decoration: BoxDecoration(
            color: backgroundColor,
            boxShadow: [
              BoxShadow(
                  blurRadius: 8,
                  color: Colors.black.withOpacity(0.05),
                  offset: const Offset(0, -2))
            ],
            border: Border(
                top: BorderSide(
                    color: brightness == Brightness.light
                        ? AppTheme.borderColor
                        : const Color(0xFF2D3748)))),
        child: BottomNavigationBar(
          currentIndex: currentIndex >= 0 ? currentIndex : 0,
          items: [
            BottomNavigationBarItem(
              icon: Icon(pages[currentIndex].icon),
              activeIcon: Icon(pages[currentIndex].activeIcon),
              label: pages[currentIndex].label,
            )
          ],
        ));
  }
}

class _PageItem {
  final String routeName;
  final IconData icon;
  final IconData activeIcon;
  final String label;

  const _PageItem(
      {required this.routeName,
      required this.icon,
      required this.activeIcon,
      required this.label});
}
