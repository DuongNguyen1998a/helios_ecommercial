import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/product.dart';
import '../../services/app_services.dart';

part 'product_event.dart';

part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final appServices = AppServices();

  ProductBloc() : super(ProductInitial()) {
    on<FetchProducts>(_onFetchProducts);
  }

  Future<void> _onFetchProducts(FetchProducts event, Emitter<ProductState> emit) async {
    emit(ProductLoading());

    final response = await appServices.fetchProducts(event.productTypeId);

    if (response.statusCode == 200 && response.data['code'] == '0') {
      final jsonData = response.data['responseData'] as List;

      final output = jsonData.map((e) => Product.fromJson(e)).toList();

      emit(ProductLoadedSuccess(products: output));
    }
    else {
      emit(ProductLoadedFailed());
    }
  }
}
