import 'package:flutter/material.dart';

import '../../base_widgets/my_app_bar.dart';

/// Colors
import '../../colors/app_colors.dart';

/// Responsive
import '../../utils/responsive.dart';

class PaymentMethodPage extends StatefulWidget {
  const PaymentMethodPage({Key? key}) : super(key: key);

  @override
  State<PaymentMethodPage> createState() => _PaymentMethodPageState();
}

class _PaymentMethodPageState extends State<PaymentMethodPage> {
  int currentRadioValue = 0;

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
              margin: EdgeInsets.symmetric(
                horizontal: Responsive.isMobile(context) ? 20 : 40,
                vertical: Responsive.isMobile(context) ? 10 : 20,
              ),
              padding: EdgeInsets.all(Responsive.isMobile(context) ? 10 : 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    minLeadingWidth: Responsive.isMobile(context) ? 0 : 2,
                    minVerticalPadding: Responsive.isMobile(context) ? 0 : 2,
                    contentPadding: EdgeInsets.zero,
                    leading: Radio<int>(
                      activeColor: primaryColor,
                      groupValue: currentRadioValue,
                      value: 0,
                      onChanged: (val) {
                        setState(() {
                          currentRadioValue = val!.toInt();
                        });
                      },
                    ),
                    title: Text(
                      'Chuyển khoản qua ngân hàng',
                      style: TextStyle(
                        fontFamily: 'MyriadProRegular',
                        fontSize: Responsive.isMobile(context) ? 14 : 14 * 1.5,
                      ),
                    ),
                  ),
                  const Divider(
                    color: Colors.grey,
                  ),
                  SizedBox(
                    height: Responsive.isMobile(context) ? 2 : 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Người thụ hưởng:\nCty cổ phần công nghệ Helios',
                          style: TextStyle(
                            fontFamily: 'MyriadProRegular',
                            fontSize:
                                Responsive.isMobile(context) ? 14 : 14 * 1.5,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          primary: primaryColor,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(
                              Responsive.isMobile(context) ? 8 : 16),
                          child: Text(
                            'Sao chép',
                            style: TextStyle(
                                fontSize: Responsive.isMobile(context)
                                    ? 14
                                    : 14 * 1.5),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Responsive.isMobile(context) ? 2 : 10,
                  ),
                  const Divider(
                    color: Colors.grey,
                  ),
                  SizedBox(
                    height: Responsive.isMobile(context) ? 2 : 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          '1122 3344 5566 7788\nBIDV - Chinh nhánh HaNoi',
                          style: TextStyle(
                            fontFamily: 'MyriadProRegular',
                            fontSize:
                                Responsive.isMobile(context) ? 14 : 14 * 1.5,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          primary: primaryColor,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(
                              Responsive.isMobile(context) ? 8 : 16),
                          child: Text(
                            'Sao chép',
                            style: TextStyle(
                                fontSize: Responsive.isMobile(context)
                                    ? 14
                                    : 14 * 1.5),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Responsive.isMobile(context) ? 2 : 10,
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: Responsive.isMobile(context) ? 20 : 40,
                vertical: Responsive.isMobile(context) ? 10 : 20,
              ),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                minLeadingWidth: Responsive.isMobile(context) ? 0 : 2,
                minVerticalPadding: Responsive.isMobile(context) ? 0 : 2,
                contentPadding: EdgeInsets.zero,
                leading: Radio<int>(
                  activeColor: primaryColor,
                  groupValue: currentRadioValue,
                  value: 1,
                  onChanged: (val) {
                    setState(() {
                      currentRadioValue = val!.toInt();
                    });
                  },
                ),
                title: Text(
                  'Thanh toán khi nhận hàng (COD)',
                  style: TextStyle(
                    fontFamily: 'MyriadProRegular',
                    fontSize: Responsive.isMobile(context) ? 14 : 14 * 1.5,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: Responsive.isMobile(context) ? 20 : 40,
                vertical: Responsive.isMobile(context) ? 10 : 20,
              ),
              padding: EdgeInsets.all(Responsive.isMobile(context) ? 10 : 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    minLeadingWidth: Responsive.isMobile(context) ? 0 : 2,
                    minVerticalPadding: Responsive.isMobile(context) ? 0 : 2,
                    contentPadding: EdgeInsets.zero,
                    leading: Radio<int>(
                      activeColor: primaryColor,
                      groupValue: currentRadioValue,
                      value: 2,
                      onChanged: (val) {
                        setState(() {
                          currentRadioValue = val!.toInt();
                        });
                      },
                    ),
                    title: Text(
                      'Thẻ ghi nợ quốc tế',
                      style: TextStyle(
                        fontFamily: 'MyriadProRegular',
                        fontSize: Responsive.isMobile(context) ? 14 : 14 * 1.5,
                      ),
                    ),
                  ),
                  const Divider(
                    color: Colors.grey,
                  ),
                  Container(
                    padding:
                        EdgeInsets.all(Responsive.isMobile(context) ? 10 : 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.grey,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Số thẻ: ',
                          style: TextStyle(
                            fontFamily: 'MyriadProRegular',
                            fontSize:
                                Responsive.isMobile(context) ? 14 : 14 * 1.5,
                          ),
                        ),
                        SizedBox(
                          width: Responsive.isMobile(context) ? 10 : 20,
                        ),
                        Expanded(
                          child: TextFormField(
                            style: TextStyle(
                              fontSize:
                                  Responsive.isMobile(context) ? 14 : 14 * 1.5,
                              fontFamily: 'MyriadProRegular',
                            ),
                            cursorColor: primaryColor,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'XXXX-XXXX-XXXX-XXXX',
                              hintStyle: TextStyle(
                                fontSize: Responsive.isMobile(context)
                                    ? 14
                                    : 14 * 1.5,
                                fontFamily: 'MyriadProRegular',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          margin: EdgeInsets.only(
                            top: Responsive.isMobile(context) ? 10 : 20,
                          ),
                          padding: EdgeInsets.all(
                              Responsive.isMobile(context) ? 10 : 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.grey,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Text(
                                  'Ngày hết hạn: ',
                                  style: TextStyle(
                                    fontFamily: 'MyriadProRegular',
                                    fontSize: Responsive.isMobile(context)
                                        ? 14
                                        : 14 * 1.5,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: Responsive.isMobile(context) ? 10 : 20,
                              ),
                              Expanded(
                                child: TextFormField(
                                  style: TextStyle(
                                    fontSize: Responsive.isMobile(context)
                                        ? 14
                                        : 14 * 1.5,
                                    fontFamily: 'MyriadProRegular',
                                  ),
                                  cursorColor: primaryColor,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'XX/XX',
                                    hintStyle: TextStyle(
                                      fontSize: Responsive.isMobile(context)
                                          ? 14
                                          : 14 * 1.5,
                                      fontFamily: 'MyriadProRegular',
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: Responsive.isMobile(context) ? 10 : 20,
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          margin: EdgeInsets.only(
                              top: Responsive.isMobile(context) ? 10 : 20),
                          padding: EdgeInsets.all(
                            Responsive.isMobile(context) ? 10 : 20,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.grey,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Text(
                                  'CVV: ',
                                  style: TextStyle(
                                    fontSize: Responsive.isMobile(context)
                                        ? 14
                                        : 14 * 1.5,
                                    fontFamily: 'MyriadProRegular',
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: Responsive.isMobile(context) ? 10 : 20,
                              ),
                              Expanded(
                                child: TextFormField(
                                  style: TextStyle(
                                    fontSize: Responsive.isMobile(context)
                                        ? 14
                                        : 14 * 1.5,
                                    fontFamily: 'MyriadProRegular',
                                  ),
                                  cursorColor: primaryColor,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'XXX',
                                    hintStyle: TextStyle(
                                      fontSize: Responsive.isMobile(context)
                                          ? 14
                                          : 14 * 1.5,
                                      fontFamily: 'MyriadProRegular',
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: Responsive.isMobile(context) ? 20 : 40,
                vertical: Responsive.isMobile(context) ? 10 : 20,
              ),
              padding: EdgeInsets.all(Responsive.isMobile(context) ? 10 : 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    minLeadingWidth: Responsive.isMobile(context) ? 0 : 2,
                    minVerticalPadding: Responsive.isMobile(context) ? 0 : 2,
                    contentPadding: EdgeInsets.zero,
                    leading: Radio<int>(
                      activeColor: primaryColor,
                      groupValue: currentRadioValue,
                      value: 3,
                      onChanged: (val) {
                        setState(() {
                          currentRadioValue = val!.toInt();
                        });
                      },
                    ),
                    title: Text(
                      'Thẻ nội địa ATM / Napas',
                      style: TextStyle(
                        fontFamily: 'MyriadProRegular',
                        fontSize: Responsive.isMobile(context) ? 14 : 14 * 1.5,
                      ),
                    ),
                  ),
                  const Divider(
                    color: Colors.grey,
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        bottom: Responsive.isMobile(context) ? 10 : 20),
                    padding:
                        EdgeInsets.all(Responsive.isMobile(context) ? 10 : 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.grey,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Số thẻ: ',
                          style: TextStyle(
                            fontFamily: 'MyriadProRegular',
                            fontSize:
                                Responsive.isMobile(context) ? 14 : 14 * 1.5,
                          ),
                        ),
                        SizedBox(
                          width: Responsive.isMobile(context) ? 10 : 20,
                        ),
                        Expanded(
                          child: TextFormField(
                            style: TextStyle(
                              fontSize:
                                  Responsive.isMobile(context) ? 14 : 14 * 1.5,
                              fontFamily: 'MyriadProRegular',
                            ),
                            cursorColor: primaryColor,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'XXXX-XXXX-XXXX-XXXX',
                              hintStyle: TextStyle(
                                fontSize: Responsive.isMobile(context)
                                    ? 16
                                    : 16 * 1.5,
                                fontFamily: 'MyriadProRegular',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        bottom: Responsive.isMobile(context) ? 10 : 20),
                    padding:
                        EdgeInsets.all(Responsive.isMobile(context) ? 10 : 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.grey,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Họ tên chủ thẻ: ',
                          style: TextStyle(
                              fontSize:
                                  Responsive.isMobile(context) ? 14 : 14 * 1.5,
                              fontFamily: 'MyriadProRegular'),
                        ),
                        SizedBox(
                          width: Responsive.isMobile(context) ? 10 : 20,
                        ),
                        Expanded(
                          child: TextFormField(
                            style: TextStyle(
                              fontSize:
                                  Responsive.isMobile(context) ? 14 : 14 * 1.5,
                              fontFamily: 'MyriadProRegular',
                            ),
                            cursorColor: primaryColor,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'XXXX-XXXX-XXXX-XXXX',
                              hintStyle: TextStyle(
                                fontSize: Responsive.isMobile(context)
                                    ? 14
                                    : 16 * 1.5,
                                fontFamily: 'MyriadProRegular',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding:
                        EdgeInsets.all(Responsive.isMobile(context) ? 10 : 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.grey,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Ngày hết hạn: ',
                          style: TextStyle(
                            fontSize:
                                Responsive.isMobile(context) ? 14 : 14 * 1.5,
                            fontFamily: 'MyriadProRegular',
                          ),
                        ),
                        SizedBox(
                          width: Responsive.isMobile(context) ? 10 : 20,
                        ),
                        Expanded(
                          child: TextFormField(
                            style: TextStyle(
                              fontSize:
                                  Responsive.isMobile(context) ? 14 : 14 * 1.5,
                              fontFamily: 'MyriadProRegular',
                            ),
                            cursorColor: primaryColor,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'XXXX-XXXX-XXXX-XXXX',
                              hintStyle: TextStyle(
                                fontSize: Responsive.isMobile(context)
                                    ? 14
                                    : 14 * 1.5,
                                fontFamily: 'MyriadProRegular',
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
            Container(
              margin: EdgeInsets.symmetric(
                  horizontal: Responsive.isMobile(context) ? 20 : 40,
                  vertical: Responsive.isMobile(context) ? 10 : 20),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  primary: primaryColor,
                ),
                child: Padding(
                  padding:
                      EdgeInsets.all(Responsive.isMobile(context) ? 8 : 16),
                  child: Text(
                    'Cập nhật',
                    style: TextStyle(
                      fontFamily: 'MyriadProRegular',
                      fontSize: Responsive.isMobile(context) ? 15 : 15 * 1.5,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
