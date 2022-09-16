part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

class HomeInitial extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeLoading extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeLoadedSuccess extends HomeState {
  final List<HomeBanner> banners;
  final List<HomeProduct> products;

  const HomeLoadedSuccess({this.banners = const [], this.products = const [],});

  @override
  List<Object?> get props => [banners, products,];
}

class HomeLoadedError extends HomeState {
  @override
  List<Object> get props => [];
}



