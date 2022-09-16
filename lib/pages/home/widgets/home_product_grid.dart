import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

/// Blocs
import '../../../blocs/home_bloc/home_bloc.dart';

/// Models
import '../../../models/home_product.dart';

/// Routes
import '../../../routes/app_routes.dart';

/// Responsive
import '../../../utils/responsive.dart';

class HomeProductGrid extends StatelessWidget {
  const HomeProductGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is HomeLoadedSuccess) {
          return RefreshIndicator(
            onRefresh: () async {
              context.read<HomeBloc>().add(const FetchHome());
            },
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: Responsive.isMobile(context) ? 200 : 600,
                childAspectRatio: Responsive.isMobile(context) ? 0.8 : 1.6,
                crossAxisSpacing: Responsive.isMobile(context) ? 20 : 40,
                mainAxisSpacing: Responsive.isMobile(context) ? 16 : 32,
              ),
              itemCount: state.products.length,
              itemBuilder: (context, index) => HomeProductGridItem(
                homeProduct: state.products[index],
                onItemClick: () {
                  final args = {
                    'productId': state.products[index].productID,
                    'productPrice': state.products[index].pricev.toInt(),
                    'rating': state.products[index].prorating.toInt(),
                    'brandId': state.products[index].brandID,
                  };
                  Navigator.pushNamed(
                    context,
                    AppRoutes.productDetail,
                    arguments: args,
                  );
                },
              ),
            ),
          );
        } else {
          return const HomeErrorWidget();
        }
      },
    );
  }
}

class HomeErrorWidget extends StatelessWidget {
  const HomeErrorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Đã có lỗi xảy ra, vui lòng thử lại',
            style: TextStyle(
              fontFamily: 'MyriadPro',
              fontSize: Responsive.isMobile(context) ? 18 : 18 * 1.5,
              letterSpacing: 1,
            ),
          ),
          SizedBox(
            height: Responsive.isMobile(context) ? 8 : 16,
          ),
          ElevatedButton(
            onPressed: () {
              context.read<HomeBloc>().add(const FetchHome());
            },
            child: Text(
              'Thử lại',
              style: TextStyle(
                fontFamily: 'MyriadProRegular',
                fontSize: Responsive.isMobile(context) ? 16 : 16 * 1.5,
                letterSpacing: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HomeProductGridItem extends StatelessWidget {
  final HomeProduct homeProduct;
  final Function onItemClick;

  const HomeProductGridItem({
    Key? key,
    required this.homeProduct,
    required this.onItemClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onItemClick();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: homeProduct.imagePath == ''
                ? Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(
                      bottom: Responsive.isMobile(context) ? 5 : 10,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.shade300,
                    ),
                    child: Text(
                      'No Image',
                      style: TextStyle(
                        fontSize: Responsive.isMobile(context) ? 14 : 28,
                        fontFamily: 'MyriadProRegular',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : CachedNetworkImage(
                    imageUrl: homeProduct.imagePath,
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
          Text(
            homeProduct.productName,
            style: TextStyle(
              fontFamily: 'MyriadProRegular',
              fontSize: Responsive.isMobile(context) ? 13 : 26,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
