import 'dart:async';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_test/core/utils/app_routes.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/navigator_service.dart';
import '../../../core/utils/validators.dart';
import '../../../data/apiClient/api_provider.dart';
import '../../../data/models/user_model.dart';
import 'signup_event.dart';
import 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(const SignupState()) {
    on<InitializeSignupEvent>(_initialize);
    on<OnclickSignupEvent>(_onClickSignup);
    on<ClearSignUpDataEvent>(_clearData);
  }

  final ApiProvider _apiProvider = ApiProvider();

  ///Define initial values
  FutureOr<void> _initialize(
      InitializeSignupEvent event, Emitter<SignupState> emit) {
    emit(state.copyWith(
      emailController: TextEditingController(),
      passwordController: TextEditingController(),
    ));
  }

  ///To sign up
  FutureOr<void> _onClickSignup(
      OnclickSignupEvent event, Emitter<SignupState> emit) async {
    if (!_validateTextField(emit)) {
      return;
    }
    if (((state.emailController?.text.isNotEmpty) ?? false) &&
        ((state.passController?.text.isNotEmpty) ?? false)) {
      String email = (state.emailController?.text ?? "");
      String password = state.passController?.text ?? "";
      try {
        await _apiProvider
            .signup(email: email, password: password)
            .then((result) async {
          if (result.isSuccess) {
            UserModel newUser = UserModel(
                email: email, pass: password, uid: result.data?.user?.uid);

            emit(state.copyWith(userData: result.data));
            add(ClearSignUpDataEvent());
            NavigatorClass().pushNamedAndRemoveUntil(AppRoutes.homeScreen);
          } else if (result.isFailure) {
            event.onFailure?.call("${result.error}");
          }
        });
      } catch (error) {
        event.onFailure?.call("Unable to sign up");
      }
    }
  }

  bool _validateTextField(Emitter<SignupState> emit) {
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

  /// Clear sign up data
  FutureOr<void> _clearData(
      ClearSignUpDataEvent event, Emitter<SignupState> emit) {
    emit(state.copyWith(
      emailController: TextEditingController(),
      passwordController: TextEditingController(),
      emailError: '',
      passwordError: '',
    ));
  }
}
