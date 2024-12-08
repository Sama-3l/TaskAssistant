import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'mark_completed_state.dart';

class MarkCompletedCubit extends Cubit<MarkCompletedState> {
  MarkCompletedCubit() : super(MarkCompletedInitial());

  onMark() => emit(MarkState());
}
