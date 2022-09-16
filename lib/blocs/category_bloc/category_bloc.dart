import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/category.dart';
import '../../services/app_services.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final appServices = AppServices();
  CategoryBloc() : super(CategoryInitial()) {
    on<FetchMainCategory>(_onFetchMainCategory);
  }

  Future<void> _onFetchMainCategory(FetchMainCategory event, Emitter<CategoryState> emit) async {
    emit(CategoryLoading());

    final response = await appServices.fetchMainCategory();

    if (response.statusCode == 200 && response.data['code'] == '0') {
      final jsonData = response.data['responseData']['data'] as List;
      final data = jsonData.map((e) => Category.fromJson(e)).toList();

      emit(CategoryLoadedSuccess(mainCategories: data));
    }
    else {
      emit(CategoryLoadedError());
    }
  }

}
