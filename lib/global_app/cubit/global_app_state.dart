part of 'global_app_cubit.dart';

abstract class GlobalAppState extends Equatable {
  const GlobalAppState();

  @override
  List<Object> get props => [];
}

class GlobalAppInitial extends GlobalAppState {}

class GlobalAppLoadingStarted extends GlobalAppState {}

class GlobalAppScreenLocked extends GlobalAppState {}

class GlobalAppScreenUnlocked extends GlobalAppState {}
