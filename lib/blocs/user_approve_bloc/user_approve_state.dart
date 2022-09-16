part of 'user_approve_bloc.dart';

abstract class UserApproveState extends Equatable {
  const UserApproveState();
}

class UserApproveInitial extends UserApproveState {
  @override
  List<Object> get props => [];
}

class UserApproveLoading extends UserApproveState {
  @override
  List<Object> get props => [];
}

class UserApproveLoadedSuccess extends UserApproveState {
  final List<UserApprove> userApproves;

  const UserApproveLoadedSuccess({this.userApproves = const []});

  @override
  List<Object> get props => [userApproves];
}

class UserApproveLoadedError extends UserApproveState {
  @override
  List<Object> get props => [];
}
