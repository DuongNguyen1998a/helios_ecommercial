part of 'user_approve_bloc.dart';

abstract class UserApproveEvent extends Equatable {
  const UserApproveEvent();
}

class FetchUserApproves extends UserApproveEvent {
  final List<UserApprove> userApproves;
  final int orderId;

  const FetchUserApproves({this.userApproves = const [], this.orderId = 0});

  @override
  List<Object?> get props => [userApproves, orderId,];
}
