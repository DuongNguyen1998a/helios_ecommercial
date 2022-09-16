import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/contract.dart';
import '../../services/app_services.dart';

part 'contract_event.dart';

part 'contract_state.dart';

class ContractBloc extends Bloc<ContractEvent, ContractState> {
  final appServices = AppServices();

  ContractBloc() : super(ContractInitial()) {
    on<FetchContracts>(_onFetchContracts);
  }

  Future<void> _onFetchContracts(
      ContractEvent event, Emitter<ContractState> emit) async {
    emit(ContractLoading());

    final response = await appServices.fetchContractByUserId();

    if (response.statusCode == 200 && response.data['code'] == '0') {
      final jsonData = response.data['responseData'] as List;

      final output = jsonData.map((e) => Contract.fromJson(e)).toList();

      emit(ContractLoadedSuccess(contracts: output));
    } else if (response.statusCode == 401) {
      emit(ContractLoadedStatus401());
    } else {
      emit(ContractLoadedFailed());
    }
  }
}
