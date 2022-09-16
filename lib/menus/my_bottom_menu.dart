import 'package:flutter/material.dart';

import '../colors/app_colors.dart';
import '../utils/responsive.dart';

class MyBottomMenu extends StatefulWidget {
  final Function passIndex;

  const MyBottomMenu({
    Key? key,
    required this.passIndex,
  }) : super(key: key);

  @override
  State<MyBottomMenu> createState() => _MyBottomMenuState();
}

class _MyBottomMenuState extends State<MyBottomMenu> {
  int currentIndex = 0;

  List<Map<String, dynamic>> listBottomMenu = [
    {
      'icon': Icons.home,
      'label': 'Trang chủ',
    },
    {
      'icon': Icons.category,
      'label': 'Danh mục',
    },
    {
      'icon': Icons.favorite,
      'label': 'Yêu thích',
    },
    {
      'icon': Icons.shopping_cart,
      'label': 'Giỏ hàng',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedLabelStyle: const TextStyle(fontFamily: 'MyriadProRegular'),
      unselectedLabelStyle: const TextStyle(fontFamily: 'MyriadProRegular'),
      selectedFontSize: Responsive.isMobile(context) ? 14 : 14 * 1.5,
      unselectedFontSize: Responsive.isMobile(context) ? 12 : 12 * 1.5,
      type: BottomNavigationBarType.fixed,
      backgroundColor: primaryColor,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.black,
      currentIndex: currentIndex,
      onTap: (index) {
        setState(() {
          currentIndex = index;
        });
        widget.passIndex(index);
      },
      items: listBottomMenu
          .map(
            (e) => BottomNavigationBarItem(
              icon: Icon(
                e['icon'],
                size: Responsive.isMobile(context) ? 24 : 24 * 1.5,
              ),
              label: e['label'],
            ),
          )
          .toList(),
    );
  }
}
