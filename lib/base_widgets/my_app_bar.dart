import 'package:flutter/material.dart';

/// Colors
import '../colors/app_colors.dart';

/// Responsive
import '../utils/responsive.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final String title;
  final IconData leadingIcon;
  final Function leadingIconClick;
  final IconData? actionIcon;
  final Function? actionIconClick;

  const MyAppBar({
    Key? key,
    required this.height,
    required this.title,
    required this.leadingIcon,
    required this.leadingIconClick,
    this.actionIcon,
    this.actionIconClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: primaryColor,
      elevation: 0.0,
      title: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontFamily: 'BalooRegular',
          fontSize: Responsive.isMobile(context) ? 16 : 32,
        ),
      ),
      leading: IconButton(
        onPressed: () {
          leadingIconClick();
        },
        icon: Icon(
          leadingIcon,
          size: Responsive.isMobile(context) ? 24 : 24 * 1.5,
        ),
      ),
      actions: [
        actionIcon == null
            ? const SizedBox()
            : IconButton(
                onPressed: () {
                  actionIconClick!();
                },
                icon: Icon(
                  actionIcon,
                  size: Responsive.isMobile(context) ? 24 : 24 * 1.5,
                ),
              ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
