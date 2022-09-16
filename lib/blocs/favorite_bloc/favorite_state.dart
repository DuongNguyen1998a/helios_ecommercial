part of 'favorite_bloc.dart';

abstract class FavoriteState extends Equatable {
  const FavoriteState();
}

class FavoriteInitial extends FavoriteState {
  @override
  List<Object> get props => [];
}

class FavoriteLoading extends FavoriteState {
  @override
  List<Object> get props => [];
}

class FavoriteLoadedError extends FavoriteState {
  @override
  List<Object> get props => [];
}

class FavoriteLoadedStatus401 extends FavoriteState {
  @override
  List<Object> get props => [];
}

class FavoriteLoadedSuccess extends FavoriteState {
  final List<FavProduct> favProducts;

  const FavoriteLoadedSuccess({this.favProducts = const []});

  @override
  List<Object> get props => [favProducts];
}
