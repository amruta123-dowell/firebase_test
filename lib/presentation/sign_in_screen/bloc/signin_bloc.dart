import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/app_routes.dart';
import '../../../core/utils/navigator_service.dart';
import '../../../core/utils/validators.dart';
import '../../../data/apiClient/api_provider.dart';
import 'signin_event.dart';
import 'signin_state.dart';

class SigninBloc extends Bloc<SigninEvent, SigninState> {
  SigninBloc() : super(const SigninState()) {
    on<SigninInitializeEvent>(_initialize);
    on<SubmitSigninEvent>(_onClickSignin);

    on<ClearSignInDataEvent>(_clearData);
  }
  final ApiProvider _apiProvider = ApiProvider();
  FutureOr<void> _onClickSignin(
      SubmitSigninEvent event, Emitter<SigninState> emit) async {
    String email = state.emailController?.text ?? "";
    String pass = state.passController?.text ?? "";

    if (!_validateTextField(emit)) {
      return;
    }
    try {
      if (email.isNotEmpty && pass.isNotEmpty) {
        await _apiProvider.signIn(email: email, password: pass).then((value) {
          if (value.isSuccess && value.data != null) {
            emit(state.copyWith(userData: value.data));
            add(ClearSignInDataEvent());
            NavigatorClass().pushNamedAndRemoveUntil(AppRoutes.homeScreen);
          } else if (value.error != null) {
            event.onFailure?.call(value.error!);
          }
        });
      }
    } catch (error) {
      print(error);
      print(error);
      event.onFailure?.call("Unable to login");
    }
  }

  FutureOr<void> _initialize(
      SigninInitializeEvent event, Emitter<SigninState> emit) {
    emit(state.copyWith(
      emailController: TextEditingController(),
      passController: TextEditingController(),
    ));
  }

  bool _validateTextField(Emitter<SigninState> emit) {
    String emailError = _emailValidation;
    String passwordError = _passwordValidation;
    emit(state.copyWith(emailError: emailError, passwordError: passwordError));

    if (emailError.isEmpty || passwordError.isEmpty) {
      return true;
    }
    return false;
  }

  String get _emailValidation {
    String? error =
        Validators().validateEmail(state.emailController?.text ?? '');
    return error ?? '';
  }

  String get _passwordValidation {
    String? error = Validators().validateText(state.passController?.text ?? "");
    return error ?? '';
  }

  FutureOr<void> _clearData(
      ClearSignInDataEvent event, Emitter<SigninState> emit) {
    emit(state.copyWith(
      emailController: TextEditingController(),
      passController: TextEditingController(),
      emailError: '',
      passwordError: '',
    ));
  }
}
