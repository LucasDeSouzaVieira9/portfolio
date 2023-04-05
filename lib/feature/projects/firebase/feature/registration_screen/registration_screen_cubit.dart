import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:portfolio/feature/projects/firebase/data/auth/auth_repository.dart';
import 'package:portfolio/feature/projects/firebase/feature/registration_screen/registration_screen_state.dart';
import 'package:portfolio/feature/projects/firebase/model/user_model.dart';

@injectable
class RegistrationScreenCubit extends Cubit<RegistrationScreenState> {
  RegistrationScreenCubit() : super(const RegistrationScreenInitialState());

  final AuthRepository _repository = AuthRepository();

  Future<void> registration(UserModel user, String password) async {
    try {
      emit(const RegistrationScreenLoadingState());
      final resultUser = await _repository.registration(user, password);
      await _repository.saveUser(resultUser);
      emit(const RegistrationScreenSuccessState());
    } catch (e) {
      var errorMessage = 'unknown error';
      if (e is FirebaseAuthException && e.message != null) {
        errorMessage = e.message!;
      }
      emit(RegistrationScreenErrorState(errorMessage: errorMessage));
    }
  }
}
