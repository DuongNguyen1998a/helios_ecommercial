import 'package:flutter/material.dart';
import 'package:helios_ecommercial/colors/app_colors.dart';

import '../../base_widgets/my_app_bar.dart';
import '../../utils/responsive.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  double heightOfAppbar = AppBar().preferredSize.height;
  double heightOfAppbarTablet = AppBar().preferredSize.height * 1.45;

  bool currentValue = false;


  @override
  Widget build(BuildContext context) {

    TextStyle textStyle = TextStyle(
      fontFamily: 'MyriadProRegular',
      fontWeight: FontWeight.bold,
      fontSize: Responsive.isMobile(context) ? 14 : 14 * 1.5,
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      appBar: MyAppBar(
        height: Responsive.isMobile(context)
            ? heightOfAppbar
            : heightOfAppbarTablet,
        title: 'Cài Đặt',
        leadingIcon: Icons.arrow_back,
        leadingIconClick: () {
          Navigator.pop(context);
        },
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: Responsive.isMobile(context) ? 16 : 32,
              vertical: Responsive.isMobile(context) ? 8 : 16,
            ),
            padding: EdgeInsets.all(Responsive.isMobile(context) ? 10 : 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Thiết lập thông báo',
                  style: textStyle,
                ),
                Switch(
                  value: currentValue,
                  onChanged: (val) {
                    setState(() {
                      currentValue = val;
                    });
                  },
                  activeColor: primaryColor,
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: Responsive.isMobile(context) ? 16 : 32,
              vertical: Responsive.isMobile(context) ? 8 : 16,
            ),
            padding: EdgeInsets.all(Responsive.isMobile(context) ? 10 : 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Thông tin phiên bản',
                  style: textStyle,
                ),
                Text(
                  '1.0.0',
                  style: textStyle,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
