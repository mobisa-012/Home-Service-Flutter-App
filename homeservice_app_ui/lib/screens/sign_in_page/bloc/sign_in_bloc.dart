import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:homeservice_app_ui/core/services/auth_services.dart';
import 'package:homeservice_app_ui/core/services/validation_service.dart';
import 'package:homeservice_app_ui/screens/sign_in_page/bloc/sign_in_event.dart';
import 'package:homeservice_app_ui/screens/sign_in_page/bloc/sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc() : super(SignInInitial());

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isButtonEnabled = false;

  Stream<SignInState> mapEventToState(
    SignInEvent event,
  ) async* {
    if (event is OnTextChangeEvent) {
      if (isButtonEnabled != _checkIfSignInButtonEnabled()) {
        isButtonEnabled = _checkIfSignInButtonEnabled();
        yield SignInButtonEnableChangedState(isEnabled: isButtonEnabled);
      } 
       }else if (event is SignInTappedEvent) {
        if (_checkValidatorsOfTextField()) {
          try {
            yield LoadingState();
            await AuthService.signIn(
                emailController.text, passwordController.text);
            yield NextTabBarState();
            print('Got to the next page');
          } catch (e) {
            print('E to string: $e');
            yield ErrorState(message: e.toString());
          }
        } else {
          yield ShowErrorState();
        }
      } else if (event is ForgotPasswordEvent) {
        yield NextForgotPasswordPageState();
      } else if (event is SignUpTappedEvent) {
        yield NextSignUpPageState();
      }
    }
    bool _checkIfSignInButtonEnabled() {
      return emailController.text.isNotEmpty &&
          passwordController.text.isNotEmpty;
    }

    bool _checkValidatorsOfTextField() {
      return ValidationService.email(emailController.text) &&
          ValidationService.password(passwordController.text);
    }
  }