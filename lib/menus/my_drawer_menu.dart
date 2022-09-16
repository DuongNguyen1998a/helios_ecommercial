import 'package:flutter/material.dart';
import 'package:helios_ecommercial/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Colors
import '../colors/app_colors.dart';
/// Routes
import '../routes/app_routes.dart';
/// Functions
import '../utils/functions.dart';
/// Responsive
import '../utils/responsive.dart';

class MyDrawerMenu extends StatefulWidget {
  const MyDrawerMenu({Key? key}) : super(key: key);

  @override
  State<MyDrawerMenu> createState() => _MyDrawerMenuState();
}

class _MyDrawerMenuState extends State<MyDrawerMenu> {

  bool isLoggedIn = false;


  @override
  void initState() {
    Functions.checkLoggedIn().then((value) {
      if (value) {
        setState(() {
          isLoggedIn = true;
        });
      }
      else {
        setState(() {
          isLoggedIn = false;
        });
      }
    });
    super.initState();
  }

  void logOut() {
    Navigator.pop(context);
    Navigator.pushReplacementNamed(context, AppRoutes.mainWrapper);
  }

  Future<void> loginOrLogout() async {
    if (isLoggedIn) {
      final preferences = await SharedPreferences.getInstance();
      await preferences.remove(KeyUtils.userInformation);
      logOut();
    }
    else {
      Navigator.pop(context);
      Navigator.pushNamed(context, AppRoutes.auth);
    }
  }

  @override
  Widget build(BuildContext context) {
    double widthOfDrawer = MediaQuery.of(context).size.width / 1.2;
    double widthOfDrawerTablet = MediaQuery.of(context).size.width / 2;

    TextStyle textStyleMenuItem = TextStyle(
      color: Colors.white,
      fontFamily: 'MyriadProRegular',
      fontSize: Responsive.isMobile(context) ? 16 : 16 * 1.5,
    );

    return SizedBox(
      width: Responsive.isMobile(context) ? widthOfDrawer : widthOfDrawerTablet,
      child: Drawer(
        backgroundColor: primaryColor,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeaderContent(),
            DrawerHeaderButton(
              isLoggedIn: isLoggedIn,
              loginOrLogout: () {
                loginOrLogout();
              },
            ),
            const Divider(
              color: Colors.white,
            ),
            MenuItem(
              title: 'Thông Tin Cá Nhân',
              textStyle: textStyleMenuItem,
              menuItemClick: () {},
            ),
            const Divider(
              color: Colors.white,
            ),
            DropdownMenuItem(
              title: 'Quản Lý',
              textStyle: textStyleMenuItem,
            ),
            const Divider(
              color: Colors.white,
            ),
            MenuItem(
              title: 'Lịch Sử Giao Dịch',
              textStyle: textStyleMenuItem,
              menuItemClick: () {},
            ),
            const Divider(
              color: Colors.white,
            ),
            MenuItem(
              title: 'Liên Hệ',
              textStyle: textStyleMenuItem,
              menuItemClick: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, AppRoutes.contact);
              },
            ),
            const Divider(
              color: Colors.white,
            ),
            MenuItem(
              title: 'Cài Đặt',
              textStyle: textStyleMenuItem,
              menuItemClick: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, AppRoutes.setting);
              },
            ),
            const Divider(
              color: Colors.white,
            ),
            MenuItem(
              title: 'Trợ Giúp',
              textStyle: textStyleMenuItem,
              menuItemClick: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, AppRoutes.help);
              },
            ),
            const Divider(
              color: Colors.white,
            ),
            MenuItem(
              title: 'About',
              textStyle: textStyleMenuItem,
              menuItemClick: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, AppRoutes.about);
              },
            ),
            const Divider(
              color: Colors.white,
            ),
            const DrawerFooterContent(),
          ],
        ),
      ),
    );
  }
}

class DrawerHeaderContent extends StatelessWidget {
  const DrawerHeaderContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(
      fontSize: Responsive.isMobile(context) ? 24 : 48,
      fontFamily: 'MyriadPro',
      color: Colors.white,
    );

    TextStyle textStyle1 = TextStyle(
      color: primaryColor,
      fontFamily: 'MyriadPro',
      fontSize: Responsive.isMobile(context) ? 20 : 40,
    );

    const decoration = BoxDecoration(
      shape: BoxShape.circle,
      color: primaryColor,
    );

    return SizedBox(
      height: Responsive.isMobile(context) ? 150 : 300,
      child: DrawerHeader(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              padding: EdgeInsets.all(Responsive.isMobile(context) ? 16 : 32),
              decoration: decoration,
              child: Text(
                'Hs.',
                style: textStyle,
              ),
            ),
            Text(
              'Chào mừng\nbạn tới Helios !',
              textAlign: TextAlign.center,
              style: textStyle1,
            ),
          ],
        ),
      ),
    );
  }
}

class DrawerHeaderButton extends StatelessWidget {
  final bool isLoggedIn;
  final Function loginOrLogout;

