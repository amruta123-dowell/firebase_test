import 'package:firebase_test/presentation/sign_in_screen/bloc/signin_state.dart';
import 'package:firebase_test/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/utils/app_routes.dart';
import '../../core/utils/navigator_service.dart';
import '../../widgets/snackbar_widget.dart';
import '../../widgets/submit_button.dart';
import '../../widgets/textfield_widget.dart';
import 'bloc/signin_bloc.dart';
import 'bloc/signin_event.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});
  static Widget builder(BuildContext context) {
    return BlocProvider(
      create: (context) => SigninBloc()..add(SigninInitializeEvent()),
      child: SignInScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocBuilder<SigninBloc, SigninState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Sign in to account",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontSize: 34, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 60,
                ),
                TextFieldWidget(
                    errorText: state.emailError,
                    tecController:
                        state.emailController ?? TextEditingController(),
                    title: "Email"),
                const SizedBox(
                  height: 15,
                ),
                TextFieldWidget(
                    errorText: state.passwordError,
                    tecController:
                        state.passController ?? TextEditingController(),
                    title: "Password"),
                const SizedBox(
                  height: 30,
                ),
                SubmitButton(
                  onClickButton: () {
                    FocusScope.of(context).requestFocus(new FocusNode());
                    context
                        .read<SigninBloc>()
                        .add(SubmitSigninEvent(onFailure: (msg) {
                      showCustomSnackBar(context: context, message: msg);
                    }));
                  },
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Are you new user? "),
                    InkWell(
                        onTap: () {
                          context
                              .read<SigninBloc>()
                              .add(ClearSignInDataEvent());
                          NavigatorClass().pushNamed(AppRoutes.signUpScreen);
                        },
                        child: const Text("Sign up"))
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
