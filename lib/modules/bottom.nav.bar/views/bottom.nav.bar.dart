import 'package:bots/modules/days/views/days.page.dart';
import 'package:bots/modules/tasks/view/tasks.page.dart';
import 'package:bots/utils/app.image.dart';
import 'package:bots/utils/constants/string.constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class BottomNavBar extends StatelessWidget {
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      screens: [
        TasksPage(),
        DaysPage(),
      ],
      items: [
        PersistentBottomNavBarItem(
          icon: AppImage.task,
          title: StringConstant.tasks,
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(CupertinoIcons.calendar),
          title: StringConstant.days,
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
      ],
      decoration: const NavBarDecoration(
        colorBehindNavBar: Colors.white,
      ),
      itemAnimationProperties: const ItemAnimationProperties(
        duration: Duration(milliseconds: 350),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        animateTabTransition: true,
        duration: Duration(milliseconds: 350),
      ),
    );
  }
}
