part of 'setting_bloc.dart';

abstract class SettingEvent extends Equatable {
  const SettingEvent();

  @override
  List<Object> get props => [];
}

class GetSavedSettings extends SettingEvent {}

class UpdateSettingStringValue extends SettingEvent {
  const UpdateSettingStringValue({required this.key, required this.value});
  final String key;
  final String value;

  @override
  List<Object> get props => [key, value];
}

class UpdateSettingIntegerValue extends SettingEvent {
  const UpdateSettingIntegerValue({required this.key, required this.value});
  final String key;
  final int value;

  @override
  List<Object> get props => [key, value];
}
