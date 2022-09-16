import 'package:flutter/material.dart';
import '../../base_widgets/my_app_bar.dart';

/// Colors
import '../../colors/app_colors.dart';

/// Responsive
import '../../utils/responsive.dart';

/// Widgets
import 'paid_tab.dart';
import 'unpaid_tab.dart';

class PaymentManagementPage extends StatefulWidget {
  const PaymentManagementPage({
    Key? key,
  }) : super(key: key);

  @override
  State<PaymentManagementPage> createState() => _PaymentManagementPageState();
}

class _PaymentManagementPageState extends State<PaymentManagementPage>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle labelStyle = TextStyle(
      fontFamily: 'MyriadProSemi',
      fontSize: Responsive.isMobile(context) ? 15 : 30,
    );

    double heightOfAppbar = AppBar().preferredSize.height;
    double heightOfAppbarTablet = AppBar().preferredSize.height * 1.45;

    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      appBar: MyAppBar(
        height: Responsive.isMobile(context)
            ? heightOfAppbar
            : heightOfAppbarTablet,
        title: 'Quản Lý Thanh Toán',
        leadingIcon: Icons.arrow_back,
        leadingIconClick: () {
          Navigator.pop(context);
        },
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: Responsive.isMobile(context) ? 50 : 80,
            color: const Color(0xFFF2F2F2),
            child: TabBar(
              indicatorColor: primaryColor,
              unselectedLabelColor: const Color(0xFF999999),
              labelColor: primaryColor,
              controller: _tabController,
              labelStyle: labelStyle,
              unselectedLabelStyle: labelStyle,
              tabs: const [
                Tab(
                  text: 'Đã thanh toán',
                ),
                Tab(
                  text: 'Chưa thanh toán',
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                PaidTab(),
                UnpaidTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
