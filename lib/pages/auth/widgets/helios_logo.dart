import 'package:flutter/material.dart';

/// Colors
import '../../../colors/app_colors.dart';

/// Responsive
import '../../../utils/responsive.dart';

class HeliosLogo extends StatelessWidget {
  const HeliosLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: Responsive.isMobile(context) ? 30 : 90,
        bottom: Responsive.isMobile(context) ? 35 : 70,
      ),
      padding: EdgeInsets.all(Responsive.isMobile(context) ? 20 : 40),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: primaryColor,
      ),
      child: Center(
        child: Text(
          'Hs.',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: 'MyriadPro',
            fontSize: Responsive.isMobile(context) ? 51 : 51 * 1.5,
          ),
        ),
      ),
    );
  }
}
