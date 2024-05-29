import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:hak/core/api_url.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<SentOtpEvent>(_sendOtp);
  }

  FutureOr<void> _sendOtp(SentOtpEvent event, Emitter<AuthState> emit) async {
    Dio dioClient = Dio();
    emit(OtpLoadingState());
    try {
      final baseUrl = ApiLinks.registerUserUrl;
      final response = await dioClient
          .post(baseUrl, data: {"phone_number": event.moblileNumber});
      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(OtpReceived(mobileNumber: event.moblileNumber));
      }
    } catch (error) {
      log(error.toString());
    }
  }
}
