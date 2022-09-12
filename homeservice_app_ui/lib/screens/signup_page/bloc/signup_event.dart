part of 'signup_bloc.dart';

abstract class SignUpEvent {}

class SignUpTappedEvent extends SignUpEvent {}

class SignInTappedEvent extends SignUpEvent {}

class OnTextChangedEvent extends SignUpEvent {}