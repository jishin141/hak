part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

class OtpLoadingState extends AuthState {}

class OtpReceived extends AuthState {
  final String mobileNumber;
  const OtpReceived({required this.mobileNumber});
}

class OtpSubmitted extends AuthState {}

class OtpSendingErrorState extends AuthState {}

class OtpSubmitErrorState extends AuthState {}

class OtpSubmissionSuccessState extends AuthState {}
