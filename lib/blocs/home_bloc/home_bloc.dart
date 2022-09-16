import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Models
import '../../models/home_banner.dart';
import '../../models/home_product.dart';

/// Services
import '../../services/app_services.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final appServices = AppServices();

  HomeBloc() : super(HomeInitial()) {
    on<FetchHome>(_onFetchHomeBanners);
  }

  Future<void> _onFetchHomeBanners(FetchHome event, Emitter<HomeState> emit) async {
    emit(HomeLoading());

    await appServices.fetchHomeBanners().then((response) async {
      if (response.statusCode == 200 && response.data['code'] == '0') {
        final jsonData = response.data['responseData'] as List;
        final data = jsonData.map((e) => HomeBanner.fromJson(e)).toList();

        await appServices.fetchHomeProducts().then((response1) {
          if (response1.statusCode == 200 && response1.data['code'] == '0') {
            final jsonData1 = response1.data['responseData'] as List;
            final data1 = jsonData1.map((e) => HomeProduct.fromJson(e)).toList();

            emit(HomeLoadedSuccess(banners: data, products: data1));
          }
          else {
            emit(HomeLoadedError());
          }
        });
      }
      else {
        emit(HomeLoadedError());
      }
    });
  }
}
