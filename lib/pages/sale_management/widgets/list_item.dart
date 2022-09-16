import 'package:flutter/material.dart';

import '../../../colors/app_colors.dart';
import '../../../models/sale.dart';
import '../../../utils/functions.dart';
import '../../../utils/responsive.dart';

class ListItem extends StatelessWidget {
  final String action;
  final Function onItemClick;
  final Sale sale;

  const ListItem({
    Key? key,
    required this.action,
    required this.onItemClick,
    required this.sale,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onItemClick();
      },
      child: Container(
        margin: EdgeInsets.only(
          left: Responsive.isMobile(context) ? 16 : 16 * 1.5,
          right: Responsive.isMobile(context) ? 16 : 16 * 1.5,
          top: Responsive.isMobile(context) ? 10 : 20,
          bottom: Responsive.isMobile(context) ? 5 : 10,
        ),
        padding: EdgeInsets.all(
          Responsive.isMobile(context) ? 16 : 16 * 1.5,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  sale.orderTitle == '' ? 'Không có tiêu đề' : sale.orderTitle,
                  style: TextStyle(
                    fontFamily: 'MyriadProSemi',
                    fontSize: Responsive.isMobile(context) ? 16 : 16 * 1.5,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                action == 'pending'
                    ? Text(
                        '${Functions.formatCurrency(sale.vTotalAmount)} đ',
                        style: TextStyle(
                          fontFamily: 'MyriadProSemi',
                          fontSize:
                              Responsive.isMobile(context) ? 16 : 16 * 1.5,
                          color: primaryColor,
                        ),
                      )
                    : const SizedBox()
              ],
            ),
            const Divider(
              color: Colors.black,
            ),
            SizedBox(
              height: Responsive.isMobile(context) ? 10 : 20,
            ),
            Text(
              'HĐ số: ${sale.orderCode}',
              style: TextStyle(
                fontFamily: 'MyriadProSemi',
                fontSize: Responsive.isMobile(context) ? 15 : 15 * 1.5,
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
                  'Người tạo: ${sale.nameUCreate}',
                  style: TextStyle(
                    fontFamily: 'MyriadProSemi',
                    fontSize: Responsive.isMobile(context) ? 15 : 15 * 1.5,
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
                  'Ngày tạo: ${Functions.formatDDMMYYYY(sale.dateCreate)}',
                  style: TextStyle(
                    fontFamily: 'MyriadProSemi',
                    fontSize: Responsive.isMobile(context) ? 15 : 15 * 1.5,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: Responsive.isMobile(context) ? 0 : 16,
            ),
            sale.lstApprove.isNotEmpty
                ? Theme(
                    data: Theme.of(context)
                        .copyWith(dividerColor: Colors.transparent),
                    child: ListTileTheme(
                      contentPadding: const EdgeInsets.all(0),
                      dense: true,
                      child: ExpansionTile(
                        childrenPadding: EdgeInsets.symmetric(
                            horizontal: Responsive.isMobile(context) ? 10 : 20),
                        title: Row(
                          children: [
                            Icon(
                              Icons.person_pin_circle_outlined,
                              size:
                                  Responsive.isMobile(context) ? 24 : 24 * 1.5,
                            ),
                            SizedBox(
                              width: Responsive.isMobile(context) ? 8 : 14,
                            ),
                            Text(
                              'Người duyệt',
                              style: TextStyle(
                                fontFamily: 'MyriadProSemi',
                                fontSize: Responsive.isMobile(context)
                                    ? 15
                                    : 15 * 1.5,
                              ),
                            ),
                          ],
                        ),
                        children: List.generate(
                          sale.lstApprove.length,
                          (index) => Padding(
                            padding: EdgeInsets.symmetric(
                                vertical:
                                    Responsive.isMobile(context) ? 8 : 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  sale.lstApprove[index].nameUApprove,
                                  style: TextStyle(
                                    fontFamily: 'MyriadProSemi',
                                    fontSize: Responsive.isMobile(context)
                                        ? 15
                                        : 15 * 1.5,
                                  ),
                                ),
                                sale.lstApprove[index].isApprove == 1
                                    ? Icon(
                                        Icons.check_circle,
                                        color: Colors.green,
                                        size: Responsive.isMobile(context)
                                            ? 24
                                            : 24 * 1.5,
                                      )
                                    : Icon(
                                        Icons.warning,
                                        color: Colors.orangeAccent,
                                        size: Responsive.isMobile(context)
                                            ? 24
                                            : 24 * 1.5,
                                      )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                : const SizedBox(),
            SizedBox(
              height: Responsive.isMobile(context) ? 10 : 20,
            ),
            Row(
              children: [
                Icon(
                  action == 'refused'
                      ? Icons.cancel
                      : action == 'pending'
                          ? Icons.warning
                          : Icons.check_circle,
                  color: action == 'refused'
                      ? Colors.red
                      : action == 'pending'
                          ? Colors.orangeAccent
                          : Colors.green,
                  size: Responsive.isMobile(context) ? 22 : 22 * 1.5,
                ),
                SizedBox(
                  width: Responsive.isMobile(context) ? 8 : 16,
                ),
                Text(
                  action == 'refused'
                      ? 'Từ chối'
                      : action == 'pending'
                          ? 'Chờ duyệt'
                          : 'Đã duyệt',
                  style: TextStyle(
                    fontFamily: 'MyriadProSemi',
                    fontSize: Responsive.isMobile(context) ? 15 : 15 * 1.5,
                    color: action == 'refused'
                        ? Colors.red
                        : action == 'pending'
                            ? Colors.orangeAccent
                            : Colors.green,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
