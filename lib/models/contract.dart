import 'package:equatable/equatable.dart';

class Contract extends Equatable {
  final String contractCode;
  final String companyName;
  final String userCreate;
  final String dateCreate;
  final String customerName;
  final String description;
  final String signDate;
  final String endDate;
  final int status;
  final int contractValue;

  const Contract({
    required this.contractCode,
    required this.companyName,
    required this.userCreate,
    required this.dateCreate,
    required this.customerName,
    required this.description,
    required this.signDate,
    required this.endDate,
    required this.status,
    required this.contractValue,
  });

  factory Contract.fromJson(Map<String, dynamic> json) {
    return Contract(
      contractCode: json['contractCode'],
      companyName: json['companyName'],
      userCreate: json['userCreate'],
      dateCreate: json['dateCreate'],
      customerName: json['customerName'],
      description: json['description'],
      signDate: json['signDate'],
      endDate: json['endDate'],
      status: json['status'],
      contractValue: json['contractValue'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['contractCode'] = contractCode;
    data['companyName'] = companyName;
    data['userCreate'] = userCreate;
    data['dateCreate'] = dateCreate;
    data['customerName'] = customerName;
    data['description'] = description;
    data['signDate'] = signDate;
    data['endDate'] = endDate;
    data['status'] = status;
    data['contractValue'] = contractValue;
    return data;
  }

  @override
  List<Object?> get props => [
    contractCode,
    companyName,
    userCreate,
    dateCreate,
    customerName,
    description,
    signDate,
    endDate,
    status,
    contractValue,
  ];
}
