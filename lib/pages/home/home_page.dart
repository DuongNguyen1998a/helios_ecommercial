import 'package:flutter/material.dart';

/// Responsive
import '../../utils/responsive.dart';

/// Widgets
import '../home/widgets/home_product_grid.dart';
import '../home/widgets/slider_image_banner.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF2F2F2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SliderImageBanner(),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(
                left: Responsive.isMobile(context) ? 16 : 32,
                right: Responsive.isMobile(context) ? 16 : 32,
                bottom: Responsive.isMobile(context) ? 16 : 32,
              ),
              child: const HomeProductGrid(),
            ),
          ),
        ],
      ),
    );
  }
}
