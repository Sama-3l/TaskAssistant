part of 'change_date_cubit.dart';

@immutable
sealed class ChangeDateState {}

final class ChangeDateInitial extends ChangeDateState {}

final class OnDateChange extends ChangeDateState {}
