import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helios_ecommercial/models/add_cart_model.dart';
import 'package:simple_html_css/simple_html_css.dart';

/// Base Widgets
import '../../base_widgets/my_app_bar.dart';

import '../../blocs/cart_bloc/cart_bloc.dart';
import '../../blocs/favorite_bloc/favorite_bloc.dart';

/// Blocs
import '../../blocs/product_detail_bloc/product_detail_bloc.dart';

/// Colors
import '../../colors/app_colors.dart';

/// Models
import '../../models/product_detail.dart';

import '../../routes/app_routes.dart';

/// Functions
import '../../utils/functions.dart';

/// Responsive
import '../../utils/responsive.dart';

/// Widgets
import 'widgets/slider_image_product_detail.dart';

class ProductDetailPage extends StatefulWidget {
  final int productId;
  final int productPrice;
  final int rating;
  final int brandId;

  const ProductDetailPage({
    Key? key,
    required this.productId,
    required this.productPrice,
    required this.rating,
    required this.brandId,
  }) : super(key: key);

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  double heightOfAppbar = AppBar().preferredSize.height;
  double heightOfAppbarTablet = AppBar().preferredSize.height * 1.45;

  @override
  void initState() {
    fetchProductDetail();
    super.initState();
  }

  Future<void> fetchProductDetail() async {
    context.read<ProductDetailBloc>().add(
          FetchProductDetail(productId: widget.productId),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        height: Responsive.isMobile(context)
            ? heightOfAppbar
            : heightOfAppbarTablet,
        title: 'Helios',
        leadingIcon: Icons.arrow_back,
        leadingIconClick: () {
          Navigator.pop(context);
        },
      ),
      body: BlocBuilder<ProductDetailBloc, ProductDetailState>(
        builder: (context, state) {
          if (state is ProductDetailLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ProductDetailLoadedSuccess) {
            List<ProductImage> lstImage = [];
            int commentNumber = 0;
            List<Area> lstRegion = [];
            List<ProductSpec> lstSpec = [];
            List<String> lstSpecName = [];
            List<dynamic> informationTech = [];
            List<ProductRatingModel> lstRating = [];
            List<Production> lstProduction = [];
            int price = 0;

            if (state.productDetail.informationTech != '') {
              informationTech =
                  json.decode(state.productDetail.informationTech) as List;
            }

            if (state.productDetail.lstData.isNotEmpty) {
              state.productDetail.lstData.map((e) {
                if (e.strTitle == 'Area') {
                  if (e.dtData.isNotEmpty) {
                    lstRegion =
                        e.dtData.map((area) => Area.fromJson(area)).toList();
                  }
                }
                if (e.strTitle == 'ProductImage') {
                  if (e.dtData.isNotEmpty) {
                    lstImage = e.dtData
                        .map((image) => ProductImage.fromJson(image))
                        .toList();
                  }
                }
                if (e.strTitle == 'ProductRaiting') {
                  if (e.dtData.isNotEmpty) {
                    commentNumber = (e.dtData).length;
                  }
                }
                if (e.strTyle == 'Spec') {
                  lstSpecName.add(e.strTitle);
                  if (e.dtData.isNotEmpty) {
                    e.dtData.map((spec) {
                      ProductSpec productSpec = ProductSpec(
                        title: e.strTitle,
                        specId: spec['specID'],
                        specCode: spec['specCode'],
                        specName: spec['specName'],
                        ordSpec: spec['ordSpec'],
                      );
                      lstSpec.add(productSpec);
                    }).toList();
                  }
                }
                if (e.strTitle == 'Production') {
                  if (e.dtData.isNotEmpty) {
                    lstProduction = e.dtData
                        .map((production) => Production.fromJson(production))
                        .toList();
                  }
                }
              }).toList();
            }

            if (lstProduction.isNotEmpty) {
              Production prod = lstProduction.firstWhere(
                  (e) =>
                      e.areaID == state.currentAreaId &&
                      e.spec1 == state.specId1 &&
                      e.spec2 == state.specId2 &&
                      e.spec3 == state.specId3 &&
                      e.spec4 == state.specId4 &&
                      e.spec5 == state.specId5,
                  orElse: () => const Production(
                        productionID: 0,
                        areaID: 0,
                        brandID: 0,
                        spec1: 0,
                        spec2: 0,
                        spec3: 0,
                        spec4: 0,
                        spec5: 0,
                        price: 0,
                      ));

              price = prod.price;
            }

            void addToCart() {
              Functions.checkLoggedIn().then((value) {
                if (value) {
                  int userId = 0;
                  List<AddCartModel> carts = [];

                  Functions.getUserId().then((value) => userId = value);

                  carts.add(
                    AddCartModel(
                      productionID: widget.productId.toString(),
                      quantity: state.currentQty.toString(),
                      vPrice: price.toString(),
                      pricev: price.toString(),
                      vAT: '10',
                      amountDiscount: '0',
                      vAmount: '0',
                      amountv: '0',
                      description: '',
                      userCreate: userId.toString(),
                      dateCreate: Functions.formatYYYYMMDD(
                        DateTime.now(),
                      ),
                      userUpdate: userId.toString(),
                      dateUpdate: Functions.formatYYYYMMDD(
                        DateTime.now(),
                      ),
                    ),
                  );

                  context
                      .read<ProductDetailBloc>()
                      .add(AddToCart(carts: carts));

                  Future.delayed(const Duration(seconds: 1)).then((_) {
                    final snackBar = SnackBar(
                      content: Text(
                        'Thêm giỏ hàng thành công',
                        style: TextStyle(
                          fontSize:
                              Responsive.isMobile(context) ? 15 : 15 * 1.5,
                          fontFamily: 'MyriadProRegular',
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                    );

                    ScaffoldMessenger.of(context).showSnackBar(snackBar);

                    context.read<CartBloc>().add(const FetchCarts());
                  });
                } else {
                  Navigator.pushNamed(context, AppRoutes.auth);
                }
              });
            }

            void favProduct() {
              Functions.checkLoggedIn().then((value) {
                if (value) {
                  context.read<ProductDetailBloc>().add(FavoriteProduct(
                        productId: widget.productId,
                        brandId: widget.brandId,
                      ));

                  Future.delayed(const Duration(seconds: 1)).then((_) {
                    context.read<FavoriteBloc>().add(const FetchFavProducts());
                  });
                } else {
                  Navigator.pushNamed(context, AppRoutes.auth);
                }
              });
            }

            return state.productDetail.lstData.isEmpty
                ? Center(
                    child: Text(
                      'Chưa có thông tin chi tiết sản phẩm',
                      style: TextStyle(
                        fontSize: Responsive.isMobile(context) ? 16 : 32,
                        fontFamily: 'MyriadProRegular',
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                  )
                : SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SliderImageProductDetail(
                          listImage: lstImage,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: Responsive.isMobile(context) ? 20 : 40,
                            vertical: Responsive.isMobile(context) ? 10 : 20,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  ProductRatingWidget(
                                    rating: widget.rating,
                                    commentNumber: commentNumber,
                                  ),
                                  const Spacer(),
                                  ProductFavButton(
                                    isFav: state.isFav,
                                    onClick: () {
                                      favProduct();
                                    },
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      addToCart();
                                    },
                                    icon: Icon(
                                      Icons.shopping_cart,
                                      color: Colors.grey,
                                      size: Responsive.isMobile(context)
                                          ? 24
                                          : 24 * 1.5,
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 5, bottom: 16),
                                child: Text(
                                  state.productDetail.productName,
                                  style: TextStyle(
                                    fontSize: Responsive.isMobile(context)
                                        ? 16
                                        : 16 * 1.5,
                                    fontFamily: 'MyriadProRegular',
                                  ),
                                  maxLines: 2,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${Functions.formatCurrency(price)} đ',
                                    style: TextStyle(
                                      fontSize: Responsive.isMobile(context)
                                          ? 22
                                          : 22 * 1.5,
                                      fontFamily: 'MyriadProRegular',
                                      color: Colors.red,
                                    ),
                                  ),
                                  const ProductQtyWidget(),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                'Khu vực :',
                                style: TextStyle(
                                  fontSize: Responsive.isMobile(context)
                                      ? 16
                                      : 16 * 1.5,
                                  fontFamily: 'MyriadProRegular',
                                ),
                              ),
                              SizedBox(
                                height: Responsive.isMobile(context) ? 5 : 10,
                              ),
                              ProductRegionWidget(
                                lstRegion: lstRegion,
                              ),
                              const Divider(color: Colors.grey,),
                              // const SizedBox(
                              //   height: 10,
                              // ),
                              Text(
                                'Thông số :',
                                style: TextStyle(
                                  fontSize: Responsive.isMobile(context)
                                      ? 16
                                      : 16 * 1.5,
                                  fontFamily: 'MyriadProRegular',
                                ),
                              ),
                              // SizedBox(
                              //   height: Responsive.isMobile(context) ? 5 : 10,
                              // ),
                              ProductSpecWidget(
                                lstDetails: lstSpec,
                                lstSpecName: lstSpecName,
                              ),
                              SizedBox(
                                height: Responsive.isMobile(context) ? 10 : 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      primary: primaryColor,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: Responsive.isMobile(context)
                                            ? 16
                                            : 16 * 1.5,
                                        vertical: Responsive.isMobile(context)
                                            ? 10
                                            : 10 * 1.5,
                                      ),
                                    ),
                                    child: Text(
                                      'Mua ngay',
                                      style: TextStyle(
                                        fontSize: Responsive.isMobile(context)
                                            ? 16
                                            : 16 * 1.5,
                                        fontFamily: 'MyriadProRegular',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: Responsive.isMobile(context) ? 10 : 20,
                              ),
                              const Divider(
                                color: Colors.grey,
                              ),
                              SizedBox(
                                height: Responsive.isMobile(context) ? 5 : 10,
                              ),
                              Text(
                                'Thông số chi tiết :',
                                style: TextStyle(
                                  fontSize: Responsive.isMobile(context)
                                      ? 18
                                      : 18 * 1.5,
                                  fontFamily: 'MyriadProRegular',
                                ),
                              ),
                              SizedBox(
                                height: Responsive.isMobile(context) ? 5 : 10,
                              ),
                              state.productDetail.description == ''
                                  ? Text(
                                      'Chưa có thông số chi tiết',
                                      style: TextStyle(
                                        fontSize: Responsive.isMobile(context)
                                            ? 15
                                            : 15 * 1.5,
                                        fontFamily: 'MyriadProRegular',
                                      ),
                                    )
                                  : Builder(
                                      builder: (context) {
                                        return RichText(
                                          text: HTML.toTextSpan(
                                            context,
                                            state.productDetail.description,
                                            defaultTextStyle: TextStyle(
                                              fontSize:
                                                  Responsive.isMobile(context)
                                                      ? 15
                                                      : 15 * 1.5,
                                              fontFamily: 'MyriadProRegular',
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                              SizedBox(
                                height: Responsive.isMobile(context) ? 10 : 20,
                              ),
                              informationTech.isNotEmpty
                                  ? TableInformation(
                                      dynamicList: informationTech,
                                    )
                                  : const SizedBox(),
                              SizedBox(
                                height: Responsive.isMobile(context) ? 5 : 10,
                              ),
                              const Divider(
                                color: Colors.grey,
                              ),
                              SizedBox(
                                height: Responsive.isMobile(context) ? 10 : 20,
                              ),
                              Text(
                                'Đánh giá & xếp hạng sản phẩm:',
                                style: TextStyle(
                                  fontSize: Responsive.isMobile(context)
                                      ? 18
                                      : 18 * 1.5,
                                  fontFamily: 'MyriadPro',
                                  letterSpacing: 0.5,
                                ),
                              ),
                              SizedBox(
                                height: Responsive.isMobile(context) ? 10 : 20,
                              ),
                              ProductRatingAvg(
                                rating: widget.rating,
                                lstRating: lstRating,
                              ),
                              SizedBox(
                                height: Responsive.isMobile(context) ? 5 : 10,
                              ),
                              const Divider(
                                color: Colors.grey,
                              ),
                              SizedBox(
                                height: Responsive.isMobile(context) ? 10 : 20,
                              ),
                              ProductComments(
                                lstRating: lstRating,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}

class ProductRatingWidget extends StatelessWidget {
  final int rating;
  final int commentNumber;

  const ProductRatingWidget({
    Key? key,
    required this.rating,
    required this.commentNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          children: List.generate(
            rating.toInt() == 0 ? 5 : rating.toInt(),
            (index) => Icon(
              rating == 0 ? Icons.star_outline : Icons.star,
              color: Colors.orangeAccent,
              size: Responsive.isMobile(context) ? 24 : 24 * 1.5,
            ),
          ),
        ),
        SizedBox(
          width: Responsive.isMobile(context) ? 10 : 20,
        ),
        Text(
          '($commentNumber đánh giá)',
          style: TextStyle(
            fontFamily: 'MyriadProRegular',
            fontSize: Responsive.isMobile(context) ? 15 : 15 * 1.5,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}

class ProductFavButton extends StatelessWidget {
  final bool isFav;
  final Function onClick;

  const ProductFavButton({
    Key? key,
    required this.isFav,
    required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        onClick();
      },
      icon: Icon(
        isFav ? Icons.favorite : Icons.favorite_outline,
        color: isFav ? Colors.red : Colors.grey,
        size: Responsive.isMobile(context) ? 24 : 24 * 1.5,
      ),
    );
  }
}

class ProductQtyWidget extends StatelessWidget {
  const ProductQtyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void increaseQty() {
      context.read<ProductDetailBloc>().add(IncreaseQty());
    }

    void decreaseQty() {
      context.read<ProductDetailBloc>().add(DecreaseQty());
    }

    return Row(
      children: [
        InkWell(
          onTap: () {
            decreaseQty();
          },
          child: Container(
            height: Responsive.isMobile(context) ? 35 : 70,
            width: Responsive.isMobile(context) ? 35 : 70,
            decoration: BoxDecoration(
              border: Border.all(
                color: primaryColor,
              ),
            ),
            padding: const EdgeInsets.all(5),
            child: Icon(Icons.remove,
                color: primaryColor,
                size: Responsive.isMobile(context) ? 24 : 24 * 1.5),
          ),
        ),
        Container(
          height: Responsive.isMobile(context) ? 35 : 70,
          width: Responsive.isMobile(context) ? 35 : 70,
          decoration: BoxDecoration(
            border: Border.all(
              color: primaryColor,
            ),
          ),
          padding: const EdgeInsets.all(5),
          child: Center(
            child: BlocBuilder<ProductDetailBloc, ProductDetailState>(
              builder: (context, state) {
                if (state is ProductDetailLoadedSuccess) {
                  return Text(
                    state.currentQty.toString(),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: Responsive.isMobile(context) ? 16 : 16 * 1.5,
                    ),
                  );
                } else {
                  return Text(
                    1.toString(),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: Responsive.isMobile(context) ? 16 : 16 * 1.5,
                    ),
                  );
                }
              },
            ),
          ),
        ),
        InkWell(
          onTap: () {
            increaseQty();
          },
          child: Container(
            width: Responsive.isMobile(context) ? 35 : 70,
            height: Responsive.isMobile(context) ? 35 : 70,
            decoration: BoxDecoration(
              border: Border.all(
                color: primaryColor,
              ),
            ),
            padding: const EdgeInsets.all(5),
            child: Icon(Icons.add,
                color: primaryColor,
                size: Responsive.isMobile(context) ? 24 : 24 * 1.5),
          ),
        ),
      ],
    );
  }
}

class ProductSpecWidget extends StatefulWidget {
  final List<ProductSpec> lstDetails;
  final List<String> lstSpecName;

  const ProductSpecWidget({
    Key? key,
    required this.lstDetails,
    required this.lstSpecName,
  }) : super(key: key);

  @override
  State<ProductSpecWidget> createState() => _ProductSpecState();
}

class _ProductSpecState extends State<ProductSpecWidget> {
  int currentIndexSpec1 = 0;
  int currentIndexSpec2 = 0;
  int currentIndexSpec3 = 0;
  int currentIndexSpec4 = 0;
  int currentIndexSpec5 = 0;

  List<List<ProductSpec>> lstProductSpec = [];

  @override
  void initState() {
    handleData();
    super.initState();
  }

  void handleData() {
    for (int i = 0; i < widget.lstSpecName.length; i++) {
      setState(() {
        lstProductSpec.add(
          widget.lstDetails
              .where((element) => element.title == widget.lstSpecName[i])
              .toList(),
        );
      });
    }

    if (lstProductSpec.isNotEmpty && widget.lstSpecName.isNotEmpty) {
      if (widget.lstSpecName.length == 5) {
        context.read<ProductDetailBloc>().add(GetCurrentSpecId(
              specId1: lstProductSpec[0][0].specId,
              specId2: lstProductSpec[1][0].specId,
              specId3: lstProductSpec[2][0].specId,
              specId4: lstProductSpec[3][0].specId,
              specId5: lstProductSpec[4][0].specId,
            ));
      } else if (widget.lstSpecName.length == 4) {
        context.read<ProductDetailBloc>().add(GetCurrentSpecId(
              specId1: lstProductSpec[0][0].specId,
              specId2: lstProductSpec[1][0].specId,
              specId3: lstProductSpec[2][0].specId,
              specId4: lstProductSpec[3][0].specId,
            ));
      } else if (widget.lstSpecName.length == 3) {
        context.read<ProductDetailBloc>().add(GetCurrentSpecId(
              specId1: lstProductSpec[0][0].specId,
              specId2: lstProductSpec[1][0].specId,
              specId3: lstProductSpec[2][0].specId,
            ));
      } else if (widget.lstSpecName.length == 2) {
        context.read<ProductDetailBloc>().add(GetCurrentSpecId(
              specId1: lstProductSpec[0][0].specId,
              specId2: lstProductSpec[1][0].specId,
            ));
      } else if (widget.lstSpecName.length == 1) {
        context.read<ProductDetailBloc>().add(GetCurrentSpecId(
              specId1: lstProductSpec[0][0].specId,
            ));
      }
    }
  }

  int getCurrentIndexSpec(int index) {
    if (index == 0) {
      return currentIndexSpec1;
    } else if (index == 1) {
      return currentIndexSpec2;
    } else if (index == 2) {
      return currentIndexSpec3;
    } else if (index == 3) {
      return currentIndexSpec4;
    } else if (index == 4) {
      return currentIndexSpec5;
    } else {
      return -1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(
        widget.lstSpecName.length,
        (index) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                '- ${widget.lstSpecName[index]}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'MyriadProRegular',
                  fontSize: Responsive.isMobile(context) ? 14 : 28,
                ),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: BlocBuilder<ProductDetailBloc, ProductDetailState>(
                  builder: (context, state) {
                if (state is ProductDetailLoadedSuccess) {
                  return Row(
                    children: List.generate(
                      lstProductSpec[index].length,
                      (index1) => InkWell(
                        onTap: () {
                          setState(() {
                            if (index == 0) {
                              currentIndexSpec1 = index1;
                              context
                                  .read<ProductDetailBloc>()
                                  .add(GetCurrentSpecId(
                                    specId1:
                                        lstProductSpec[index][index1].specId,
                                    specId2: state.specId2,
                                    specId3: state.specId3,
                                    specId4: state.specId4,
                                    specId5: state.specId5,
                                  ));
                            }
                            if (index == 1) {
                              currentIndexSpec2 = index1;
                              context
                                  .read<ProductDetailBloc>()
                                  .add(GetCurrentSpecId(
                                    specId1: state.specId1,
                                    specId2:
                                        lstProductSpec[index][index1].specId,
                                    specId3: state.specId3,
                                    specId4: state.specId4,
                                    specId5: state.specId5,
                                  ));
                            }
                            if (index == 2) {
                              currentIndexSpec3 = index1;
                              context
                                  .read<ProductDetailBloc>()
                                  .add(GetCurrentSpecId(
                                    specId1: state.specId1,
                                    specId2: state.specId2,
                                    specId3:
                                        lstProductSpec[index][index1].specId,
                                    specId4: state.specId4,
                                    specId5: state.specId5,
                                  ));
                            }
                            if (index == 3) {
                              currentIndexSpec4 = index1;
                              context
                                  .read<ProductDetailBloc>()
                                  .add(GetCurrentSpecId(
                                    specId1: state.specId1,
                                    specId2: state.specId2,
                                    specId3: state.specId3,
                                    specId4:
                                        lstProductSpec[index][index1].specId,
                                    specId5: state.specId5,
                                  ));
                            }
                            if (index == 4) {
                              currentIndexSpec5 = index1;
                              context
                                  .read<ProductDetailBloc>()
                                  .add(GetCurrentSpecId(
                                    specId1: state.specId1,
                                    specId2: state.specId2,
                                    specId3: state.specId3,
                                    specId4: state.specId4,
                                    specId5:
                                        lstProductSpec[index][index1].specId,
                                  ));
                            }
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: Responsive.isMobile(context) ? 10 : 20,
                            vertical: Responsive.isMobile(context) ? 8 : 16,
                          ),
                          margin: EdgeInsets.all(
                            Responsive.isMobile(context) ? 4 : 8,
                          ),
                          decoration: getCurrentIndexSpec(index) == index1
                              ? BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: getCurrentIndexSpec(index) == index1
                                      ? primaryColor
                                      : null,
                                )
                              : BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: primaryColor,
                                  ),
                                ),
                          child: Text(
                            lstProductSpec[index][index1].specName,
                            style: TextStyle(
                              color: getCurrentIndexSpec(index) == index1
                                  ? Colors.white
                                  : Colors.black,
                              fontSize: Responsive.isMobile(context) ? 14 : 28,
                              fontFamily: 'MyriadProRegular',
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                } else {
                  return const SizedBox();
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class TableInformation extends StatelessWidget {
  final List<dynamic> dynamicList;

  const TableInformation({
    Key? key,
    required this.dynamicList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(color: Colors.black, width: 1),
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: List.generate(
        dynamicList.length,
        (index) => TableRow(
          children: [
            Padding(
              padding: EdgeInsets.all(Responsive.isMobile(context) ? 8 : 16),
              child: Text(
                dynamicList[index]['key'],
                style: TextStyle(
                  fontSize: Responsive.isMobile(context) ? 16 : 16 * 1.5,
                  fontFamily: 'MyriadPro',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(Responsive.isMobile(context) ? 8 : 16),
              child: Text(
                dynamicList[index]['value'],
                style: TextStyle(
                  fontSize: Responsive.isMobile(context) ? 16 : 16 * 1.5,
                  fontFamily: 'MyriadPro',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductRatingAvg extends StatelessWidget {
  final int rating;
  final List<ProductRatingModel> lstRating;

  const ProductRatingAvg({
    Key? key,
    required this.rating,
    required this.lstRating,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double calculateAvgRating(int ratingValue) {
      int count = 0;
      if (lstRating.isNotEmpty) {
        lstRating.map((e) {
          if (e.rating == ratingValue) {
            count += 1;
          }
        }).toList();
        if (count == 0) {
          return 0;
        } else {
          return 1 / count;
        }
      } else {
        return 0;
      }
    }

    return Row(
      children: [
        Row(
          children: [
            Icon(
              Icons.star,
              color: primaryColor,
              size: Responsive.isMobile(context) ? 50 : 100,
            ),
            SizedBox(
              height: Responsive.isMobile(context) ? 5 : 10,
            ),
            Text(
              rating.toDouble().toString(),
              style: TextStyle(
                fontSize: Responsive.isMobile(context) ? 30 : 30 * 1.5,
                fontFamily: 'MyriadPro',
                color: primaryColor,
              ),
            ),
          ],
        ),
        SizedBox(
          width: Responsive.isMobile(context) ? 10 : 20,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              5,
              (index) => Row(
                children: [
                  Text(
                    '${5 - (index)}',
                    style: TextStyle(
                        fontSize: Responsive.isMobile(context) ? 14 : 14 * 2,
                        fontFamily: 'MyriadProRegular'),
                  ),
                  SizedBox(
                    width: Responsive.isMobile(context) ? 10 : 20,
                  ),
                  Expanded(
                    child: SizedBox(
                      height: Responsive.isMobile(context) ? 8 : 16,
                      child: LinearProgressIndicator(
                        backgroundColor: Colors.grey,
                        valueColor:
                            const AlwaysStoppedAnimation<Color>(primaryColor),
                        value: calculateAvgRating(5 - index),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ProductComments extends StatelessWidget {
  final List<ProductRatingModel> lstRating;

  const ProductComments({
    Key? key,
    required this.lstRating,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return lstRating.isEmpty
        ? Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              'Chưa có đánh giá nào',
              style: TextStyle(
                fontFamily: 'MyriadProRegular',
                fontSize: Responsive.isMobile(context) ? 15 : 30,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
          )
        : SizedBox(
            height: Responsive.isMobile(context) ? 200 : 400,
            child: ListView.builder(
              itemCount: lstRating.length,
              itemBuilder: (context, index) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: List.generate(
                        lstRating[index].rating.toInt(),
                        (index) => Icon(
                          Icons.star,
                          color: primaryColor,
                          size: Responsive.isMobile(context) ? 24 : 24 * 1.5,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Responsive.isMobile(context) ? 5 : 10,
                    ),
                    Text(
                      lstRating[index].customerName,
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'MyriadProRegular',
                        fontSize: Responsive.isMobile(context) ? 15 : 15 * 1.5,
                      ),
                    ),
                    SizedBox(
                      height: Responsive.isMobile(context) ? 5 : 10,
                    ),
                    Text(
                      Functions.formatDDMMYYYY(
                        lstRating[index].dateUpdated,
                      ),
                      style: TextStyle(
                        color: Colors.grey,
                        fontFamily: 'MyriadProRegular',
                        fontSize: Responsive.isMobile(context) ? 15 : 15 * 1.5,
                      ),
                    ),
                    SizedBox(
                      height: Responsive.isMobile(context) ? 5 : 10,
                    ),
                    Text(
                      'Nội dung: ${lstRating[index].contentComment}',
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'MyriadProRegular',
                        fontSize: Responsive.isMobile(context) ? 15 : 15 * 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}

class ProductRegionWidget extends StatefulWidget {
  final List<Area> lstRegion;

  const ProductRegionWidget({
    Key? key,
    required this.lstRegion,
  }) : super(key: key);

  @override
  State<ProductRegionWidget> createState() => _ProductRegionWidgetState();
}

class _ProductRegionWidgetState extends State<ProductRegionWidget> {
  int currentValue = 1;

  @override
  void initState() {
    currentValue = widget.lstRegion[0].areaId;
    getCurrentAreaId();
    super.initState();
  }

  void getCurrentAreaId() {
    context
        .read<ProductDetailBloc>()
        .add(GetCurrentAreaId(currentAreaId: currentValue));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          widget.lstRegion.length,
          (index) => InkWell(
            onTap: () {
              setState(() {
                currentValue = widget.lstRegion[index].areaId;
              });
              getCurrentAreaId();
            },
            child: Container(
              margin:
                  EdgeInsets.only(right: Responsive.isMobile(context) ? 8 : 16),
              padding: EdgeInsets.all(Responsive.isMobile(context) ? 10 : 20),
              decoration: BoxDecoration(
                color: currentValue == widget.lstRegion[index].areaId
                    ? primaryColor
                    : Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: currentValue == widget.lstRegion[index].areaId
                      ? Colors.white
                      : primaryColor,
                ),
              ),
              child: Text(
                widget.lstRegion[index].areaName,
                style: TextStyle(
                  color: currentValue == widget.lstRegion[index].areaId
                      ? Colors.white
                      : Colors.black,
                  fontFamily: 'MyriadProRegular',
                  fontSize: Responsive.isMobile(context) ? 14 : 28,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
