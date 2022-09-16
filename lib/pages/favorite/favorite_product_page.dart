import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helios_ecommercial/blocs/auth_bloc/auth_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

/// Blocs
import '../../blocs/favorite_bloc/favorite_bloc.dart';
import '../../colors/app_colors.dart';
import '../../routes/app_routes.dart';
import '../../utils/constants.dart';
import '../../utils/functions.dart';
import '../../utils/responsive.dart';

class FavoriteProductPage extends StatelessWidget {
  const FavoriteProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF2F2F2),
      child: BlocBuilder<FavoriteBloc, FavoriteState>(
        builder: (context, state) {
          if (state is FavoriteLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is FavoriteLoadedSuccess) {
            return state.favProducts.isEmpty
                ? Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Chưa có sản phẩm nào được bạn yêu thích',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                            fontFamily: 'MyriadProRegular',
                            fontSize: Responsive.isMobile(context) ? 14 : 28,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: Responsive.isMobile(context) ? 10 : 20,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            context
                                .read<FavoriteBloc>()
                                .add(const FetchFavProducts());
                          },
                          child: Text(
                            'Tải lại',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1,
                                fontFamily: 'MyriadProRegular',
                                fontSize:
                                    Responsive.isMobile(context) ? 14 : 28),
                          ),
                        ),
                      ],
                    ),
                  )
                : RefreshIndicator(
                    onRefresh: () async {
                      context
                          .read<FavoriteBloc>()
                          .add(const FetchFavProducts());
                    },
                    child: ListView.builder(
                      itemCount: state.favProducts.length,
                      itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          final args = {
                            'productId': state.favProducts[index].productID,
                            'productPrice':
                                state.favProducts[index].pricev.toInt(),
                            'rating':
                                state.favProducts[index].productRating.toInt(),
                            'brandId': state.favProducts[index].brandID,
                          };
                          Navigator.pushNamed(
                            context,
                            AppRoutes.productDetail,
                            arguments: args,
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.all(
                              Responsive.isMobile(context) ? 10 : 20),
                          margin: EdgeInsets.symmetric(
                              horizontal:
                                  Responsive.isMobile(context) ? 20 : 40,
                              vertical: Responsive.isMobile(context) ? 10 : 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width:
                                    Responsive.isMobile(context) ? 96 : 96 * 2,
                                margin: EdgeInsets.only(
                                    bottom:
                                        Responsive.isMobile(context) ? 10 : 20),
                                padding: EdgeInsets.all(
                                    Responsive.isMobile(context) ? 8 : 16),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: primaryColor,
                                ),
                                child: state.favProducts[index].productRating ==
                                        0
                                    ? Row(
                                        children: List.generate(
                                          5,
                                          (index) => Icon(
                                            Icons.star_outline,
                                            color: Colors.white,
                                            size: Responsive.isMobile(context)
                                                ? 16
                                                : 32,
                                          ),
                                        ),
                                      )
                                    : Row(
                                        children: List.generate(
                                          state.favProducts[index].productRating
                                              .toInt(),
                                          (index) => Icon(
                                            Icons.star,
                                            color: Colors.white,
                                            size: Responsive.isMobile(context)
                                                ? 16
                                                : 32,
                                          ),
                                        ),
                                      ),
                              ),
                              Row(
                                children: [
                                  state.favProducts[index].imagePath == ''
                                      ? Container(
                                          alignment: Alignment.center,
                                          width: Responsive.isMobile(context)
                                              ? 100
                                              : 200,
                                          height: Responsive.isMobile(context)
                                              ? 100
                                              : 200,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: const Color(0xFFF2F2F2),
                                          ),
                                          child: Text(
                                            'No Image',
                                            style: TextStyle(
                                              fontSize:
                                                  Responsive.isMobile(context)
                                                      ? 15
                                                      : 30,
                                              fontFamily: 'MyriadProRegular',
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        )
                                      : SizedBox(
                                          width: Responsive.isMobile(context)
                                              ? 100
                                              : 200,
                                          height: Responsive.isMobile(context)
                                              ? 100
                                              : 200,
                                          child: CachedNetworkImage(
                                            imageUrl: state
                                                .favProducts[index].imagePath,
                                            imageBuilder:
                                                (context, imageProvider) =>
                                                    Container(
                                              margin: EdgeInsets.only(
                                                bottom:
                                                    Responsive.isMobile(context)
                                                        ? 5
                                                        : 10,
                                              ),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Colors.grey.shade300,
                                                image: DecorationImage(
                                                  image: imageProvider,
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                            placeholder: (context, url) =>
                                                Shimmer(
                                              direction: const ShimmerDirection
                                                  .fromLTRB(),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: Colors.grey.shade300,
                                                ),
                                              ),
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(Icons.error),
                                          ),
                                        ),
                                  SizedBox(
                                    width:
                                        Responsive.isMobile(context) ? 10 : 20,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          state.favProducts[index].productName,
                                          style: TextStyle(
                                            fontSize:
                                                Responsive.isMobile(context)
                                                    ? 15
                                                    : 30,
                                            fontFamily: 'MyriadProRegular',
                                            fontWeight: FontWeight.w500,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(
                                          height: Responsive.isMobile(context)
                                              ? 10
                                              : 20,
                                        ),
                                        Text(
                                          'Hãng sản xuất: ${state.favProducts[index].brandName}',
                                          style: TextStyle(
                                            fontSize:
                                                Responsive.isMobile(context)
                                                    ? 13
                                                    : 24,
                                            color: Colors.grey,
                                            fontFamily: 'MyriadProRegular',
                                          ),
                                          maxLines: 2,
                                        ),
                                        SizedBox(
                                          height: Responsive.isMobile(context)
                                              ? 10
                                              : 20,
                                        ),
                                        Text(
                                          '${Functions.formatCurrency(state.favProducts[index].pricev)} đ',
                                          style: TextStyle(
                                            fontSize:
                                                Responsive.isMobile(context)
                                                    ? 15
                                                    : 30,
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
                    ),
                  );
          } else if (state is FavoriteLoadedStatus401) {
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Phiên đăng nhập hết hạn, bạn có muốn tiếp tục ?',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                      fontFamily: 'MyriadProRegular',
                      fontSize: Responsive.isMobile(context) ? 14 : 28,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: Responsive.isMobile(context) ? 10 : 20,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, AppRoutes.auth);
                        },
                        child: Text(
                          'Không',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                              fontFamily: 'MyriadProRegular',
                              fontSize: Responsive.isMobile(context) ? 14 : 28),
                        ),
                      ),
                      SizedBox(
                        width: Responsive.isMobile(context) ? 10 : 20,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          final sharedPrefs =
                              await SharedPreferences.getInstance();
                          String? userName =
                              sharedPrefs.getString(KeyUtils.userName);
                          String? passWord =
                              sharedPrefs.getString(KeyUtils.password);

                          context.read<AuthBloc>().add(DoLogin(
                              username: userName!, password: passWord!));

                          Future.delayed(const Duration(seconds: 2)).then((_) {
                            context
                                .read<FavoriteBloc>()
                                .add(const FetchFavProducts());
                          });
                        },
                        child: Text(
                          'Tiếp tục',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                              fontFamily: 'MyriadProRegular',
                              fontSize: Responsive.isMobile(context) ? 14 : 28),
                        ),
                      ),
                    ],
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
