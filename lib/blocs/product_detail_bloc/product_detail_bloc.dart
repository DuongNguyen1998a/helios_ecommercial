import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helios_ecommercial/models/add_cart_model.dart';

/// Models
import '../../models/product_detail.dart';

/// Services
import '../../services/app_services.dart';

part 'product_detail_event.dart';

part 'product_detail_state.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  final appServices = AppServices();

  ProductDetailBloc() : super(ProductDetailInitial()) {
    on<FetchProductDetail>(_onFetchProductDetail);
    on<GetCurrentAreaId>(_onGetCurrentAreaId);
    on<GetCurrentSpecId>(_onGetCurrentSpecId);
    on<IncreaseQty>(_onIncreaseQty);
    on<DecreaseQty>(_onDecreaseQty);
    on<FavoriteProduct>(_onFavoriteProduct);
    on<AddToCart>(_onAddToCart);
  }

  Future<void> _onFetchProductDetail(
      FetchProductDetail event, Emitter<ProductDetailState> emit) async {
    emit(ProductDetailLoading());

    final response = await appServices.fetchProductDetailById(event.productId);

    if (response.statusCode == 200 && response.data['code'] == '0') {
      final jsonData = response.data['responseData'] as List;

      final data = jsonData.map((e) => ProductDetail.fromJson(e)).toList();

      emit(ProductDetailLoadedSuccess(productDetail: data[0], isFav: data[0].isFavorite));
    } else if (response.statusCode == 401) {
      emit(ProductDetailUnauthorized());
    } else {
      emit(ProductDetailLoadedError());
    }
  }

  void _onGetCurrentAreaId(
      GetCurrentAreaId event, Emitter<ProductDetailState> emit) {
    final state = this.state;

    if (state is ProductDetailLoadedSuccess) {
      emit(ProductDetailLoadedSuccess(
        productDetail: state.productDetail,
        currentAreaId: event.currentAreaId,
        specId1: state.specId1,
        specId2: state.specId2,
        specId3: state.specId3,
        specId4: state.specId4,
        specId5: state.specId5,
        currentQty: state.currentQty,
        isFav: state.isFav,
      ));
    }
  }

  void _onGetCurrentSpecId(
      GetCurrentSpecId event, Emitter<ProductDetailState> emit) {
    final state = this.state;

    if (state is ProductDetailLoadedSuccess) {
      emit(ProductDetailLoadedSuccess(
        productDetail: state.productDetail,
        currentAreaId: state.currentAreaId,
        specId1: event.specId1,
        specId2: event.specId2,
        specId3: event.specId3,
        specId4: event.specId4,
        specId5: event.specId5,
        currentQty: state.currentQty,
        isFav: state.isFav,
      ));
    }
  }

  void _onIncreaseQty(IncreaseQty event, Emitter<ProductDetailState> emit) {
    final state = this.state;

    if (state is ProductDetailLoadedSuccess) {
      emit(ProductDetailLoadedSuccess(
        productDetail: state.productDetail,
        currentAreaId: state.currentAreaId,
        specId1: state.specId1,
        specId2: state.specId2,
        specId3: state.specId3,
        specId4: state.specId4,
        specId5: state.specId5,
        currentQty: state.currentQty + 1,
        isFav: state.isFav,
      ));
    }
  }

  void _onDecreaseQty(DecreaseQty event, Emitter<ProductDetailState> emit) {
    final state = this.state;

    if (state is ProductDetailLoadedSuccess) {

      if (state.currentQty != 1 && state.currentQty > 1) {
        emit(ProductDetailLoadedSuccess(
          productDetail: state.productDetail,
          currentAreaId: state.currentAreaId,
          specId1: state.specId1,
          specId2: state.specId2,
          specId3: state.specId3,
          specId4: state.specId4,
          specId5: state.specId5,
          currentQty: state.currentQty - 1,
          isFav: state.isFav,
        ));
      }
    }
  }

  Future<void> _onFavoriteProduct(FavoriteProduct event, Emitter<ProductDetailState> emit) async {
    final state = this.state;

    if (state is ProductDetailLoadedSuccess) {

      final response = await appServices.addFavoriteProduct(event.productId, event.brandId);

      if (response.statusCode == 200 && response.data['code'] == '0') {
        emit(ProductDetailLoadedSuccess(
          productDetail: state.productDetail,
          currentAreaId: state.currentAreaId,
          specId1: state.specId1,
          specId2: state.specId2,
          specId3: state.specId3,
          specId4: state.specId4,
          specId5: state.specId5,
          currentQty: state.currentQty,
          isFav: !state.isFav,
        ));
      }
    }
  }

  Future<void> _onAddToCart(AddToCart event, Emitter<ProductDetailState> emit) async {
    final state = this.state;

    if (state is ProductDetailLoadedSuccess) {
      final response = await appServices.addToCart(event.carts);

      if (response.statusCode == 200 && response.data['code'] == '0') {
        emit(ProductDetailLoadedSuccess(
          productDetail: state.productDetail,
          currentAreaId: state.currentAreaId,
          specId1: state.specId1,
          specId2: state.specId2,
          specId3: state.specId3,
          specId4: state.specId4,
          specId5: state.specId5,
          currentQty: state.currentQty,
          isFav: state.isFav,
        ));
      }

    }
  }
}
