import 'package:flutter/material.dart';

import '../../routes/app_routes.dart';
/// Widgets
import 'payment_item_list.dart';

class UnpaidTab extends StatelessWidget {
  const UnpaidTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) => PaymentItemList(
        action: 'unpaid',
        onItemClick: () {
          Navigator.pushNamed(context, AppRoutes.paymentManagementDetail, arguments: 'unpaid');
        },
      ),
    );
  }
}
