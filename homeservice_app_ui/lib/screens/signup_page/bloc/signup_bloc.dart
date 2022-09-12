import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:homeservice_app_ui/core/services/auth_services.dart';
import 'package:homeservice_app_ui/core/services/validation_service.dart';

part 'signup_state.dart';
part 'signup_event.dart';


class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpInitial());

  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool isButtonEnabled = false;

  Stream<SignUpState> mapEventToState(SignUpEvent event) async* {
    if (event is OnTextChangedEvent) {
      if (isButtonEnabled != checkIfSignUpButtonEnabled()) {
        isButtonEnabled = checkIfSignUpButtonEnabled();
        yield SignUpButtonEnabledChangedState(isEnabled: isButtonEnabled);
      }
    } else if (event is SignUpTappedEvent) {
      if (checkValidatorsOfTextField()) {
        try {
          yield LoadingState();
          await AuthService.signUp(emailController.text,
              passwordController.text, userNameController.text);
          yield NextTabBarPageState();
          print('Go to the next page');
        } catch (e) {
          yield ErrorState(message: e.toString());
        }
      } else {
        yield ShowErrorState();
      }
    } else if (event is SignInTappedEvent) {
      yield NextSignInPageState();
    }
  }

  bool checkIfSignUpButtonEnabled() {
    return userNameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        confirmPasswordController.text.isNotEmpty;
  }

  bool checkValidatorsOfTextField() {
    return ValidationService.username(userNameController.text) &&
        ValidationService.email(emailController.text) &&
        ValidationService.password(passwordController.text) &&
        ValidationService.confirmPassword(
            passwordController.text, confirmPasswordController.text);
  }
}
