import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Models
import '../../models/sub_category.dart';

/// Services
import '../../services/app_services.dart';

part 'sub_category_event.dart';

part 'sub_category_state.dart';

class SubCategoryBloc extends Bloc<SubCategoryEvent, SubCategoryState> {
  final appServices = AppServices();

  SubCategoryBloc() : super(SubCategoryInitial()) {
    on<FetchSubCategory>(_onFetchSubCategory);
  }

  Future<void> _onFetchSubCategory(
      FetchSubCategory event, Emitter<SubCategoryState> emit) async {
    emit(SubCategoryLoading());

    final response =
        await appServices.fetchSubCategoryByMainCategoryId(event.categoryId);

    if (response.statusCode == 200 && response.data['code'] == '0') {
      final jsonData = response.data['responseData'] as List;
      final data = jsonData.map((e) => SubCategory.fromJson(e)).toList();

      emit(SubCategoryLoadedSuccess(subCategories: data));
    } else {
      emit(SubCategoryLoadedError());
    }
  }
}
