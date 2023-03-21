import 'package:freezed_annotation/freezed_annotation.dart';

part 'registration_screen_state.freezed.dart';

@freezed
class RegistrationScreenState with _$RegistrationScreenState {
  const factory RegistrationScreenState.initial() =
      RegistrationScreenInitialState;
  const factory RegistrationScreenState.loading() =
      RegistrationScreenLoadingState;
  const factory RegistrationScreenState.success() =
      RegistrationScreenSuccessState;
  const factory RegistrationScreenState.error({required String errorMessage}) =
      RegistrationScreenErrorState;
}
