part of 'homescreen_cubit.dart';

@immutable
sealed class HomescreenState {}

final class HomescreenInitial extends HomescreenState {}
final class SuccesState extends HomescreenState {}
