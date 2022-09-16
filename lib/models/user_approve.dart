import 'package:equatable/equatable.dart';

class UserApprove extends Equatable {
  final int orderApproveID;
  final int orderID;
  final int userApproveID;
  final int numberApprove;
  final int isApprove;
  final DateTime? dateApprove;
  final int status;
  final String strStatus;
  final String customerName;
  final String departmentName;
  final String positionName;

  const UserApprove({
    required this.orderApproveID,
    required this.orderID,
    required this.userApproveID,
    required this.numberApprove,
    required this.isApprove,
    required this.dateApprove,
    required this.status,
    required this.strStatus,
    required this.customerName,
    required this.departmentName,
    required this.positionName,
  });

  factory UserApprove.fromJson(Map<String, dynamic> json) {
    return UserApprove(
      orderApproveID : json['orderApproveID'],
      orderID : json['orderID'],
      userApproveID : json['userApproveID'],
      numberApprove : json['numberApprove'],
      isApprove : json['isApprove'],
      dateApprove : json['dateApprove'],
      status : json['status'],
      strStatus : json['strStatus'],
      customerName : json['customerName'],
      departmentName : json['departmentName'],
      positionName : json['positionName'],
    );
  }

  @override
  List<Object?> get props => [
    orderApproveID,
    orderID,
    userApproveID,
    numberApprove,
    isApprove,
    dateApprove,
    status,
    strStatus,
    customerName,
    departmentName,
    positionName,
  ];
}
