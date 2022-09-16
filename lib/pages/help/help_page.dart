import 'package:flutter/material.dart';

import '../../base_widgets/my_app_bar.dart';
import '../../utils/responsive.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double heightOfAppbar = AppBar().preferredSize.height;
    double heightOfAppbarTablet = AppBar().preferredSize.height * 1.45;

    TextStyle textStyle = TextStyle(
      fontFamily: 'MyriadProRegular',
      fontWeight: FontWeight.bold,
      fontSize: Responsive.isMobile(context) ? 14 : 14 * 1.5,
    );

    return Scaffold(
      appBar: MyAppBar(
        height: Responsive.isMobile(context)
            ? heightOfAppbar
            : heightOfAppbarTablet,
        title: 'Trợ Giúp',
        leadingIcon: Icons.arrow_back,
        leadingIconClick: () {
          Navigator.pop(context);
        },
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
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
            child: Text(
              'Tạo tài khoản và cách truy cập',
              style: textStyle,
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
            child: Text(
              'Các câu hõi thường gặp',
              style: textStyle,
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
            child: Text(
              'Chính sách Helios',
              style: textStyle,
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
            child: Text(
              'Hướng dẩn chung',
              style: textStyle,
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
            child: Text(
              'Thư viện thông tin',
              style: textStyle,
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
            child: Text(
              'Trả hàng và hoàn tiền',
              style: textStyle,
            ),
          ),
        ],
      ),
    );
  }
}
