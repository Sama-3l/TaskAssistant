part of 'sign_in_switch_cubit.dart';

@immutable
sealed class SignInSwitchState {}

final class SignInSwitchInitial extends SignInSwitchState {}

final class SwitchState extends SignInSwitchState {}
