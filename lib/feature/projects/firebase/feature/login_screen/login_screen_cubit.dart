import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:portfolio/feature/projects/firebase/data/auth/auth_repository.dart';
import 'package:portfolio/feature/projects/firebase/feature/login_screen/login_screen_state.dart';

@injectable
class LoginScreenCubit extends Cubit<LoginScreenState> {
  LoginScreenCubit() : super(const LoginScreenState.initial());

  final repository = AuthRepository();

  Future<void> login(String email, String password) async {
    try {
      emit(const LoginScreenState.loading());
      await repository.login(email, password);
      emit(const LoginScreenState.success());
    } catch (e) {
      var errorMessage = 'unknown error';
      if (e is FirebaseAuthException && e.message != null) {
        errorMessage = e.message!;
      }
      emit(LoginScreenState.error(errorMessage: errorMessage));
    }
  }
}
