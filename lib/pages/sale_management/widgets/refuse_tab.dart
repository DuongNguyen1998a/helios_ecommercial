import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/sale_bloc/sale_bloc.dart';
import '../../../models/sale.dart';
import '../../../routes/app_routes.dart';
import 'list_item.dart';

class RefuseTab extends StatelessWidget {
  const RefuseTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SaleBloc, SaleState>(builder: (context, state) {
      if (state is SaleLoading) {
        return const Center(child: CircularProgressIndicator());
      } else if (state is SaleLoadedSuccess) {
        List<Sale> sales = <Sale>[];
        if (state.sales.isNotEmpty) {
          sales = state.sales.where((element) => element.status == 2).toList();
        }
        return RefreshIndicator(
          onRefresh: () async {
            context.read<SaleBloc>().add(const FetchSales());
          },
          child: ListView.builder(
            itemCount: sales.length,
            itemBuilder: (context, index) => ListItem(
              sale: sales[index],
              action: 'refused',
              onItemClick: () {
                Navigator.pushNamed(
                  context,
                  AppRoutes.saleManagementDetail,
                  arguments: sales[index],
                );
              },
            ),
          ),
        );
      } else {
        return const SizedBox();
      }
    });
  }
}
