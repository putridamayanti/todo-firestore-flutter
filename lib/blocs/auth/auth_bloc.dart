import 'package:bloc/bloc.dart';

import 'auth_event.dart';
import 'auth_state.dart';
import 'package:todo_firestore/repositories/auth/auth_repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {

  AuthRepository authRepository = AuthRepository();

  @override
  get initialState => AuthUnloaded();

  @override
  Stream<AuthState> mapEventToState(event) async* {
    if (event is Login) {
      yield AuthLoading();
      final auth = await authRepository.signIn(event.email, event.password);
//      print(auth.us);
      yield AuthSuccess(user: auth);
      if (auth.uid) {

      } else {
        yield AuthError();
      }
    }

    if (event is Logout) {
      final auth = await authRepository.signOut();
      yield LogoutSuccess();
    }
  }
}
