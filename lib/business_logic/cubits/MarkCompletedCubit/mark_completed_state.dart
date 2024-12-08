part of 'mark_completed_cubit.dart';

@immutable
sealed class MarkCompletedState {}

final class MarkCompletedInitial extends MarkCompletedState {}

final class MarkState extends MarkCompletedState {}
