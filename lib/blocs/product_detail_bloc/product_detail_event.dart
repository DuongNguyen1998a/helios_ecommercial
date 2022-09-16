part of 'product_detail_bloc.dart';

abstract class ProductDetailEvent extends Equatable {
  const ProductDetailEvent();
}

class FetchProductDetail extends ProductDetailEvent {
  final ProductDetail productDetail;
  final int productId;
  final int currentAreaId;

  const FetchProductDetail({
    this.productDetail = const ProductDetail(
      productID: 0,
      productCode: '',
      productName: '',
      status: 0,
      description: '',
      brandID: 0,
      productTypeID: 0,
      informationTech: '',
      isFavorite: false,
      lstData: [],
    ),
    this.productId = 0,
    this.currentAreaId = 0,
  });

  @override
  List<Object?> get props => [
        productDetail,
        productId,
        currentAreaId,
      ];
}

class GetCurrentAreaId extends ProductDetailEvent {
  final int currentAreaId;

  const GetCurrentAreaId({this.currentAreaId = 0});

  @override
  List<Object?> get props => [currentAreaId];
}

class GetCurrentSpecId extends ProductDetailEvent {
  final int specId1;
  final int specId2;
  final int specId3;
  final int specId4;
  final int specId5;

  const GetCurrentSpecId({
    this.specId1 = 0,
    this.specId2 = 0,
    this.specId3 = 0,
    this.specId4 = 0,
    this.specId5 = 0,
  });

  @override
  List<Object?> get props => [
        specId1,
        specId2,
        specId3,
        specId4,
        specId5,
      ];
}

class IncreaseQty extends ProductDetailEvent {
  @override
  List<Object?> get props => [];
}

class DecreaseQty extends ProductDetailEvent {
  @override
  List<Object?> get props => [];
}

class FavoriteProduct extends ProductDetailEvent {
  final int productId;
  final int brandId;

  const FavoriteProduct({this.productId = 0, this.brandId = 0,});

  @override
  List<Object?> get props => [productId, brandId,];
}

class AddToCart extends ProductDetailEvent {
  final List<AddCartModel> carts;

  const AddToCart({this.carts = const []});

  @override
  List<Object?> get props => [carts];
}
