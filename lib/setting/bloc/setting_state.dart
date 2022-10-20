part of 'setting_bloc.dart';

abstract class SettingState extends Equatable {
  const SettingState();

  @override
  List<Object> get props => [];
}

class SettingInitial extends SettingState {}

class SettingLoadingState extends SettingState {}

class SettingsLoaded extends SettingState {
  const SettingsLoaded({required this.settings});
  final SavedAppSettings settings;

  @override
  List<Object> get props => [settings];
}

class SettingLoadedError extends SettingState {
  const SettingLoadedError({required this.error});
  final String error;
}
