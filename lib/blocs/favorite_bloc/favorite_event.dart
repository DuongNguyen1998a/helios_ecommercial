part of 'favorite_bloc.dart';

abstract class FavoriteEvent extends Equatable {
  const FavoriteEvent();
}

class FetchFavProducts extends FavoriteEvent {
  final List<FavProduct> favProducts;

  const FetchFavProducts({this.favProducts = const []});

  @override
  List<Object> get props => [favProducts];
}