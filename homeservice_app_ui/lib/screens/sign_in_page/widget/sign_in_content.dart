import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homeservice_app_ui/core/const/color.dart';
import 'package:homeservice_app_ui/core/const/text_constants.dart';
import 'package:homeservice_app_ui/core/services/validation_service.dart';
import 'package:homeservice_app_ui/screens/common_widgets/tasky_buttton.dart';
import 'package:homeservice_app_ui/screens/common_widgets/tasky_text_field.dart';
import 'package:homeservice_app_ui/screens/sign_in_page/bloc/sign_in_bloc.dart';
import 'package:homeservice_app_ui/screens/sign_in_page/bloc/sign_in_event.dart';
import 'package:homeservice_app_ui/screens/sign_in_page/bloc/sign_in_state.dart';

class SignInContent extends StatelessWidget {
  const SignInContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.white,
      child: Stack(children: [
        _createMainBody(context),
        BlocBuilder<SignInBloc, SignInState>(
          buildWhen: (_, currState) =>
              currState is LoadingState ||
              currState is ErrorState ||
              currState is NextTabBarState,
          builder: (context, state) {
            if (state is LoadingState) {
              return _createLoading();
            } else if (state is ErrorState || state is NextTabBarState) {
              return SizedBox();
            }
            return SizedBox();
          },
        )
      ]),
    );
  }

  Widget _createMainBody(BuildContext context) {
    double height = MediaQuery.of(context).size.width;
    return SafeArea(
      child: SingleChildScrollView(
        child: SizedBox(
          height: height - 30 - MediaQuery.of(context).padding.bottom,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              _createHeader(),
              const SizedBox(height: 20),
              _createForm(context),
              const SizedBox(height: 20),
              _createForgotPasswordButton(context),
              const SizedBox(height: 20),
              _createSignInButton(context),
              Spacer(),
              _createNoAccountText(context),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _createLoading() {
    return TaskyLoading();
  }

  Widget _createHeader() {
    return Center(
      child: Text(
        TextConstants.signIn,
        style: TextStyle(
            color: AppColors.textColor,
            fontSize: 24,
            fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _createForm(BuildContext context) {
    final bloc = BlocProvider.of<SignInBloc>(context);
    return BlocBuilder<SignInBloc, SignInState>(
      buildWhen: (_, currsState) => currsState is ShowErrorState,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TaskyTextField(
              title: TextConstants.email,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              placeholder: TextConstants.emailPlaceholder,
              controller: bloc.emailController,
              errorText: TextConstants.emailInvalid,
              isError: state is ShowErrorState
                  ? ValidationService.email(bloc.emailController.text)
                  : false,
              onTextChanged: () {
                bloc.add(OnTextChangeEvent());
              },
            ),
            const SizedBox(height: 20),
            TaskyTextField(
              controller: bloc.passwordController,
              errorText: TextConstants.passwordInvalid,
              onTextChanged: () {
                bloc.add(OnTextChangeEvent());
              },
              obscureText: true,
              keyboardType: TextInputType.text,
              isError: state is ErrorState
                  ? !ValidationService.password(bloc.passwordController.text)
                  : false,
              placeholder: TextConstants.passwordPlaceholderSignIn,
              title: TextConstants.password,
            ),
          ],
        );
      },
    );
  }

  Widget _createForgotPasswordButton(BuildContext context) {
    final bloc = BlocProvider.of<SignInBloc>(context);
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.only(left: 12),
        child: Text(
          TextConstants.forgotPassword,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.textColor,
          ),
        ),
      ),
      onTap: () {
        FocusScope.of(context).unfocus();
        bloc.add(ForgotPasswordEvent());
      },
    );
  }

  Widget _createSignInButton(BuildContext context) {
    final bloc = BlocProvider.of<SignInBloc>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: BlocBuilder<SignInBloc, SignInState>(
        buildWhen: (_, currState) =>
            currState is SignInButtonEnableChangedState,
        builder: (context, state) {
          return TaskyButton(
            title: TextConstants.signIn,
            isEnabled: state is SignInButtonEnableChangedState
                ? state.isEnabled
                : false,
            onTap: () {
              FocusScope.of(context).unfocus();
              bloc.add(SignInTappedEvent());
            },
          );
        },
      ),
    );
  }

  Widget _createNoAccountText(BuildContext context) {
    final bloc = BlocProvider.of<SignInBloc>(context);
    return Center(
      child: RichText(
          text: TextSpan(
        text: TextConstants.doNotHaveAnAccount,
        style: TextStyle(
          color: AppColors.welcometextColor,
          fontSize: 18,
        ),
        children: [
          TextSpan(
              text: TextConstants.signup,
              style: TextStyle(
                  color: AppColors.textColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  bloc.add(SignUpTappedEvent());
                })
        ],
      )),
    );
  }
}
