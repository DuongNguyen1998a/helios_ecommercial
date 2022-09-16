import 'package:flutter/material.dart';

import '../../base_widgets/my_app_bar.dart';
import '../../utils/responsive.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

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
      backgroundColor: const Color(0xFFF2F2F2),
      appBar: MyAppBar(
        height: Responsive.isMobile(context)
            ? heightOfAppbar
            : heightOfAppbarTablet,
        title: 'About',
        leadingIcon: Icons.arrow_back,
        leadingIconClick: () {
          Navigator.pop(context);
        },
      ),
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        width: double.infinity,
        height: double.infinity,
        margin: EdgeInsets.symmetric(
          horizontal: Responsive.isMobile(context) ? 16 : 32,
          vertical: Responsive.isMobile(context) ? 10 : 20,
        ),
        padding: EdgeInsets.all(Responsive.isMobile(context) ? 10 : 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum tortor quam, feugiat vitae, ultricies eget, tempor sit amet, ante. Donec eu libero sit amet quam egestas semper. Aenean ultricies mi vitae est. Mauris placerat eleifend leo. Quisque sit amet est et sapien ullamcorper pharetra. Vestibulum erat wisi, condimentum sed, commodo vitae, ornare sit amet, wisi. Aenean fermentum, elit eget tincidunt condimentum, eros ipsum rutrum orci, sagittis tempus lacus enim ac dui. Donec non enim in turpis pulvinar facilisis. Ut felis. Praesent dapibus, neque id cursus faucibus, tortor neque egestas augue, eu vulputate magna eros eu erat. Aliquam erat volutpat. Nam dui mi, tincidunt quis, accumsan porttitor, facilisis luctus, metus',
                style: textStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
