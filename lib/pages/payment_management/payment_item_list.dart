import 'package:flutter/material.dart';

import '../../utils/responsive.dart';

class PaymentItemList extends StatelessWidget {
  final String action;
  final Function onItemClick;

  const PaymentItemList({
    Key? key,
    required this.action,
    required this.onItemClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onItemClick();
      },
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: Responsive.isMobile(context) ? 20 : 20 * 1.5,
          vertical: Responsive.isMobile(context) ? 10 : 20,
        ),
        padding: EdgeInsets.all(
          Responsive.isMobile(context) ? 10 : 20,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Cty TNHH xây dựng XXXXXXXXXX',
              style: TextStyle(
                  fontFamily: 'MyriadProRegular',
                  fontSize: Responsive.isMobile(context) ? 14 : 14 * 1.5),
            ),
            SizedBox(
              height: Responsive.isMobile(context) ? 8 : 16,
            ),
            Text(
              'HĐ số: XXXXXXX',
              style: TextStyle(
                  fontFamily: 'MyriadProRegular',
                  fontSize: Responsive.isMobile(context) ? 14 : 14 * 1.5),
            ),
            SizedBox(
              height: Responsive.isMobile(context) ? 20 : 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    action == 'paid'
                        ? Icon(
                            Icons.check_circle,
                            color: Colors.green,
                            size: Responsive.isMobile(context) ? 24 : 24 * 1.5,
                          )
                        : Icon(
                            Icons.cancel,
                            color: Colors.red,
                            size: Responsive.isMobile(context) ? 24 : 24 * 1.5,
                          ),
                    SizedBox(
                      width: Responsive.isMobile(context) ? 8 : 16,
                    ),
                    Text(
                      action == 'paid' ? 'Đã thanh toán' : 'Chưa thanh toán',
                      style: TextStyle(
                        color: action == 'paid' ? Colors.green : Colors.red,
                        fontFamily: 'MyriadProRegular',
                        fontSize: Responsive.isMobile(context) ? 14 : 14 * 1.5,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.access_time_outlined,
                      color: Colors.grey,
                      size: Responsive.isMobile(context) ? 24 : 24 * 1.5,
                    ),
                    SizedBox(
                      width: Responsive.isMobile(context) ? 8 : 16,
                    ),
                    Text(
                      '27/02/2022',
                      style: TextStyle(
                        fontFamily: 'MyriadProRegular',
                        fontSize: Responsive.isMobile(context) ? 14 : 14 * 1.5,
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
