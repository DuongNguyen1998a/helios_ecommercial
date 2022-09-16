import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Models
import '../../models/user_approve.dart';

/// Services
import '../../services/app_services.dart';

part 'user_approve_event.dart';

part 'user_approve_state.dart';

class UserApproveBloc extends Bloc<UserApproveEvent, UserApproveState> {
  final appServices = AppServices();

  UserApproveBloc() : super(UserApproveInitial()) {
    on<FetchUserApproves>(_onFetchUserApproves);
  }

  Future<void> _onFetchUserApproves(
      FetchUserApproves event, Emitter<UserApproveState> emit) async {
    emit(UserApproveLoading());

    final response = await appServices.fetchUserApproves(event.orderId);

    if (response.statusCode == 200 && response.data['code'] == '0') {

      final jsonData = response.data['responseData']['data'] as List;

      final data = jsonData.map((e) => UserApprove.fromJson(e)).toList();

      emit(
        UserApproveLoadedSuccess(
          userApproves: data,
        ),
      );
    }
    else {
      emit(UserApproveLoadedError());
    }
  }
}
