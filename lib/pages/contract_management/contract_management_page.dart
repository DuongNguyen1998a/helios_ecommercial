import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../base_widgets/my_app_bar.dart';
import '../../blocs/contract_bloc/contract_bloc.dart';
import '../../utils/responsive.dart';
import 'widgets/contract_list.dart';

class ContractManagementPage extends StatelessWidget {
  const ContractManagementPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double heightOfAppbar = AppBar().preferredSize.height;
    double heightOfAppbarTablet = AppBar().preferredSize.height * 1.45;

    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      appBar: MyAppBar(
        height: Responsive.isMobile(context)
            ? heightOfAppbar
            : heightOfAppbarTablet,
        title: 'Quản Lý Hợp Đồng',
        leadingIcon: Icons.arrow_back,
        leadingIconClick: () {
          Navigator.pop(context);
        },
      ),
      body: BlocBuilder<ContractBloc, ContractState>(builder: (context, state) {
        if (state is ContractLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is ContractLoadedSuccess) {
          return state.contracts.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Không có thông tin hợp đồng',
                        style: TextStyle(
                          fontFamily: 'MyriadProRegular',
                          fontSize: Responsive.isMobile(context) ? 15 : 30,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          context
                              .read<ContractBloc>()
                              .add(const FetchContracts());
                        },
                        child: Text(
                          'Tải lại',
                          style: TextStyle(
                              fontFamily: 'MyriadProRegular',
                              fontSize: Responsive.isMobile(context) ? 15 : 30,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1),
                        ),
                      ),
                    ],
                  ),
                )
              : RefreshIndicator(
                  onRefresh: () async {
                    context.read<ContractBloc>().add(const FetchContracts());
                  },
                  child: ContractList(
                    contracts: state.contracts,
                  ),
                );
        } else {
          return const SizedBox();
        }
      }),
    );
  }
}
