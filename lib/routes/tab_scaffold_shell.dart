import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

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
        CupertinoTabBar(
          activeColor: CupertinoColors.activeBlue,
          inactiveColor: CupertinoColors.inactiveGray,
          backgroundColor: CupertinoColors.white,
          currentIndex: widget.navigationShell.currentIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.house_alt_fill),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.groupArrowsRotate),
              label: 'Groups',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.person_fill),
              label: 'Account',
            ),
          ],
          onTap: (index) {
            widget.navigationShell.goBranch(index);
          },
        ),
      ],
    );
  }
}
