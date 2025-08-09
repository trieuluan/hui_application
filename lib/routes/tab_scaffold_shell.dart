import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:hui_application/l10n/generated/app_localizations.dart';

class TabScaffoldShell extends StatefulWidget {
  final StatefulNavigationShell navigationShell;
  const TabScaffoldShell({super.key, required this.navigationShell});

  @override
  State<TabScaffoldShell> createState() => _TabScaffoldShellState();
}

class _TabScaffoldShellState extends State<TabScaffoldShell> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: widget.navigationShell),
        Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Theme.of(
                  context,
                ).colorScheme.shadow.withValues(alpha: 0.2),
                blurRadius: 8,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Theme.of(context).colorScheme.primary,
            unselectedItemColor: Theme.of(context).colorScheme.onSurfaceVariant,
            backgroundColor:
                Theme.of(context).colorScheme.surfaceContainerHighest,
            elevation: 0, // Set về 0 vì đã dùng Container shadow
            currentIndex: widget.navigationShell.currentIndex,
            items: [
              BottomNavigationBarItem(
                icon: const Icon(Icons.home_outlined),
                activeIcon: const Icon(Icons.home),
                label: S.of(context)!.home,
              ),
              BottomNavigationBarItem(
                icon: const Icon(FontAwesomeIcons.groupArrowsRotate),
                activeIcon: const Icon(FontAwesomeIcons.groupArrowsRotate),
                label: S.of(context)!.groups,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.explore_outlined),
                activeIcon: const Icon(Icons.explore),
                label: 'Khám phá',
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.person_outline),
                activeIcon: const Icon(Icons.person),
                label: S.of(context)!.account,
              ),
            ],
            onTap: (index) {
              widget.navigationShell.goBranch(index);
            },
          ),
        ),
      ],
    );
  }
}
