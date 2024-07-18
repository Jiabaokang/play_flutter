import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 底部导航栏数据
class MenuData {
  final String label;
  final IconData icon;
  MenuData({required this.label, required this.icon});
}

/// 底部导航栏
class AppBottomBar extends StatelessWidget {
  final List<MenuData> menus;
  final int currentIndex;
  final ValueChanged<int> onItemTap;

  const AppBottomBar({
    Key? key,
    required this.menus,
    required this.currentIndex,
    required this.onItemTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: menus.map(_buildItemByMenuData).toList(),
      currentIndex: currentIndex,
      onTap: onItemTap,
      backgroundColor: Colors.white,
      elevation: 2.0,
      iconSize: 24.0,
      unselectedItemColor: Colors.blueGrey,
      selectedItemColor: Theme.of(context).primaryColor,
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
      showSelectedLabels: true,
      showUnselectedLabels: true,
    );
  }

  /// 构建底部导航栏的item
  BottomNavigationBarItem _buildItemByMenuData(MenuData menu) {
    return BottomNavigationBarItem(
      icon: Icon(menu.icon),
      label: menu.label,
    );
  }
}
