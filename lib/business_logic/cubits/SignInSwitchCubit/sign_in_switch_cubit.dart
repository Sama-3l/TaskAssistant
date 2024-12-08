import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'sign_in_switch_state.dart';

class SignInSwitchCubit extends Cubit<SignInSwitchState> {
  SignInSwitchCubit() : super(SignInSwitchInitial());

  onSwitchEvent() => emit(SwitchState());
}
