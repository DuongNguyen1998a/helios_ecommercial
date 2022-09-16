import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

/// Base Widgets
import '../../base_widgets/my_app_bar.dart';

/// Blocs
import '../../blocs/product_bloc/product_bloc.dart';

/// Colors
import '../../colors/app_colors.dart';

/// Models
import '../../models/sub_category.dart';
import '../../models/product.dart';

/// Routes
import '../../routes/app_routes.dart';

/// functions
import '../../utils/functions.dart';

/// Responsive
import '../../utils/responsive.dart';

class ProductPage extends StatefulWidget {
  final SubCategory subCategory;

  const ProductPage({
    Key? key,
    required this.subCategory,
  }) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  double heightOfAppbar = AppBar().preferredSize.height;
  double heightOfAppbarTablet = AppBar().preferredSize.height * 1.45;

  @override
  void initState() {
    context.read<ProductBloc>().add(
          FetchProducts(
            productTypeId: widget.subCategory.productTypeID,
          ),
        );
    super.initState();
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
      body: BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
        if (state is ProductLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is ProductLoadedSuccess) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NumberOfProducts(
                categoryName: widget.subCategory.productTypeName,
                numbOfProducts: state.products.length.toString(),
              ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    context.read<ProductBloc>().add(
                          FetchProducts(
                            productTypeId: widget.subCategory.productTypeID,
                          ),
                        );
                  },
                  child: ProductList(
                    products: state.products,
                    onItemClick: (Product product) {
                      final args = {
                        'productId': product.productID,
                        'productPrice': product.pricev.toInt(),
                        'rating': product.prorating.toInt(),
                        'brandId': product.brandID,
                      };
                      Navigator.pushNamed(
                        context,
                        AppRoutes.productDetail,
                        arguments: args,
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        } else {
          return const SizedBox();
        }
      }),
    );
  }
}

class NumberOfProducts extends StatelessWidget {
  final String categoryName;
  final String numbOfProducts;

  const NumberOfProducts({
    Key? key,
    required this.categoryName,
    required this.numbOfProducts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: Responsive.isMobile(context) ? 10 : 20),
      width: double.infinity,
      padding: EdgeInsets.all(
        Responsive.isMobile(context) ? 10 : 20,
      ),
      color: Colors.grey.shade300,
      child: Text(
        '$categoryName ($numbOfProducts sản phẩm)',
        style: TextStyle(
          fontSize: Responsive.isMobile(context) ? 12 : 12 * 1.5,
          fontFamily: 'MyriadProRegular',
          color: Colors.black,
          fontWeight: FontWeight.bold,
          letterSpacing: 1,
        ),
      ),
    );
  }
}

class ProductList extends StatelessWidget {
  final List<Product> products;
  final Function onItemClick;

  const ProductList({
    Key? key,
    required this.products,
    required this.onItemClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) => InkWell(
        onTap: () {
          onItemClick(products[index]);
        },
        child: Container(
          padding: EdgeInsets.all(Responsive.isMobile(context) ? 10 : 20),
          margin: EdgeInsets.symmetric(
              horizontal: Responsive.isMobile(context) ? 20 : 40,
              vertical: Responsive.isMobile(context) ? 10 : 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: Responsive.isMobile(context) ? 96 : 96 * 2,
                margin: EdgeInsets.only(
                    bottom: Responsive.isMobile(context) ? 10 : 20),
                padding: EdgeInsets.all(Responsive.isMobile(context) ? 8 : 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: primaryColor,
                ),
                child: products[index].prorating == 0
                    ? Row(
                        children: List.generate(
                          5,
                          (index) => Icon(
                            Icons.star_outline,
                            color: Colors.white,
                            size: Responsive.isMobile(context) ? 16 : 32,
                          ),
                        ),
                      )
                    : Row(
                        children: List.generate(
                          products[index].prorating.toInt(),
                          (index) => Icon(
                            Icons.star,
                            color: Colors.white,
                            size: Responsive.isMobile(context) ? 16 : 32,
                          ),
                        ),
                      ),
              ),
              Row(
                children: [
                  products[index].imagePath == ''
                      ? Container(
                          alignment: Alignment.center,
                          width: Responsive.isMobile(context) ? 100 : 200,
                          height: Responsive.isMobile(context) ? 100 : 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color(0xFFF2F2F2),
                          ),
                          child: Text(
                            'No Image',
                            style: TextStyle(
                              fontSize: Responsive.isMobile(context) ? 15 : 30,
                              fontFamily: 'MyriadProRegular',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                      : SizedBox(
                          width: Responsive.isMobile(context) ? 100 : 200,
                          height: Responsive.isMobile(context) ? 100 : 200,
                          child: CachedNetworkImage(
                            imageUrl: products[index].imagePath,
                            imageBuilder: (context, imageProvider) => Container(
                              margin: EdgeInsets.only(
                                bottom: Responsive.isMobile(context) ? 5 : 10,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey.shade300,
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            placeholder: (context, url) => Shimmer(
                              direction: const ShimmerDirection.fromLTRB(),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.grey.shade300,
                                ),
                              ),
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                  SizedBox(
                    width: Responsive.isMobile(context) ? 10 : 20,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          products[index].productName,
                          style: TextStyle(
                            fontSize: Responsive.isMobile(context) ? 15 : 30,
                            fontFamily: 'MyriadProRegular',
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(
                          height: Responsive.isMobile(context) ? 10 : 20,
                        ),
                        Text(
                          'Hãng sản xuất: ${products[index].brandName}',
                          style: TextStyle(
                            fontSize: Responsive.isMobile(context) ? 13 : 24,
                            color: Colors.grey,
                            fontFamily: 'MyriadProRegular',
                          ),
                          maxLines: 2,
                        ),
                        SizedBox(
                          height: Responsive.isMobile(context) ? 10 : 20,
                        ),
                        Text(
                          '${Functions.formatCurrency(products[index].pricev)} đ',
                          style: TextStyle(
                            fontSize: Responsive.isMobile(context) ? 15 : 30,
                            fontFamily: 'MyriadProRegular',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
