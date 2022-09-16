part of 'contract_bloc.dart';

abstract class ContractState extends Equatable {
  const ContractState();
}

class ContractInitial extends ContractState {
  @override
  List<Object> get props => [];
}

class ContractLoading extends ContractState {
  @override
  List<Object> get props => [];
}

class ContractLoadedSuccess extends ContractState {
  final List<Contract> contracts;

  const ContractLoadedSuccess({this.contracts = const []});

  @override
  List<Object> get props => [contracts];
}

class ContractLoadedFailed extends ContractState {
  @override
  List<Object> get props => [];
}

class ContractLoadedStatus401 extends ContractState {
  @override
  List<Object> get props => [];
}