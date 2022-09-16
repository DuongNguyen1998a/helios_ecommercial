part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();
}


class FetchProducts extends ProductEvent {
  final List<Product> products;
  final int productTypeId;

  const FetchProducts({this.products = const [], this.productTypeId = 0});

  @override
  List<Object?> get props => [products, productTypeId,];

}