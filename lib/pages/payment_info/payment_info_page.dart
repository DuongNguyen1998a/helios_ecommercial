import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helios_ecommercial/models/region_model.dart';
import 'package:helios_ecommercial/services/app_services.dart';

/// Base widgets
import '../../base_widgets/my_app_bar.dart';

import '../../blocs/cart_bloc/cart_bloc.dart';

/// Colors
import '../../colors/app_colors.dart';

/// Responsive
import '../../utils/responsive.dart';

class PaymentInfoPage extends StatefulWidget {
  const PaymentInfoPage({Key? key}) : super(key: key);

  @override
  State<PaymentInfoPage> createState() => _PaymentInfoPageState();
}

class _PaymentInfoPageState extends State<PaymentInfoPage> {
  double heightOfAppbar = AppBar().preferredSize.height;
  double heightOfAppbarTablet = AppBar().preferredSize.height * 1.45;

  List<Map<String, dynamic>> transportMethod = [
    {
      'name': 'Giao hàng tiêu chuẩn',
      'value': 0,
    },
    {
      'name': 'Giao hàng nhanh',
      'value': 1,
    },
  ];

  final addressTextController = TextEditingController();
  final phoneTextController = TextEditingController();
  final paymentInfoFormKey = GlobalKey<FormState>();

  int currentTransportMethod = 0;

  void passTransportMethod(int value) {
    setState(() {
      currentTransportMethod = value;
    });
  }

