import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/sale.dart';
import '../../services/app_services.dart';

part 'sale_event.dart';
part 'sale_state.dart';

class SaleBloc extends Bloc<SaleEvent, SaleState> {
  final appServices = AppServices();
  SaleBloc() : super(SaleInitial()) {
    on<FetchSales>(_onFetchSales);
  }

  Future<void> _onFetchSales(FetchSales event, Emitter<SaleState> emit) async {
    emit(SaleLoading());

    final response = await appServices.fetchSalesByUserId();

    if (response.statusCode == 200 && response.data['code'] == '0') {
      final jsonData = response.data['responseData']['data'] as List;
      final output = jsonData.map((e) => Sale.fromJson(e)).toList();
      emit(SaleLoadedSuccess(sales: output));
    }
    else if (response.statusCode == 401) {
      emit(SaleLoadedStatus401());
    }
    else {
      emit(SaleLoadedFailed());
    }
  }
}
