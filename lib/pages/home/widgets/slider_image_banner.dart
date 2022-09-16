import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

/// Blocs
import '../../../blocs/home_bloc/home_bloc.dart';

/// Responsive
import '../../../utils/responsive.dart';

class SliderImageBanner extends StatefulWidget {
  const SliderImageBanner({Key? key}) : super(key: key);

  @override
  State<SliderImageBanner> createState() => _SliderImageBannerState();
}

class _SliderImageBannerState extends State<SliderImageBanner> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is HomeLoadedSuccess) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            state.banners
                .map((e) => precacheImage(NetworkImage(e.imagePath), context))
                .toList();
          });
        }
      },
      child: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
        if (state is HomeLoading) {
          return const SizedBox();
        } else if (state is HomeLoadedSuccess) {
          return Container(
            width: double.infinity,
            height: Responsive.isMobile(context) ? 560 / 4 : 560 / 2,
            margin: EdgeInsets.all(
              Responsive.isMobile(context) ? 20 : 40,
            ),
            child: CarouselSlider.builder(
              itemCount: state.banners.length,
              options: CarouselOptions(
                autoPlay: true,
                aspectRatio: 2.0,
                enlargeCenterPage: true,
              ),
              itemBuilder: (context, index, realIdx) {
                return SliderImageItem(
                  imageSrc: state.banners[index].imagePath,
                );
              },
            ),
          );
        } else {
          return const SizedBox();
        }
      }),
    );
  }
}

class SliderImageItem extends StatelessWidget {
  final String imageSrc;

  const SliderImageItem({
    Key? key,
    required this.imageSrc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: CachedNetworkImage(
          width: 1000,
          imageUrl: imageSrc,
          fit: BoxFit.fill,
          placeholder: (context, url) => Shimmer(
            direction: const ShimmerDirection.fromLTRB(),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.grey.shade300,
              ),
            ),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }
}
