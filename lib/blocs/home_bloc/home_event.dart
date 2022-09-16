part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class FetchHome extends HomeEvent {

  final List<HomeBanner> banners;
  final List<HomeProduct> products;

  const FetchHome({this.banners = const [], this.products = const [],});

  @override
  List<Object?> get props => [banners, products,];

}
