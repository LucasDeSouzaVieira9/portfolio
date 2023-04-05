import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_screen_state.freezed.dart';

@freezed
class LoginScreenState with _$LoginScreenState {
  const factory LoginScreenState.initial() = LoginScreenInitialState;
  const factory LoginScreenState.loading() = LoginScreenLoadingState;
  const factory LoginScreenState.success() = LoginScreenSuccessState;
  const factory LoginScreenState.error({required String errorMessage}) = LoginScreenErrorState;
}
