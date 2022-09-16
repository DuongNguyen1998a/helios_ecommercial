import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helios_ecommercial/models/order_detail.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import '../../blocs/cart_bloc/cart_bloc.dart';

/// Colors
import '../../colors/app_colors.dart';

/// Routes
import '../../routes/app_routes.dart';

import '../../utils/functions.dart';

/// Responsive
import '../../utils/responsive.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle setTextStyle(double fontSize) {
      return TextStyle(
        fontFamily: 'MyriadProRegular',
        fontSize: fontSize,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
      );
    }

    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is CartLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is CartLoadedSuccess) {
          void createOrder() {
            List<OrderDetail> orderDetails = [];

            if (state.lstCarts[0].lstDetail.isNotEmpty) {
              state.lstCarts[0].lstDetail.map((detail) {
                if (detail.isChecked) {
                  OrderDetail item = OrderDetail(
                    productionID: detail.productionID.toString(),
                    quantityOrder: detail.quantity.toString(),
                    vPrice: detail.vPrice.toString(),
                    pricev: detail.pricev.toString(),
                    vAT: detail.vat.toString(),
                    amountDiscount: detail.amountDiscount.toString(),
                    vAmount: detail.vAmount.toString(),
                    amountv: detail.amountv.toString(),
                    description: detail.description,
                    userCreate: detail.userCreate.toString(),
                    dateCreate: detail.dateCreate,
                    userUpdate: detail.userUpdate.toString(),
                    dateUpdate: detail.dateUpdate,
                  );

                  orderDetails.add(item);
                }
              }).toList();
            }

            if (orderDetails.isNotEmpty && state.address != '') {
              context.read<CartBloc>().add(CreateOrder(
                    orderDetails: orderDetails,
                  ));

              Future.delayed(const Duration(seconds: 1)).then((_) {
                context.read<CartBloc>().add(const FetchCarts());
              });
            } else if (state.address == '') {
              final snackBar = SnackBar(
                content: Text(
                  'Vui lòng nhập thông tin thanh toán',
                  style: TextStyle(
                    fontSize: Responsive.isMobile(context) ? 15 : 15 * 1.5,
                    fontFamily: 'MyriadProRegular',
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
              );

              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            } else {
              final snackBar = SnackBar(
                content: Text(
                  'Vui lòng chọn sản phẩm để đặt hàng',
                  style: TextStyle(
                    fontSize: Responsive.isMobile(context) ? 15 : 15 * 1.5,
                    fontFamily: 'MyriadProRegular',
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
              );

              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          }

          return state.lstCarts.isEmpty
              ? Center(
                  child: Text(
                    'Không có sản phẩm nào trong giỏ hàng',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'MyriadProRegular',
                      letterSpacing: 1,
                      fontSize: Responsive.isMobile(context) ? 15 : 30,
                    ),
                  ),
                )
              : Container(
                  color: const Color(0xFFF2F2F2),
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: Responsive.isMobile(context) ? 20 : 40,
                      vertical: Responsive.isMobile(context) ? 10 : 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 6,),
                        Row(
                          children: [
                            Text(
                              'Giỏ hàng:',
                              style: TextStyle(
                                fontFamily: 'MyriadPro',
                                fontSize: Responsive.isMobile(context)
                                    ? 17
                                    : 17 * 1.5,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.5,
                              ),
                            ),
                            SizedBox(
                              width: Responsive.isMobile(context) ? 5 : 10,
                            ),
                            Text(
                              'Có ${state.lstCarts[0].lstDetail.length} sản phẩm.',
                              style: setTextStyle(
                                  Responsive.isMobile(context) ? 15 : 15 * 1.5),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: Responsive.isMobile(context) ? 16 : 32,
                        ),
                        SizedBox(
                          height: Responsive.isMobile(context) ? 300 : 600,
                          width: double.infinity,
                          child: RefreshIndicator(
                            onRefresh: () async {
                              context.read<CartBloc>().add(const FetchCarts());
                            },
                            child: ListView.builder(
                              itemCount: state.lstCartLength,
                              itemBuilder: (context, index) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Checkbox(
                                        checkColor: Colors.white,
                                        activeColor: primaryColor,
                                        value: state.lstCarts[0]
                                            .lstDetail[index].isChecked,
                                        onChanged: (val) {
                                          context.read<CartBloc>().add(
                                                SelectedProductInCart(
                                                  index: index,
                                                ),
                                              );
                                        },
                                      ),
                                    ),
                                    Expanded(
                                      flex: 15,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: SizedBox(
                                              width:
                                                  Responsive.isMobile(context)
                                                      ? 90
                                                      : 180,
                                              height:
                                                  Responsive.isMobile(context)
                                                      ? 90
                                                      : 180,
                                              child: state
                                                          .lstCarts[0]
                                                          .lstDetail[index]
                                                          .productImage ==
                                                      ''
                                                  ? Container(
                                                      alignment:
                                                          Alignment.center,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color: Colors
                                                            .grey.shade300,
                                                      ),
                                                      child: Text(
                                                        'No Image',
                                                        style: TextStyle(
                                                          fontSize: Responsive
                                                                  .isMobile(
                                                                      context)
                                                              ? 15
                                                              : 30,
                                                          fontFamily:
                                                              'MyriadProRegular',
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    )
                                                  : CachedNetworkImage(
                                                      imageUrl: state
                                                          .lstCarts[0]
                                                          .lstDetail[index]
                                                          .productImage,
                                                      imageBuilder: (context,
                                                              imageProvider) =>
                                                          Container(
                                                        margin: EdgeInsets.only(
                                                          bottom: Responsive
                                                                  .isMobile(
                                                                      context)
                                                              ? 5
                                                              : 10,
                                                        ),
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          color: Colors
                                                              .grey.shade300,
                                                          image:
                                                              DecorationImage(
                                                            image:
                                                                imageProvider,
                                                            fit: BoxFit.fill,
                                                          ),
                                                        ),
                                                      ),
                                                      placeholder:
                                                          (context, url) =>
                                                              Shimmer(
                                                        direction:
                                                            const ShimmerDirection
                                                                .fromLTRB(),
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                              10,
                                                            ),
                                                            color: Colors
                                                                .grey.shade300,
                                                          ),
                                                        ),
                                                      ),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          const Icon(
                                                              Icons.error),
                                                    ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  '${state.lstCarts[0].lstDetail[index].productName} (${state.lstCarts[0].lstDetail[index].quantity})',
                                                  style: TextStyle(
                                                    fontSize:
                                                        Responsive.isMobile(
                                                                context)
                                                            ? 15
                                                            : 30,
                                                    fontFamily:
                                                        'MyriadProRegular',
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                SizedBox(
                                                  height: Responsive.isMobile(
                                                          context)
                                                      ? 10
                                                      : 20,
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      '${Functions.formatCurrency(state.lstCarts[0].lstDetail[index].pricev)} đ',
                                                      style: TextStyle(
                                                        fontSize:
                                                            Responsive.isMobile(
                                                                    context)
                                                                ? 15
                                                                : 30,
                                                        fontFamily:
                                                            'MyriadProRegular',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Divider(
                          color: Colors.grey,
                          thickness: Responsive.isMobile(context) ? 4 : 8,
                        ),
                        ListTile(
                          onTap: () {
                            Navigator.pushNamed(context, AppRoutes.paymentInfo);
                          },
                          contentPadding: EdgeInsets.symmetric(
                              vertical: Responsive.isMobile(context) ? 0 : 14),
                          title: Text(
                            'Thông tin thanh toán',
                            style: setTextStyle(
                                Responsive.isMobile(context) ? 16 : 16 * 1.5),
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.black,
                            size: Responsive.isMobile(context) ? 16 : 16 * 1.5,
                          ),
                        ),
                        Divider(
                          color: primaryColor,
                          thickness: Responsive.isMobile(context) ? 1 : 2,
                        ),
                        ListTile(
                          onTap: () {
                            Navigator.pushNamed(
                                context, AppRoutes.contractInfo);
                          },
                          contentPadding: EdgeInsets.symmetric(
                              vertical: Responsive.isMobile(context) ? 0 : 14),
                          title: Text(
                            'Phân loại hợp đồng',
                            style: setTextStyle(
                                Responsive.isMobile(context) ? 16 : 16 * 1.5),
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.black,
                            size: Responsive.isMobile(context) ? 16 : 16 * 1.5,
                          ),
                        ),
                        Divider(
                          color: primaryColor,
                          thickness: Responsive.isMobile(context) ? 1 : 2,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 20, bottom: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Thuế (VAT):',
                                    style: setTextStyle(
                                        Responsive.isMobile(context)
                                            ? 16
                                            : 16 * 1.5),
                                  ),
                                  Text(
                                    '0 đ',
                                    style: setTextStyle(
                                      Responsive.isMobile(context)
                                          ? 16
                                          : 16 * 1.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 0, bottom: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Phí vận chuyển:',
                                    style: setTextStyle(
                                        Responsive.isMobile(context)
                                            ? 16
                                            : 16 * 1.5),
                                  ),
                                  Text(
                                    '${Functions.formatCurrency(state.lstCarts[0].amountDelivery)} đ',
                                    style: setTextStyle(
                                        Responsive.isMobile(context)
                                            ? 16
                                            : 16 * 1.5),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Divider(
                          color: primaryColor,
                          thickness: Responsive.isMobile(context) ? 1 : 2,
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: Responsive.isMobile(context) ? 0 : 14),
                          title: Text(
                            'Thành tiền',
                            style: setTextStyle(
                                Responsive.isMobile(context) ? 16 : 16 * 1.5),
                          ),
                          trailing: Text(
                            '${Functions.formatCurrency(state.lstCarts[0].vTotalAmount)} đ',
                            style: setTextStyle(
                                Responsive.isMobile(context) ? 16 : 16 * 1.5),
                          ),
                        ),
                        Divider(
                          color: Colors.grey,
                          thickness: Responsive.isMobile(context) ? 4 : 8,
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: Responsive.isMobile(context) ? 0 : 28),
                          title: Text(
                            'Tổng tiền',
                            style: setTextStyle(
                                Responsive.isMobile(context) ? 16 : 16 * 1.5),
                          ),
                          subtitle: Text(
                            '${Functions.formatCurrency(state.lstCarts[0].totalAmountv)} đ',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize:
                                  Responsive.isMobile(context) ? 18 : 18 * 1.5,
                              fontFamily: 'MyriadProRegular',
                            ),
                          ),
                          trailing: SizedBox(
                            width: Responsive.isMobile(context) ? 150 : 300,
                            height: Responsive.isMobile(context)
                                ? 40
                                : double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      Responsive.isMobile(context) ? 10 : 20),
                                ),
                              ),
                              onPressed: () {
                                createOrder();
                              },
                              child: Text(
                                'Đặt hàng',
                                style: TextStyle(
                                  fontFamily: 'MyriadProRegular',
                                  fontSize: Responsive.isMobile(context)
                                      ? 16
                                      : 16 * 1.5,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
