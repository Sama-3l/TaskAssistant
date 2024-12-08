import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'change_date_state.dart';

class ChangeDateCubit extends Cubit<ChangeDateState> {
  ChangeDateCubit() : super(ChangeDateInitial());

  onChangeDate() => emit(OnDateChange());
}
