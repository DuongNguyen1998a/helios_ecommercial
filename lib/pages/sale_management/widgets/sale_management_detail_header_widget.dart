import 'package:flutter/material.dart';

/// Colors
import '../../../colors/app_colors.dart';

/// Models
import '../../../models/sale.dart';

import '../../../utils/functions.dart';

/// Responsive
import '../../../utils/responsive.dart';

class SaleManagementDetailHeaderWidget extends StatelessWidget {
  final Sale sale;

  const SaleManagementDetailHeaderWidget({
    Key? key,
    required this.sale,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle textStyleTitle = TextStyle(
      fontFamily: 'MyriadProRegular',
      fontWeight: FontWeight.w400,
      fontSize: Responsive.isMobile(context) ? 17 : 17 * 1.5,
    );

    TextStyle textStyle = TextStyle(
      fontFamily: 'MyriadProRegular',
      fontWeight: FontWeight.w400,
      fontSize: Responsive.isMobile(context) ? 15 : 15 * 1.5,
    );

    int totalTaxAmount() {
      int total = 0;
      sale.lstDetail.map((e) {
        total += e.vat;
      }).toList();
      return total;
    }

    Widget getWidget(int index) {
      if (index == 0) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  'Tên đề xuất:',
                  style: textStyle,
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  'TEST',
                  style: textStyle,
                ),
              ),
            ],
          ),
        );
      } else if (index == 1) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  'Biểu mẫu:',
                  style: textStyle,
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  'TEST',
                  style: textStyle,
                ),
              ),
            ],
          ),
        );
      } else if (index == 2) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  'Ngày tạo:',
                  style: textStyle,
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  'TEST',
                  style: textStyle,
                ),
              ),
            ],
          ),
        );
      } else if (index == 3) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  'Người đề xuất:',
                  style: textStyle,
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  'TEST',
                  style: textStyle,
                ),
              ),
            ],
          ),
        );
      } else if (index == 4) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  'Phòng ban:',
                  style: textStyle,
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  'TEST',
                  style: textStyle,
                ),
              ),
            ],
          ),
        );
      } else if (index == 5) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  'Tệp đính kèm:',
                  style: textStyle,
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  'TEST',
                  style: textStyle,
                ),
              ),
            ],
          ),
        );
      } else {
        return const SizedBox();
      }
    }

    return ExpansionTile(
      title: Text(
        'Thông tin yêu cầu',
        style: textStyleTitle,
      ),
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                6,
                (index) => getWidget(index),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                left: Responsive.isMobile(context) ? 10 : 10 * 1.5,
                right: Responsive.isMobile(context) ? 10 : 10 * 1.5,
                top: Responsive.isMobile(context) ? 10 : 20,
                bottom: Responsive.isMobile(context) ? 10 : 20,
              ),
              padding: EdgeInsets.only(
                left: Responsive.isMobile(context) ? 8 : 8 * 1.5,
                right: Responsive.isMobile(context) ? 8 : 8 * 1.5,
                top: Responsive.isMobile(context) ? 10 : 20,
                bottom: Responsive.isMobile(context) ? 10 : 20,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.grey),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          sale.orderTitle == ''
                              ? 'Không có tiêu đề'
                              : sale.orderTitle,
                          style: TextStyle(
                            fontFamily: 'MyriadProSemi',
                            fontSize:
                                Responsive.isMobile(context) ? 14 : 14 * 1.5,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Ngày mua: ',
                                style: TextStyle(
                                  fontFamily: 'MyriadProSemi',
                                  fontSize: Responsive.isMobile(context)
                                      ? 13
                                      : 15 * 1.5,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                Functions.formatDDMMYYYY(sale.dateCreate),
                                style: TextStyle(
                                  fontFamily: 'MyriadProSemi',
                                  fontSize: Responsive.isMobile(context)
                                      ? 13
                                      : 15 * 1.5,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                    color: Colors.grey,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'PT thanh toán:',
                            style: TextStyle(
                              fontFamily: 'MyriadProSemi',
                              fontSize:
                                  Responsive.isMobile(context) ? 14 : 14 * 1.5,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            'Chuyển khoản',
                            style: TextStyle(
                              fontFamily: 'MyriadProSemi',
                              fontSize:
                                  Responsive.isMobile(context) ? 14 : 14 * 1.5,
                            ),
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'PT vận chuyển:',
                            style: TextStyle(
                              fontFamily: 'MyriadProSemi',
                              fontSize:
                                  Responsive.isMobile(context) ? 14 : 14 * 1.5,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            'Giao hàng tiêu chuẩn',
                            style: TextStyle(
                              fontFamily: 'MyriadProSemi',
                              fontSize:
                                  Responsive.isMobile(context) ? 14 : 14 * 1.5,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Divider(
                    color: Colors.grey,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Kho hàng:',
                            style: TextStyle(
                              fontFamily: 'MyriadProSemi',
                              fontSize:
                                  Responsive.isMobile(context) ? 14 : 14 * 1.5,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            sale.lstDetail[0].areaName == ''
                                ? 'Không có thông tin'
                                : sale.lstDetail[0].areaName,
                            style: TextStyle(
                              fontFamily: 'MyriadProSemi',
                              fontSize:
                                  Responsive.isMobile(context) ? 14 : 14 * 1.5,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  const Divider(
                    color: Colors.grey,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Địa chỉ nhận hàng:',
                        style: TextStyle(
                          fontFamily: 'MyriadProSemi',
                          fontSize:
                              Responsive.isMobile(context) ? 14 : 14 * 1.5,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        sale.addressReceive,
                        maxLines: 2,
                        style: TextStyle(
                          fontFamily: 'MyriadProSemi',
                          fontSize:
                              Responsive.isMobile(context) ? 14 : 14 * 1.5,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(
                        height: Responsive.isMobile(context) ? 16 : 32,
                      ),
                      Text(
                        sale.userReceive,
                        maxLines: 2,
                        style: TextStyle(
                          fontFamily: 'MyriadProSemi',
                          fontSize:
                              Responsive.isMobile(context) ? 14 : 14 * 1.5,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        sale.phoneReceive,
                        maxLines: 2,
                        style: TextStyle(
                          fontFamily: 'MyriadProSemi',
                          fontSize:
                              Responsive.isMobile(context) ? 14 : 14 * 1.5,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: Responsive.isMobile(context) ? 16 : 16 * 1.5,
                right: Responsive.isMobile(context) ? 16 : 16 * 1.5,
                top: Responsive.isMobile(context) ? 5 : 20,
                bottom: Responsive.isMobile(context) ? 5 : 20,
              ),
              child: Text(
                'Chi tiết đơn hàng:',
                style: TextStyle(
                  fontFamily: 'MyriadProSemi',
                  fontSize: Responsive.isMobile(context) ? 14 : 14 * 1.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Container(
              height: Responsive.isMobile(context) ? 220 : 440,
              padding: EdgeInsets.only(
                top: Responsive.isMobile(context) ? 10 : 20,
                bottom: Responsive.isMobile(context) ? 10 : 20,
              ),
              margin: EdgeInsets.only(
                left: Responsive.isMobile(context) ? 10 : 10 * 1.5,
                right: Responsive.isMobile(context) ? 10 : 10 * 1.5,
                top: Responsive.isMobile(context) ? 10 : 20,
                bottom: Responsive.isMobile(context) ? 10 : 20,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.grey),
              ),
              child: ListView.builder(
                itemCount: sale.lstDetail.length,
                itemBuilder: (context, index) => ListTile(
                  title: Text(
                    sale.lstDetail[index].productName,
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: Responsive.isMobile(context) ? 14 : 14 * 1.5,
                      fontFamily: 'MyriadProRegular',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: Responsive.isMobile(context) ? 5 : 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${sale.lstDetail[index].quantityOrder} Sản Phẩm',
                            style: TextStyle(
                              fontFamily: 'MyriadProRegular',
                              fontSize:
                                  Responsive.isMobile(context) ? 14 : 14 * 1.5,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            '${Functions.formatCurrency(sale.lstDetail[index].vPrice)} đ',
                            style: TextStyle(
                              color: primaryColor,
                              fontSize:
                                  Responsive.isMobile(context) ? 14 : 14 * 1.5,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      const Divider(
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                left: Responsive.isMobile(context) ? 10 : 10 * 1.5,
                right: Responsive.isMobile(context) ? 10 : 10 * 1.5,
                top: Responsive.isMobile(context) ? 10 : 20,
                bottom: Responsive.isMobile(context) ? 10 : 20,
              ),
              padding: EdgeInsets.only(
                left: Responsive.isMobile(context) ? 8 : 8 * 1.5,
                right: Responsive.isMobile(context) ? 8 : 8 * 1.5,
                top: Responsive.isMobile(context) ? 10 : 20,
                bottom: Responsive.isMobile(context) ? 10 : 20,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.grey),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Tổng tiền:',
                        style: TextStyle(
                          fontFamily: 'MyriadProSemi',
                          fontSize:
                              Responsive.isMobile(context) ? 14 : 14 * 1.5,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        '${Functions.formatCurrency(sale.vTotalAmount)} đ',
                        style: TextStyle(
                          fontFamily: 'MyriadProSemi',
                          fontSize:
                              Responsive.isMobile(context) ? 14 : 14 * 1.5,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                    color: Colors.grey,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Thuế (VAT):',
                        style: TextStyle(
                          fontFamily: 'MyriadProSemi',
                          fontSize:
                              Responsive.isMobile(context) ? 14 : 14 * 1.5,
                        ),
                      ),
                      Text(
                        '${Functions.formatCurrency(totalTaxAmount())} đ',
                        style: TextStyle(
                          fontFamily: 'MyriadProSemi',
                          fontSize:
                              Responsive.isMobile(context) ? 14 : 14 * 1.5,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Responsive.isMobile(context) ? 8 : 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Phí vận chuyển:',
                        style: TextStyle(
                          fontFamily: 'MyriadProSemi',
                          fontSize:
                              Responsive.isMobile(context) ? 14 : 14 * 1.5,
                        ),
                      ),
                      Text(
                        '${Functions.formatCurrency(sale.amountDelivery)} đ',
                        style: TextStyle(
                          fontFamily: 'MyriadProSemi',
                          fontSize:
                              Responsive.isMobile(context) ? 14 : 14 * 1.5,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Responsive.isMobile(context) ? 8 : 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Giảm giá:',
                        style: TextStyle(
                          fontFamily: 'MyriadProSemi',
                          fontSize:
                              Responsive.isMobile(context) ? 14 : 14 * 1.5,
                        ),
                      ),
                      Text(
                        '${Functions.formatCurrency(sale.totalAmountDiscount)} đ',
                        style: TextStyle(
                          fontFamily: 'MyriadProSemi',
                          fontSize:
                              Responsive.isMobile(context) ? 14 : 14 * 1.5,
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                    color: Colors.grey,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Thành tiền:',
                        style: TextStyle(
                          fontFamily: 'MyriadProSemi',
                          fontSize:
                              Responsive.isMobile(context) ? 14 : 14 * 1.5,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        '${Functions.formatCurrency(sale.totalAmountv)} đ',
                        style: TextStyle(
                          fontFamily: 'MyriadProSemi',
                          fontSize:
                              Responsive.isMobile(context) ? 14 : 14 * 1.5,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
