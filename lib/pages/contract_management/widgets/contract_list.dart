import 'package:flutter/material.dart';

import '../../../models/contract.dart';
import '../../../utils/functions.dart';
import '../../../utils/responsive.dart';

class ContractList extends StatelessWidget {
  final List<Contract> contracts;

  const ContractList({
    Key? key,
    required this.contracts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: contracts.length,
      itemBuilder: (context, index) => InkWell(
        onTap: () {
          // Navigator.pushNamed(
          //   context,
          //   AppRoutes.contractManagementDetail,
          //   arguments: contracts[index],
          // );
        },
        child: ContractItem(
          contract: contracts[index],
        ),
      ),
    );
  }
}

class ContractItem extends StatelessWidget {
  final Contract contract;

  const ContractItem({
    Key? key,
    required this.contract,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          left: Responsive.isMobile(context) ? 16 : 16 * 1.5,
          right: Responsive.isMobile(context) ? 16 : 16 * 1.5,
          top: Responsive.isMobile(context) ? 10 : 20,
          bottom: Responsive.isMobile(context) ? 5 : 10),
      padding: EdgeInsets.all(Responsive.isMobile(context) ? 16 : 16 * 1.5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ID.${contract.contractCode}',
            style: TextStyle(
              fontFamily: 'MyriadProSemi',
              fontSize: Responsive.isMobile(context) ? 17 : 17 * 1.5,
            ),
          ),
          const Divider(
            color: Colors.black,
          ),
          SizedBox(
            height: Responsive.isMobile(context) ? 10 : 20,
          ),
          Text(
            contract.companyName,
            style: TextStyle(
              fontFamily: 'MyriadProSemi',
              fontSize: Responsive.isMobile(context) ? 17 : 17 * 1.5,
            ),
          ),
          SizedBox(
            height: Responsive.isMobile(context) ? 10 : 20,
          ),
          Row(
            children: [
              Icon(
                Icons.person_pin_circle_outlined,
                size: Responsive.isMobile(context) ? 22 : 22 * 1.5,
              ),
              SizedBox(
                width: Responsive.isMobile(context) ? 8 : 16,
              ),
              Text(
                'Người tạo: ${contract.userCreate}',
                style: TextStyle(
                  fontFamily: 'MyriadProSemi',
                  fontSize: Responsive.isMobile(context) ? 17 : 17 * 1.5,
                ),
              ),
            ],
          ),
          SizedBox(
            height: Responsive.isMobile(context) ? 10 : 20,
          ),
          Row(
            children: [
              Icon(
                Icons.access_time_outlined,
                size: Responsive.isMobile(context) ? 22 : 22 * 1.5,
              ),
              SizedBox(
                width: Responsive.isMobile(context) ? 8 : 16,
              ),
              Text(
                'Ngày tạo: ${Functions.formatDDMMYYYY(contract.dateCreate)}',
                style: TextStyle(
                  fontFamily: 'MyriadProSemi',
                  fontSize: Responsive.isMobile(context) ? 17 : 17 * 1.5,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}