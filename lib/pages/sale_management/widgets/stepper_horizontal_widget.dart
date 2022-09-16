import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../../../utils/responsive.dart';

class StepperHorizontalWidget extends StatefulWidget {
  final double heightOfStepper;

  const StepperHorizontalWidget({
    Key? key,
    required this.heightOfStepper,
  }) : super(key: key);

  @override
  State<StepperHorizontalWidget> createState() =>
      _StepperHorizontalWidgetState();
}

class _StepperHorizontalWidgetState extends State<StepperHorizontalWidget> {
  List<Map<String, dynamic>> lstSteps = [
    {
      'title': 'Đặt hàng',
      'icon': Icons.message_outlined,
      'isCompleted': true,
    },
    {
      'title': 'Xác nhận',
      'icon': Icons.confirmation_num_outlined,
      'isCompleted': false,
    },
    {
      'title': 'Thanh toán',
      'icon': Icons.payment_outlined,
      'isCompleted': false,
    },
    {
      'title': 'Vận chuyển',
      'icon': Icons.fire_truck_outlined,
      'isCompleted': false,
    },
    {
      'title': 'Hoàn tất',
      'icon': Icons.check_outlined,
      'isCompleted': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.zero,
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          lstSteps.length,
          (index) => GestureDetector(
            onTap: () {
              setState(() {
                lstSteps[index]['isCompleted'] = true;
              });
            },
            child: StepperItemWidget(
              isFirst: index == 0 ? true : false,
              isLast: index == lstSteps.length - 1 ? true : false,
              heightSpacing: Responsive.isMobile(context) ? 5 : 5 * 1.5,
              indicatorHeight: Responsive.isMobile(context) ? 20 : 20 * 1.5,
              thickness: Responsive.isMobile(context) ? 4 : 4 * 1.5,
              icon: lstSteps[index]['icon'],
              title: lstSteps[index]['title'],
              indicatorColor:
                  lstSteps[index]['isCompleted'] ? Colors.green : Colors.grey,
              itemHeight: widget.heightOfStepper,
            ),
          ),
        ),
      ),
    );
  }
}

class StepperItemWidget extends StatelessWidget {
  final bool isFirst;
  final bool isLast;
  final double heightSpacing;
  final double indicatorHeight;
  final double thickness;
  final IconData icon;
  final String title;
  final Color indicatorColor;
  final double itemHeight;

  const StepperItemWidget({
    Key? key,
    this.isLast = false,
    this.isFirst = false,
    required this.heightSpacing,
    required this.indicatorHeight,
    required this.thickness,
    required this.icon,
    required this.title,
    this.indicatorColor = Colors.grey,
    required this.itemHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      constraints: BoxConstraints(maxHeight: itemHeight),
      child: TimelineTile(
        axis: TimelineAxis.horizontal,
        alignment: TimelineAlign.manual,
        lineXY: 0.7,
        isFirst: isFirst,
        isLast: isLast,
        indicatorStyle: IndicatorStyle(
          color: indicatorColor,
          iconStyle: IconStyle(
            color: Colors.white,
            iconData: Icons.check,
            fontSize: 14,
          ),
          padding: EdgeInsets.zero,
          indicatorXY: 0.5,
        ),
        beforeLineStyle: LineStyle(
          color: indicatorColor,
          thickness: thickness,
        ),
        afterLineStyle: LineStyle(
          color: indicatorColor,
          thickness: thickness,
        ),
        endChild: Container(
          constraints: const BoxConstraints(
            minWidth: 120,
          ),
        ),
        startChild: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, color: indicatorColor, size: 24 * 1.2,),
            const SizedBox(
              height: 5,
            ),
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontFamily: 'MyriadProRegular',
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