  void updatePaymentInfo() {
    if (!paymentInfoFormKey.currentState!.validate()) {
      return;
    } else {
      String address =
          '${addressTextController.text}, ${selectedWard.regionyName}, ${selectedDistrict.regionyName}, ${selectedCity.regionyName}';
      String phone = phoneTextController.text;

      context.read<CartBloc>().add(GetPaymentInfo(
            address: address,
            phone: phone,
            transportMethod: currentTransportMethod,
          ));

      final snackBar = SnackBar(
        content: Text(
          'Cập nhật thông tin thành công',
          style: TextStyle(
            fontSize: Responsive.isMobile(context) ? 15 : 15 * 1.5,
            fontFamily: 'MyriadProRegular',
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      Navigator.pop(context);
    }
  }

  @override
  void initState() {
    fetchRegionsCity().then((_) {
      fetchRegionsDistrict(selectedCity.regionID).then((_) {
        fetchRegionsWard(selectedDistrict.regionID);
      });
    });
    super.initState();
  }

  List<RegionModel> regionsCity = [];
  List<RegionModel> regionsDistrict = [];
  List<RegionModel> regionsWard = [];
  RegionModel selectedCity = const RegionModel(
    regionID: 0,
    regionCode: 0,
    regionyName: '',
    parentID: 0,
    description: '',
    status: 0,
  );
  RegionModel selectedDistrict = const RegionModel(
    regionID: 0,
    regionCode: 0,
    regionyName: '',
    parentID: 0,
    description: '',
    status: 0,
  );
  RegionModel selectedWard = const RegionModel(
    regionID: 0,
    regionCode: 0,
    regionyName: '',
    parentID: 0,
    description: '',
    status: 0,
  );

  Future<void> fetchRegionsCity() async {
    try {
      final appServices = AppServices();
      final response = await appServices.fetchRegions(0);

      if (response.statusCode == 200 && response.data['code'] == '0') {
        final jsonData = response.data['responseData'] as List;
        final data = jsonData.map((e) => RegionModel.fromJson(e)).toList();
        setState(() {
          regionsCity.clear();
          regionsCity.addAll(data);
          selectedCity = regionsCity[0];
        });
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> fetchRegionsDistrict(int parentId) async {
    try {
      final appServices = AppServices();
      final response = await appServices.fetchRegions(parentId);

      if (response.statusCode == 200 && response.data['code'] == '0') {
        final jsonData = response.data['responseData'] as List;
        final data = jsonData.map((e) => RegionModel.fromJson(e)).toList();
        setState(() {
          regionsDistrict.clear();
          regionsDistrict.addAll(data);
          selectedDistrict = regionsDistrict[0];
        });
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> fetchRegionsWard(int parentId) async {
    try {
      final appServices = AppServices();
      final response = await appServices.fetchRegions(parentId);

      if (response.statusCode == 200 && response.data['code'] == '0') {
        final jsonData = response.data['responseData'] as List;
        final data = jsonData.map((e) => RegionModel.fromJson(e)).toList();
        setState(() {
          regionsWard.clear();
          regionsWard.addAll(data);
          selectedWard = regionsWard[0];
        });
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyleTitle = TextStyle(
      fontSize: Responsive.isMobile(context) ? 16 : 16 * 1.5,
      fontFamily: 'MyriadProRegular',
      letterSpacing: 1,
    );

    TextStyle textStyleTitle1 = TextStyle(
      fontSize: Responsive.isMobile(context) ? 15 : 15 * 1.5,
      fontFamily: 'MyriadProRegular',
    );

    return Scaffold(
      appBar: MyAppBar(
        height: Responsive.isMobile(context)
            ? heightOfAppbar
            : heightOfAppbarTablet,
        title: 'Thông Tin Thanh Toán',
        leadingIcon: Icons.arrow_back,
        leadingIconClick: () {
          Navigator.pop(context);
        },
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
            horizontal: Responsive.isMobile(context) ? 16 : 32,
            vertical: Responsive.isMobile(context) ? 10 : 20),
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: paymentInfoFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleWidget(
                title: 'Địa chỉ nhận hàng:',
                textStyle: textStyleTitle,
              ),
              Container(
                margin: EdgeInsets.only(
                    top: Responsive.isMobile(context) ? 16 : 32,
                    bottom: Responsive.isMobile(context) ? 16 : 32),
                padding: EdgeInsets.all(Responsive.isMobile(context) ? 10 : 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    regionsCity.isEmpty
                        ? const SizedBox()
                        : DropdownWidget(
                            title: 'Tỉnh/Thành Phố',
                            items: regionsCity,
                            currentValue: selectedCity,
                            onChanged: (val) {
                              setState(() {
                                selectedCity = val;
                              });
                              fetchRegionsDistrict(selectedCity.regionID).then((_) {
                                fetchRegionsWard(selectedDistrict.regionID);
                              });
                            },
                          ),
                    regionsDistrict.isEmpty
                        ? const SizedBox()
                        : DropdownWidget(
                      title: 'Quận/Huyện',
                      items: regionsDistrict,
                      currentValue: selectedDistrict,
                      onChanged: (val) {
                        setState(() {
                          selectedDistrict = val;
                        });
                        fetchRegionsWard(val.regionID);
                      },
                    ),
                    regionsWard.isEmpty
                        ? const SizedBox()
                        : DropdownWidget(
                      title: 'Phường/Xã',
                      items: regionsWard,
                      currentValue: selectedWard,
                      onChanged: (val) {
                        setState(() {
                          selectedWard = val;
                        });
                      },
                    ),
                    PaymentInfoInput(
                      title: 'Địa Chỉ',
                      controller: addressTextController,
                      textInputAction: TextInputAction.next,
                    ),
                    PaymentInfoInput(
                      title: 'Số điện thoại',
                      controller: phoneTextController,
                      textInputType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                    ),
                  ],
                ),
              ),
              TitleWidget(
                title: 'Phương thức vận chuyển:',
                textStyle: textStyleTitle,
              ),
              TransportMethodForm(
                transportList: transportMethod,
                textStyle: textStyleTitle1,
                passTransportMethod: passTransportMethod,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: primaryColor,
                      padding: EdgeInsets.all(
                          Responsive.isMobile(context) ? 8 : 16)),
                  onPressed: () {
                    updatePaymentInfo();
                  },
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
        ),
      ),
    );
  }
}

class PaymentInfoInput extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final TextInputAction? textInputAction;
  final TextInputType textInputType;

  const PaymentInfoInput({
    Key? key,
    required this.title,
    required this.controller,
    this.textInputAction = TextInputAction.next,
    this.textInputType = TextInputType.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(
      fontSize: Responsive.isMobile(context) ? 15 : 15 * 1.5,
      fontFamily: 'MyriadProRegular',
      fontWeight: FontWeight.w400,
      letterSpacing: 1,
    );

    TextStyle textStyle1 = TextStyle(
      fontSize: Responsive.isMobile(context) ? 15 : 15 * 1.5,
      fontFamily: 'MyriadProRegular',
      letterSpacing: 1,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: textStyle,
        ),
        TextFormField(
          controller: controller,
          cursorColor: primaryColor,
          style: textStyle1,
          decoration: InputDecoration(
            hintText: title,
            hintStyle: textStyle1,
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: primaryColor),
            ),
          ),
          textInputAction: textInputAction,
          keyboardType: textInputType,
          validator: (val) {
            if (val!.isEmpty) {
              return '$title không được bỏ trống';
            }
            return null;
          },
        ),
        SizedBox(
          height: Responsive.isMobile(context) ? 10 : 20,
        ),
      ],
    );
  }
}

class TitleWidget extends StatelessWidget {
  final String title;
  final TextStyle textStyle;

  const TitleWidget({
    Key? key,
    required this.textStyle,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: textStyle,
    );
  }
}

class TransportMethodForm extends StatefulWidget {
  final List<Map<String, dynamic>> transportList;
  final TextStyle textStyle;
  final Function passTransportMethod;

  const TransportMethodForm({
    Key? key,
    required this.transportList,
    required this.textStyle,
    required this.passTransportMethod,
  }) : super(key: key);

  @override
  State<TransportMethodForm> createState() => _TransportMethodFormState();
}

class _TransportMethodFormState extends State<TransportMethodForm> {
  int currentValueRadio = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          top: Responsive.isMobile(context) ? 16 : 32,
          bottom: Responsive.isMobile(context) ? 16 : 32),
      padding: EdgeInsets.all(Responsive.isMobile(context) ? 10 : 20),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          widget.transportList.length,
          (index) => ListTile(
            minLeadingWidth: 0,
            contentPadding: EdgeInsets.zero,
            title: Text(
              widget.transportList[index]['name'],
              style: widget.textStyle,
            ),
            leading: Radio<int>(
              activeColor: primaryColor,
              value: widget.transportList[index]['value'],
              groupValue: currentValueRadio,
              onChanged: (value) {
                setState(() {
                  currentValueRadio = value!.toInt();
                });
                widget.passTransportMethod(currentValueRadio);
              },
            ),
          ),
        ),
      ),
    );
  }
}

