import 'package:flutter/material.dart';
/// Base Widgets
import '../../base_widgets/my_app_bar.dart';
/// Colors
import '../../colors/app_colors.dart';
/// Utils
import '../../utils/responsive.dart';
/// Widgets
import 'widgets/approval_tab.dart';
import 'widgets/pending_tab.dart';
import 'widgets/refuse_tab.dart';

class SaleManagementPage extends StatefulWidget {
  const SaleManagementPage({Key? key}) : super(key: key);

  @override
  State<SaleManagementPage> createState() => _SaleManagementPageState();
}

class _SaleManagementPageState extends State<SaleManagementPage> with TickerProviderStateMixin {

  late TabController _tabController;
  double heightOfAppbar = AppBar().preferredSize.height;
  double heightOfAppbarTablet = AppBar().preferredSize.height * 1.45;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    TextStyle labelStyle = TextStyle(
      fontFamily: 'MyriadProSemi',
      fontSize: Responsive.isMobile(context) ? 15 : 30,
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: Responsive.isMobile(context) ? 50 : 100,
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
                  text: 'Chờ duyệt',
                ),
                Tab(
                  text: 'Đã duyệt',
                ),
                Tab(
                  text: 'Từ chối',
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                PendingTab(),
                ApprovalTab(),
                RefuseTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