  const DrawerHeaderButton({
    Key? key,
    required this.isLoggedIn,
    required this.loginOrLogout,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    EdgeInsets marginContainer = EdgeInsets.only(
      left: Responsive.isMobile(context) ? 10 : 10 * 1.2,
      top: Responsive.isMobile(context) ? 14 : 14 * 1.2,
      bottom: Responsive.isMobile(context) ? 14 : 14 * 1.2,
    );

    ButtonStyle btnElevatedButton = ElevatedButton.styleFrom(
      side: const BorderSide(color: Colors.white, width: 1.5),
      primary: primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(Responsive.isMobile(context) ? 25 : 50),
      ),
    );

    TextStyle textStyleButton = TextStyle(
      fontSize: Responsive.isMobile(context) ? 17 : 17 * 1.5,
      fontFamily: 'MyriadProRegular',
    );

    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Container(
            height: Responsive.isMobile(context) ? 45 : 80,
            margin: marginContainer,
            child: ElevatedButton(
              style: btnElevatedButton,
              onPressed: () {
                loginOrLogout();
              },
              child: Text(
                isLoggedIn ? 'Đăng Xuất' : 'Đăng Nhập',
                style: textStyleButton,
              ),
            ),
          ),
        ),
        const Expanded(flex: 1, child: SizedBox()),
      ],
    );
  }
}

class MenuItem extends StatelessWidget {
  final String title;
  final Function menuItemClick;
  final TextStyle textStyle;

  const MenuItem({
    Key? key,
    required this.title,
    required this.menuItemClick,
    required this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(
        vertical: Responsive.isMobile(context) ? -10 : 14,
        horizontal: Responsive.isMobile(context) ? 14 : 20,
      ),
      visualDensity: const VisualDensity(
        horizontal: 0,
        vertical: -4,
      ),
      title: Text(
        title,
        style: textStyle,
      ),
      onTap: () {
        menuItemClick();
      },
    );
  }
}

class MenuItem1 extends StatelessWidget {
  final String title;
  final Function menuItemClick;
  final TextStyle textStyle;

  const MenuItem1({
    Key? key,
    required this.title,
    required this.menuItemClick,
    required this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(
        vertical: Responsive.isMobile(context) ? -10 : 14,
        horizontal: Responsive.isMobile(context) ? 14 : 20,
      ),
      visualDensity: const VisualDensity(
        horizontal: 0,
        vertical: -2,
      ),
      title: Text(
        title,
        style: textStyle,
      ),
      onTap: () {
        menuItemClick();
      },
    );
  }
}

class DropdownMenuItem extends StatelessWidget {
  final String title;
  final TextStyle textStyle;

  const DropdownMenuItem({
    Key? key,
    required this.title,
    required this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> menuItems = [
      'Quản Lý Hợp Đồng',
      'Quản Lý Bán Hàng',
      'Quản Lý Thanh Toán',
      'Kho Hàng - Giao Hàng',
    ];

    return ListTileTheme(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 0,
        vertical: -4,
      ),
      dense: true,
      horizontalTitleGap: 0.0,
      minLeadingWidth: 0,
      child: ExpansionTile(
        tilePadding: EdgeInsets.symmetric(
          vertical: Responsive.isMobile(context) ? 0 : 14,
          horizontal: Responsive.isMobile(context) ? 14 : 20,
        ),
        backgroundColor: const Color(0xFFF1B254),
        collapsedBackgroundColor: primaryColor,
        iconColor: Colors.white,
        collapsedIconColor: Colors.white,
        title: Text(
          title,
          style: textStyle,
        ),
        children: List.generate(
          menuItems.length,
          (index) => MenuItem1(
            title: menuItems[index],
            menuItemClick: () {
              Functions.checkLoggedIn().then((value) {
                if (value) {
                  Navigator.pop(context);
                  if (index == 0) {
                    Navigator.pushNamed(context, AppRoutes.contractManagement);
                  }
                  else if (index == 1) {
                    Navigator.pushNamed(context, AppRoutes.saleManagement);
                  }
                  else if (index == 2) {
                    Navigator.pushNamed(context, AppRoutes.paymentManagement);
                  }
                }
                else {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, AppRoutes.auth);
                }
              });
            },
            textStyle: textStyle,
          ),
        ),
      ),
    );
  }
}

class DrawerFooterContent extends StatelessWidget {
  const DrawerFooterContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(
              top: Responsive.isMobile(context) ? 16 : 32,
              bottom: Responsive.isMobile(context) ? 16 : 32),
          padding: EdgeInsets.all(Responsive.isMobile(context) ? 16 : 32),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: primaryColor,
            border: Border.all(
              color: Colors.white,
            ),
          ),
          child: Center(
            child: Text(
              'Hs.',
              style: TextStyle(
                fontSize: Responsive.isMobile(context) ? 24 : 24 * 1.5,
                fontFamily: 'MyriadPro',
                color: Colors.white,
              ),
            ),
          ),
        ),
        Text(
          'CÔNG TY CỔ PHẦN\nCÔNG NGHỆ HELIOS',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'MyriadPro',
            fontSize: Responsive.isMobile(context) ? 20 : 20 * 1.5,
            color: Colors.white,
          ),
        ),
        SizedBox(
          height: Responsive.isMobile(context) ? 20 : 40,
        ),
        Text(
          'Email: contact@heliostech.vn',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'MyriadProRegular',
            fontSize: Responsive.isMobile(context) ? 14 : 14 * 1.5,
            color: Colors.white,
          ),
        ),
        Text(
          'Hotline: 1900 1020',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'MyriadProRegular',
            fontSize: Responsive.isMobile(context) ? 14 : 14 * 1.5,
            color: Colors.white,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'Địa chỉ: Đường số 58, Thạnh Mỹ Lợi,\nTP Thủ Đức, TP Hồ Chí Minh',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'MyriadProRegular',
              fontSize: Responsive.isMobile(context) ? 14 : 14 * 1.5,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(
          height: Responsive.isMobile(context) ? 20 : 40,
        ),
      ],
    );
  }
}
