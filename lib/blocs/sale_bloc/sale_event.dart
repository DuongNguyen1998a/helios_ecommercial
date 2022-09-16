part of 'sale_bloc.dart';

abstract class SaleEvent extends Equatable {
  const SaleEvent();
}

class FetchSales extends SaleEvent {
  final List<Sale> sales;

  const FetchSales({this.sales = const []});

  @override
  List<Object?> get props => [sales];
}