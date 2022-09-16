part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  const ProductState();
}

class ProductInitial extends ProductState {
  @override
  List<Object> get props => [];
}

class ProductLoading extends ProductState {
  @override
  List<Object> get props => [];
}

class ProductLoadedSuccess extends ProductState {
  final List<Product> products;

  const ProductLoadedSuccess({this.products = const []});

  @override
  List<Object> get props => [products];
}

class ProductLoadedFailed extends ProductState {
  @override
  List<Object> get props => [];
}