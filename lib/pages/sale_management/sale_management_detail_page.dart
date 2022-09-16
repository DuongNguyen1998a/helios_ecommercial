import 'package:flutter/material.dart';

/// Base Widgets
import '../../base_widgets/my_app_bar.dart';

/// Models
import '../../models/sale.dart';

/// Responsive
import '../../utils/responsive.dart';

/// Widgets
import 'widgets/stepper_horizontal_widget.dart';
import 'widgets/sale_management_detail_header_widget.dart';
import 'widgets/stepper_horizontal_user_approval_widget.dart';

class SaleManagementDetailPage extends StatelessWidget {
  final Sale sale;

  const SaleManagementDetailPage({
    Key? key,
    required this.sale,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double heightOfAppbar = AppBar().preferredSize.height;
    double heightOfAppbarTablet = AppBar().preferredSize.height * 1.45;

    TextStyle btnTextStyle = TextStyle(
      fontSize: Responsive.isMobile(context) ? 13 : 14 * 1.5,
      fontFamily: 'MyriadProRegular',
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      appBar: MyAppBar(
        height: Responsive.isMobile(context)
            ? heightOfAppbar
            : heightOfAppbarTablet,
        title: 'Quản Lý Bán Hàng',
        leadingIcon: Icons.arrow_back,
        leadingIconClick: () {
          Navigator.pop(context);
        },
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          vertical: Responsive.isMobile(context) ? 10 : 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const StepperHorizontalWidget(
              heightOfStepper: 100,
            ),
            const SizedBox(
              height: 10,
            ),
            const StepperHorizontalUserApprovalWidget(
              heightOfStepper: 145,
            ),
            SaleManagementDetailHeaderWidget(
              sale: sale,
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    margin: EdgeInsets.only(
                        left: Responsive.isMobile(context) ? 10 : 10 * 1.5),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                      ),
                      onPressed: () {},
                      child: Text(
                        'Duyệt đơn',
                        style: btnTextStyle,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: Responsive.isMobile(context) ? 10 : 20,
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                      ),
                      onPressed: () {},
                      child: Text(
                        'Hủy bỏ',
                        style: btnTextStyle,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    margin: EdgeInsets.only(
                        right: Responsive.isMobile(context) ? 10 : 10 * 1.5),
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        'Tạo lại',
                        style: btnTextStyle,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(
                horizontal: Responsive.isMobile(context) ? 10 : 10 * 1.5,
              ),
              child: ElevatedButton(
                onPressed: () {},
                child: Text(
                  'Chuyển tiếp',
                  style: btnTextStyle,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(
                horizontal: Responsive.isMobile(context) ? 10 : 10 * 1.5,
              ),
              child: ElevatedButton(
                onPressed: () {},
                child: Text(
                  'Quay lại',
                  style: btnTextStyle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
