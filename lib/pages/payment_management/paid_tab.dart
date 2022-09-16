import 'package:flutter/material.dart';

/// Routes
import '../../routes/app_routes.dart';

/// Widgets
import 'payment_item_list.dart';

class PaidTab extends StatelessWidget {
  const PaidTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) => PaymentItemList(
        action: 'paid',
        onItemClick: () {
          Navigator.pushNamed(context, AppRoutes.paymentManagementDetail, arguments: 'paid');
        },
      ),
    );
  }
}
