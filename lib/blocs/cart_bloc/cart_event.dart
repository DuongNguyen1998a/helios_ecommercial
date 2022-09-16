part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();
}

class FetchCarts extends CartEvent {
  final List<Cart> lstCarts;

  const FetchCarts({this.lstCarts = const []});

  @override
  List<Object?> get props => [lstCarts];
}

class SelectedProductInCart extends CartEvent {
  final int index;

  const SelectedProductInCart({
    this.index = -1
  });

  @override
  List<Object?> get props => [index];
}

class CreateOrder extends CartEvent {
  final List<OrderDetail> orderDetails;

  const CreateOrder({this.orderDetails = const []});

  @override
  List<Object?> get props => [orderDetails];
}

class GetPaymentInfo extends CartEvent {
  final String address;
  final String phone;
  final int transportMethod;

  const GetPaymentInfo({this.address = '', this.phone = '', this.transportMethod = 0,});

  @override
  List<Object?> get props => [address, phone, transportMethod];

}
