import 'dart:async';
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/user.dart';
import '../../services/app_services.dart';
import '../../utils/constants.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final appServices = AppServices();

  AuthBloc() : super(const AuthInitial()) {
    on<CheckRememberMe>(_checkRememberMe);
    on<DoLogin>(_onDoLogin);
  }

  void _checkRememberMe(CheckRememberMe event, Emitter<AuthState> emit) {
    final state = this.state;

    //debugPrint(state.toString());

    if (state is AuthInitial) {
      emit(
        AuthInitial(rememberMe: event.rememberMe),
      );
    }
  }

  Future<void> _onDoLogin(DoLogin event, Emitter<AuthState> emit) async {
    final state = this.state;
    bool rememberMe = false;

    debugPrint('_onDoLogin: ${state.toString()}');

    if (state is AuthInitial) {
      rememberMe = state.rememberMe;
    }

    emit(AuthLoading());

    final response = await appServices.login(
      event.username,
      event.password,
    );

    if (response.statusCode == 200 && response.data['code'] == '0') {
      // save data to shared preferences
      final sharedPreferences = await SharedPreferences.getInstance();
      String user = jsonEncode(
        User.fromJson(
          response.data['responseData'],
        ),
      );

      sharedPreferences.setString(KeyUtils.userInformation, user);
      if (rememberMe) {
        sharedPreferences.setBool(KeyUtils.rememberMe, rememberMe);
        sharedPreferences.setString(KeyUtils.userName, event.username);
        sharedPreferences.setString(KeyUtils.password, event.password);
      } else {
        sharedPreferences.remove(KeyUtils.rememberMe);
        sharedPreferences.remove(KeyUtils.userName);
        sharedPreferences.remove(KeyUtils.password);
      }
      sharedPreferences.setString(KeyUtils.userName, event.username);
      sharedPreferences.setString(KeyUtils.password, event.password);
      emit(AuthSuccess());
      emit(const AuthInitial());
    } else {
      emit(AuthFailed());
      emit(const AuthInitial());
    }
  }
}
