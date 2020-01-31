import 'auth_api.dart';

class AuthRepository {

  AuthApi authApi = AuthApi();

  Future signIn(email, password) async => await authApi.signIn(email, password);

  Future signOut() async => await authApi.signOut();
}