class DropdownWidget extends StatelessWidget {
  final String title;
  final List<RegionModel> items;
  final Function onChanged;
  final RegionModel currentValue;

  const DropdownWidget({
    Key? key,
    required this.title,
    required this.items,
    required this.onChanged,
    required this.currentValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(
      fontSize: Responsive.isMobile(context) ? 15 : 15 * 1.5,
      fontFamily: 'MyriadProRegular',
      fontWeight: FontWeight.w400,
      letterSpacing: 1,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: textStyle,
        ),
        DropdownButtonHideUnderline(
          child: DropdownButton2(
            isExpanded: true,
            hint: Text(
              title,
              style: TextStyle(
                fontSize: Responsive.isMobile(context) ? 15 : 15 * 1.5,
                fontFamily: 'MyriadProRegular',
                fontWeight: FontWeight.w400,
                letterSpacing: 1,
              ),
            ),
            items: items
                .map((item) => DropdownMenuItem<RegionModel>(
                      value: item,
                      child: Text(
                        item.regionyName,
                        style: textStyle,
                      ),
                    ))
                .toList(),
            value: currentValue,
            onChanged: (value) {
              onChanged(value);
            },
            dropdownMaxHeight: 200,
          ),
        ),
        SizedBox(
          height: Responsive.isMobile(context) ? 10 : 20,
        ),
      ],
    );
  }
}
