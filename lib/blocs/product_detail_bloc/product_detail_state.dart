part of 'product_detail_bloc.dart';

abstract class ProductDetailState extends Equatable {
  const ProductDetailState();
}

class ProductDetailInitial extends ProductDetailState {
  @override
  List<Object> get props => [];
}

class ProductDetailLoading extends ProductDetailState {
  @override
  List<Object> get props => [];
}

class ProductDetailLoadedSuccess extends ProductDetailState {
  final ProductDetail productDetail;
  final int currentAreaId;
  final int specId1;
  final int specId2;
  final int specId3;
  final int specId4;
  final int specId5;
  final int currentQty;
  final bool isFav;

  const ProductDetailLoadedSuccess({
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
    this.currentAreaId = 0,
    this.specId1 = 0,
    this.specId2 = 0,
    this.specId3 = 0,
    this.specId4 = 0,
    this.specId5 = 0,
    this.currentQty = 1,
    this.isFav = false,
  });

  @override
  List<Object> get props =>
      [
        productDetail,
        currentAreaId,
        specId1,
        specId2,
        specId3,
        specId4,
        specId5,
        currentQty,
        isFav,
      ];
}

class ProductDetailLoadedError extends ProductDetailState {
  @override
  List<Object> get props => [];
}

class ProductDetailUnauthorized extends ProductDetailState {
  @override
  List<Object> get props => [];
}
