import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import '../../../models/product_detail.dart';
/// Responsive
import '../../../utils/responsive.dart';

class SliderImageProductDetail extends StatelessWidget {
  final List<ProductImage> listImage;

  const SliderImageProductDetail({
    Key? key,
    required this.listImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: Responsive.isMobile(context) ? 200 : 200 * 1.5,
      margin: EdgeInsets.only(top: Responsive.isMobile(context) ? 5 : 20),
      child: CarouselSlider.builder(
        itemCount: listImage.isEmpty ? 1 : listImage.length,
        options: CarouselOptions(
          autoPlay: true,
          aspectRatio: 2.0,
          enlargeCenterPage: true,
        ),
        itemBuilder: (context, index, realIdx) {
          return SliderImageItem(
            imageSrc: listImage.isEmpty ? '' : listImage[index].imagePath,
          );
        },
      ),
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
        child: imageSrc == ''
            ? Container(
                alignment: Alignment.center,
                width: 1000,
                height: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.grey.shade300,
                ),
                child: Text(
                  'No Image',
                  style: TextStyle(
                    fontFamily: 'MyriadProRegular',
                    fontSize: Responsive.isMobile(context) ? 15 : 30,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
              )
            : CachedNetworkImage(
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
