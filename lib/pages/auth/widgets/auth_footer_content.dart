import 'package:flutter/material.dart';

/// Colors
import '../../../colors/app_colors.dart';
/// Responsive
import '../../../utils/responsive.dart';

class AuthFooterContent extends StatelessWidget {
  const AuthFooterContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () {},
          child: Text(
            'Quên mật khẩu?',
            style: TextStyle(
              fontSize: Responsive.isMobile(context) ? 15 : 32,
              color: Colors.white,
              fontFamily: 'MyriadProRegular',
            ),
          ),
        ),
        Text(
          'Hoặc',
          style: TextStyle(
            fontSize: Responsive.isMobile(context) ? 15 : 32,
            color: Colors.white,
            fontFamily: 'MyriadProRegular',
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Bạn chưa có tài khoản?',
              style: TextStyle(
                fontSize: Responsive.isMobile(context) ? 15 : 32,
                color: Colors.white,
                fontFamily: 'MyriadProRegular',
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'Mở tài khoản',
                style: TextStyle(
                  fontSize: Responsive.isMobile(context) ? 15 : 32,
                  color: primaryColor,
                  fontFamily: 'MyriadProRegular',
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
