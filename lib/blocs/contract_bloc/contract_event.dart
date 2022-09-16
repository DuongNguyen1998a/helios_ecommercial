part of 'contract_bloc.dart';

abstract class ContractEvent extends Equatable {
  const ContractEvent();
}

class FetchContracts extends ContractEvent {
  final List<Contract> contracts;

  const FetchContracts({this.contracts = const []});

  @override
  List<Object?> get props => [contracts];

}