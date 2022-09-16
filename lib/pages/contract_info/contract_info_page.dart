import 'package:flutter/material.dart';

import '../../base_widgets/my_app_bar.dart';
import '../../colors/app_colors.dart';
import '../../utils/responsive.dart';

class ContractInfoPage extends StatefulWidget {
  const ContractInfoPage({Key? key}) : super(key: key);

  @override
  State<ContractInfoPage> createState() => _ContractInfoPageState();
}

class _ContractInfoPageState extends State<ContractInfoPage> {
  double heightOfAppbar = AppBar().preferredSize.height;
  double heightOfAppbarTablet = AppBar().preferredSize.height * 1.45;

  List<Map<String, dynamic>> contractTypes = [
    {
      'name': 'Khách hàng vãng lai',
      'value': 0,
    },
    {
      'name': 'Hợp đồng loại 1',
      'value': 1,
    },
    {
      'name': 'Hợp đồng loại 2',
      'value': 2,
    },
  ];

  int currentValueRadio = 0;

  @override
  Widget build(BuildContext context) {
    TextStyle textStyleTitle1 = TextStyle(
      fontSize: Responsive.isMobile(context) ? 15 : 15 * 1.5,
      fontFamily: 'MyriadProRegular',
    );

    return Scaffold(
      appBar: MyAppBar(
        height: Responsive.isMobile(context)
            ? heightOfAppbar
            : heightOfAppbarTablet,
        title: 'Phân Loại Hợp Đồng',
        leadingIcon: Icons.arrow_back,
        leadingIconClick: () {
          Navigator.pop(context);
        },
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            margin: EdgeInsets.all(Responsive.isMobile(context) ? 16 : 32),
            padding: EdgeInsets.all(Responsive.isMobile(context) ? 10 : 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                contractTypes.length,
                (index) => ListTile(
                  minLeadingWidth: 0,
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    contractTypes[index]['name'],
                    style: textStyleTitle1,
                  ),
                  leading: Radio<int>(
                    activeColor: primaryColor,
                    value: contractTypes[index]['value'],
                    groupValue: currentValueRadio,
                    onChanged: (value) {
                      setState(() {
                        currentValueRadio = value!.toInt();
                      });
                    },
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(
                horizontal: Responsive.isMobile(context) ? 16 : 32),
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: primaryColor,
                  padding:
                      EdgeInsets.all(Responsive.isMobile(context) ? 8 : 16)),
              onPressed: () {},
              child: Text(
                'Cập nhật',
                style: TextStyle(
                  fontFamily: 'MyriadProRegular',
                  fontSize: Responsive.isMobile(context) ? 16 : 16 * 1.5,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
