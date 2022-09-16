import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helios_ecommercial/services/app_services.dart';

import '../../models/cart.dart';
import '../../models/order_detail.dart';

part 'cart_event.dart';

part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final appServices = AppServices();

  CartBloc() : super(CartInitial()) {
    on<FetchCarts>(_onFetchCart);
    on<SelectedProductInCart>(_onSelectedProductInCart);
    on<CreateOrder>(_onCreateOrder);
    on<GetPaymentInfo>(_onGetPaymentInfo);
  }

  FutureOr<void> _onFetchCart(FetchCarts event, Emitter<CartState> emit) async {
    emit(CartLoading());

    final response = await appServices.fetchCarts();

    if (response.statusCode == 200 && response.data['code'] == '0') {
      final jsonData = response.data['responseData']['data'] as List;

      final data = jsonData.map((e) => Cart.fromJson(e)).toList();

      emit(CartLoadedSuccess(
        lstCarts: data,
        lstCartLength: data[0].lstDetail.length,
        address: '',
        transportMethod: 0,
        phone: '',
      ));
    } else {
      emit(CartLoadedFailed());
    }
  }

  void _onSelectedProductInCart(
      SelectedProductInCart event, Emitter<CartState> emit) {
    final state = this.state;

    List<Cart> _listCart = [];

    if (state is CartLoadedSuccess) {
      var listCart = state.lstCarts;

      LstDetail lstDetail = listCart[0].lstDetail[event.index];

      listCart[0].lstDetail.removeWhere(
          (element) => element.productionID == lstDetail.productionID);

      _listCart = listCart;

      emit(CartLoadedSuccess(
        lstCarts: _listCart.toList(),
        lstCartLength: _listCart[0].lstDetail.length,
        address: state.address,
        transportMethod: state.transportMethod,
        phone: state.phone,
      ));

      LstDetail lstDetailNew = LstDetail(
        shoppingCartDetailID: lstDetail.shoppingCartDetailID,
        shoppingCartID: lstDetail.shoppingCartID,
        productionID: lstDetail.productionID,
        quantity: lstDetail.quantity,
        vPrice: lstDetail.vPrice,
        pricev: lstDetail.pricev,
        vat: lstDetail.vat,
        amountDiscount: lstDetail.amountDiscount,
        vAmount: lstDetail.vAmount,
        amountv: lstDetail.amountv,
        description: lstDetail.description,
        userCreate: lstDetail.userCreate,
        dateCreate: lstDetail.dateCreate,
        userUpdate: lstDetail.userUpdate,
        dateUpdate: lstDetail.dateUpdate,
        productName: lstDetail.productName,
        isChecked: !lstDetail.isChecked,
        productImage: lstDetail.productImage,
      );

      listCart[0].lstDetail.insert(event.index, lstDetailNew);

      _listCart = listCart;

      emit(CartLoadedSuccess(
        lstCarts: _listCart.toList(),
        lstCartLength: _listCart[0].lstDetail.length,
        address: state.address,
        transportMethod: state.transportMethod,
        phone: state.phone,
      ));
    }
  }

  Future<void> _onCreateOrder(
      CreateOrder event, Emitter<CartState> emit) async {
    final state = this.state;

    if (state is CartLoadedSuccess) {
      final response = await appServices.createOrder(
        event.orderDetails,
        state.lstCarts[0].shoppingCartID,
        state.address,
        state.transportMethod,
        state.phone,
      );

      if (response.statusCode == 200) {
        emit(CartLoadedSuccess(
          lstCarts: state.lstCarts,
          lstCartLength: state.lstCartLength,
          address: '',
          transportMethod: 0,
          phone: '',
        ));
      } else {
        emit(CartLoadedSuccess(
          lstCarts: state.lstCarts,
          lstCartLength: state.lstCartLength,
          address: '',
          transportMethod: 0,
          phone: '',
        ));
      }
    }
  }

  void _onGetPaymentInfo(GetPaymentInfo event, Emitter<CartState> emit) {
    final state = this.state;

    if (state is CartLoadedSuccess) {
      emit(
        CartLoadedSuccess(
          lstCarts: state.lstCarts,
          lstCartLength: state.lstCartLength,
          address: event.address,
          phone: event.phone,
          transportMethod: event.transportMethod,
        )
      );
    }
  }
}
