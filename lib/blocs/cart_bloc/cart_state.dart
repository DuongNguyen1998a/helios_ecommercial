part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  const CartState();
}

class CartInitial extends CartState {
  @override
  List<Object> get props => [];
}

class CartLoading extends CartState {
  @override
  List<Object> get props => [];
}

class CartLoadedSuccess extends CartState {
  final List<Cart> lstCarts;
  final int lstCartLength;
  final String address;
  final int transportMethod;
  final String phone;

  const CartLoadedSuccess({
    this.lstCarts = const [],
    this.lstCartLength = 0,
    this.address = '',
    this.transportMethod = 0,
    this.phone = '',
  });

  @override
  List<Object> get props => [lstCarts, lstCartLength, address, transportMethod, phone,];
}

class CartLoadedFailed extends CartState {
  @override
  List<Object> get props => [];
}
