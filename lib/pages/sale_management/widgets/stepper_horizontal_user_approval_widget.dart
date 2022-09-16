import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../../../blocs/user_approve_bloc/user_approve_bloc.dart';
import '../../../models/user_approve.dart';
import '../../../utils/responsive.dart';

class StepperHorizontalUserApprovalWidget extends StatefulWidget {
  final double heightOfStepper;

  const StepperHorizontalUserApprovalWidget({
    Key? key,
    required this.heightOfStepper,
  }) : super(key: key);

  @override
  State<StepperHorizontalUserApprovalWidget> createState() =>
      _StepperHorizontalUserApprovalWidgetState();
}

class _StepperHorizontalUserApprovalWidgetState
    extends State<StepperHorizontalUserApprovalWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserApproveBloc, UserApproveState>(
      builder: (context, state) {
        if (state is UserApproveLoading) {
          return Center(
            child: Stack(
              children: const [
                CircularProgressIndicator(),
              ],
            ),
          );
        } else if (state is UserApproveLoadedSuccess) {
          return SingleChildScrollView(
            padding: EdgeInsets.zero,
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                state.userApproves.length,
                (index) => GestureDetector(
                  onTap: () {},
                  child: StepperItemWidget(
                    isFirst: index == 0 ? true : false,
                    isLast:
                        index == state.userApproves.length - 1 ? true : false,
                    heightItem: widget.heightOfStepper,
                    heightSpacing: Responsive.isMobile(context) ? 5 : 5 * 1.5,
                    indicatorHeight: Responsive.isMobile(context) ? 20 : 20 * 1.5,
                    thickness: Responsive.isMobile(context) ? 4 : 4 * 1.5,
                    indicatorColor:
                        state.userApproves[index].strStatus != 'Chưa duyệt'
                            ? Colors.green
                            : Colors.orangeAccent,
                    item: state.userApproves[index],
                  ),
                ),
              ),
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}

class StepperItemWidget extends StatelessWidget {
  final bool isFirst;
  final bool isLast;
  final double heightItem;
  final double heightSpacing;
  final double indicatorHeight;
  final double thickness;
  final Color indicatorColor;
  final UserApprove item;

  const StepperItemWidget({
    Key? key,
    this.isLast = false,
    this.isFirst = false,
    required this.heightItem,
    required this.heightSpacing,
    required this.indicatorHeight,
    required this.thickness,
    this.indicatorColor = Colors.grey,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: heightItem),
      child: TimelineTile(
        axis: TimelineAxis.horizontal,
        alignment: TimelineAlign.manual,
        lineXY: 0.7,
        isFirst: isFirst,
        isLast: isLast,
        indicatorStyle: IndicatorStyle(
          width: indicatorHeight,
          height: indicatorHeight,
          color: indicatorColor,
          iconStyle: IconStyle(
            color: Colors.white,
            iconData: Icons.check,
            fontSize: 14,
          ),
          indicatorXY: 0.38,
          padding: const EdgeInsets.only(top: 8),
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
        startChild: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: indicatorColor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.positionName,
                style: const TextStyle(
                  fontSize: 14,
                  fontFamily: 'MyriadProRegular',
                  letterSpacing: 0.5,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: heightSpacing - 2,
              ),
              Text(
                item.customerName,
                style: const TextStyle(
                  fontSize: 14,
                  fontFamily: 'MyriadProRegular',
                  letterSpacing: 0.5,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: heightSpacing - 2,
              ),
              Text(
                'Trạng thái: ${item.strStatus}',
                style: const TextStyle(
                  fontSize: 14,
                  fontFamily: 'MyriadProRegular',
                  letterSpacing: 0.5,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
