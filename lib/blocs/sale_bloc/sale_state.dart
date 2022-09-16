part of 'sale_bloc.dart';

abstract class SaleState extends Equatable {
  const SaleState();
}

class SaleInitial extends SaleState {
  @override
  List<Object> get props => [];
}

class SaleLoading extends SaleState {
  @override
  List<Object> get props => [];
}

class SaleLoadedSuccess extends SaleState {
  final List<Sale> sales;

  const SaleLoadedSuccess({this.sales = const []});

  @override
  List<Object> get props => [sales];
}

class SaleLoadedFailed extends SaleState {
  @override
  List<Object> get props => [];
}

class SaleLoadedStatus401 extends SaleState {
  @override
  List<Object> get props => [];
}