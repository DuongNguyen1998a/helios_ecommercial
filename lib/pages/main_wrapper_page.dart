import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Base Widgets
import '../base_widgets/my_app_bar.dart';

import '../blocs/auth_bloc/auth_bloc.dart';

/// Menus
import '../menus/my_bottom_menu.dart';
import '../menus/my_drawer_menu.dart';

/// Routes
import '../routes/app_routes.dart';

import '../utils/constants.dart';
/// Functions
import '../utils/functions.dart';

/// Responsive
import '../utils/responsive.dart';

/// Pages
import 'home/home_page.dart';
import 'category/category_page.dart';
import 'cart/cart_page.dart';
import 'favorite/favorite_product_page.dart';

class MainWrapperPage extends StatefulWidget {
  const MainWrapperPage({Key? key}) : super(key: key);

  @override
  State<MainWrapperPage> createState() => _MainWrapperPageState();
}

class _MainWrapperPageState extends State<MainWrapperPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  double heightOfAppbar = AppBar().preferredSize.height;
  double heightOfAppbarTablet = AppBar().preferredSize.height * 1.45;

  int currentIndex = 0;
  Widget mWidget = const SizedBox();

  void setCurrentIndex(int index) {
    setState(() {
      currentIndex = index;
    });

    if (currentIndex == 2) {
      Functions.checkLoggedIn().then((value) {
        debugPrint(value.toString());
        if (value) {
          setState(() {
            mWidget = const FavoriteProductPage();
          });
        } else {
          Navigator.pushNamed(context, AppRoutes.auth);
        }
      });
    } else if (currentIndex == 3) {
      Functions.checkLoggedIn().then((value) {
        debugPrint(value.toString());
        if (value) {
          setState(() {
            mWidget = const CartPage();
          });
        } else {
          Navigator.pushNamed(context, AppRoutes.auth);
        }
      });
    }
  }

  Widget getPage() {
    if (currentIndex == 0) {
      return const HomePage();
    } else if (currentIndex == 1) {
      return const CategoryPage();
    } else if (currentIndex == 2) {
      return mWidget;
    } else if (currentIndex == 3) {
      return const CartPage();
    } else {
      return const Scaffold(
        body: Center(
          child: Text('Không tìm thấy trang bạn muốn'),
        ),
      );
    }
  }

  @override
  void initState() {
    doLoginIfHasData();
    super.initState();
  }

  Future<void> doLoginIfHasData() async {
    try {
      final sharedPrefs = await SharedPreferences.getInstance();
      String? username = sharedPrefs.getString(KeyUtils.userName);
      String? password = sharedPrefs.getString(KeyUtils.password);
      String? userInformation = sharedPrefs.getString(KeyUtils.userInformation);

      if (userInformation != null) {
        if (!mounted) return;
        doLogin(username!, password!);
      }
    } catch (e) {
      rethrow;
    }
  }

  void doLogin(String username, String password) {
    context.read<AuthBloc>().add(DoLogin(username: username, password: password),);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: MyAppBar(
        height: Responsive.isMobile(context)
            ? heightOfAppbar
            : heightOfAppbarTablet,
        title: 'Helios',
        leadingIcon: Icons.menu,
        leadingIconClick: () {
          _scaffoldKey.currentState!.openDrawer();
        },
        actionIcon: Icons.search,
        actionIconClick: () {},
      ),
      body: getPage(),
      bottomNavigationBar: MyBottomMenu(
        passIndex: setCurrentIndex,
      ),
      drawer: const MyDrawerMenu(),
    );
  }
}
