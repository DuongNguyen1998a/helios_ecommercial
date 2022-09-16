import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/fav_product.dart';
import '../../services/app_services.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final appServices = AppServices();
  FavoriteBloc() : super(FavoriteInitial()) {
    on<FetchFavProducts>(_onFetchFavProducts);
  }

  Future<void> _onFetchFavProducts(FetchFavProducts event, Emitter<FavoriteState> emit) async {
    emit(FavoriteLoading());

    final response = await appServices.fetchFavProducts();

    if (response.statusCode == 200 && response.data['code'] == '0') {

      final jsonData = response.data['responseData'] as List;
      final output = jsonData.map((e) => FavProduct.fromJson(e)).toList();

      emit(FavoriteLoadedSuccess(favProducts: output));
    }
    else if (response.statusCode == 401) {
      emit(FavoriteLoadedStatus401());
    }
    else {
      emit(FavoriteLoadedError());
    }
  }
}
