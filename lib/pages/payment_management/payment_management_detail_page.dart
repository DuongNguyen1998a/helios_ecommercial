import 'package:flutter/material.dart';

import '../../base_widgets/my_app_bar.dart';
import '../../colors/app_colors.dart';
import '../../routes/app_routes.dart';
import '../../utils/functions.dart';
import '../../utils/responsive.dart';

class PaymentManagementDetailPage extends StatelessWidget {
  final String action;

  const PaymentManagementDetailPage({
    Key? key,
    required this.action,
  }) : super(key: key);

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
        title: 'Phương Thức Thanh Toán',
        leadingIcon: Icons.arrow_back,
        leadingIconClick: () {
          Navigator.pop(context);
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'ID.12348877',
                        style: TextStyle(
                          fontFamily: 'MyriadProSemi',
                          fontSize:
                              Responsive.isMobile(context) ? 14 : 14 * 1.5,
                          color: primaryColor,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            'Ngày mua: ',
                            style: TextStyle(
                              fontFamily: 'MyriadProSemi',
                              fontSize:
                                  Responsive.isMobile(context) ? 14 : 14 * 1.5,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            '27/02/2022',
                            style: TextStyle(
                              fontFamily: 'MyriadProSemi',
                              fontSize:
                                  Responsive.isMobile(context) ? 14 : 14 * 1.5,
                            ),
                          ),
                        ],
                      )
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
                      action == 'paid'
                          ? const SizedBox()
                          : ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, AppRoutes.paymentMethod);
                              },
                              style: ElevatedButton.styleFrom(
                                primary: primaryColor,
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(
                                    Responsive.isMobile(context) ? 8 : 16),
                                child: Text(
                                  'Thay đổi',
                                  style: TextStyle(
                                      fontSize: Responsive.isMobile(context)
                                          ? 14
                                          : 14 * 1.5,
                                      fontFamily: 'MyriadProRegular'),
                                ),
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
                            'Kho hàng:',
                            style: TextStyle(
                              fontFamily: 'MyriadProSemi',
                              fontSize:
                                  Responsive.isMobile(context) ? 14 : 14 * 1.5,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: Responsive.isMobile(context) ? 8 : 16,
                          ),
                          Text(
                            'HCM',
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
                            'Người duyệt:',
                            style: TextStyle(
                              fontFamily: 'MyriadProSemi',
                              fontSize:
                                  Responsive.isMobile(context) ? 14 : 14 * 1.5,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: Responsive.isMobile(context) ? 8 : 16,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: List.generate(
                              3,
                              (index) => Text(
                                'User ${index + 1}',
                                style: TextStyle(
                                  fontFamily: 'MyriadProSemi',
                                  fontSize: Responsive.isMobile(context)
                                      ? 14
                                      : 14 * 1.5,
                                ),
                              ),
                            ),
                          ),
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
                        '123/456/789',
                        maxLines: 2,
                        style: TextStyle(
                          fontFamily: 'MyriadProSemi',
                          fontSize:
                              Responsive.isMobile(context) ? 14 : 14 * 1.5,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(
                        height: Responsive.isMobile(context) ? 20 : 40,
                      ),
                      Text(
                        'Dương Nguyễn',
                        maxLines: 2,
                        style: TextStyle(
                          fontFamily: 'MyriadProSemi',
                          fontSize:
                              Responsive.isMobile(context) ? 14 : 14 * 1.5,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        '0909123123',
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
                left: Responsive.isMobile(context) ? 10 : 10 * 1.5,
                right: Responsive.isMobile(context) ? 10 : 10 * 1.5,
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
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: ListView.builder(
                itemCount: 2,
                itemBuilder: (context, index) => ListTile(
                  title: Text(
                    'productName ${index + 1}',
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
                            '1 Sản Phẩm',
                            style: TextStyle(
                              fontFamily: 'MyriadProRegular',
                              fontSize:
                                  Responsive.isMobile(context) ? 14 : 14 * 1.5,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            '${Functions.formatCurrency(100000)} đ',
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
                color: Colors.white,
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
                        '${Functions.formatCurrency(100000)} đ',
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
                      Text('0 đ',
                          style: TextStyle(
                            fontFamily: 'MyriadProSemi',
                            fontSize:
                                Responsive.isMobile(context) ? 14 : 14 * 1.5,
                          )),
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
                        '${Functions.formatCurrency(100000)} đ',
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
                        '${Functions.formatCurrency(100000)} đ',
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
                        '${Functions.formatCurrency(10000)} đ',
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
            action == 'paid'
                ? const SizedBox()
                : Padding(
                    padding: EdgeInsets.only(
                      left: Responsive.isMobile(context) ? 16 : 16 * 1.5,
                      right: Responsive.isMobile(context) ? 16 : 16 * 1.5,
                      top: Responsive.isMobile(context) ? 10 : 20,
                      bottom: Responsive.isMobile(context) ? 10 : 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 1,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: primaryColor,
                            ),
                            onPressed: () {},
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      Responsive.isMobile(context) ? 0 : 16,
                                  vertical:
                                      Responsive.isMobile(context) ? 0 : 16),
                              child: Text(
                                'Thanh toán',
                                style: TextStyle(
                                  fontSize: Responsive.isMobile(context)
                                      ? 15
                                      : 15 * 1.5,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
