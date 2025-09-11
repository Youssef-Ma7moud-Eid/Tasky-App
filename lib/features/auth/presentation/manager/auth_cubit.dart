import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/core/services/cache_helper.dart';
import 'package:tasky/features/auth/data/firebase/auth_firebase_operation.dart';
import 'package:tasky/features/auth/presentation/manager/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(InitialAuthState());

  static AuthCubit get(context) => BlocProvider.of(context);

  Future<void> checkSignin(String emal, String pass, String userName) async {
    emit(LoadingAuthState());
    try {
      await AuthFirebaseOperation.signUp(
        email: emal,
        password: pass,
        username: userName,
      );
      await CacheHelper().saveData(key: 'NewUser', value: true);
      emit(SuccessAuthState());
    } catch (e) {
      emit(FailureAuthState(message: e.toString()));
    }
  }

  Future<void> checkLogin(String emal, String pass) async {
    emit(LoadingAuthState());
    try {
      await AuthFirebaseOperation.login(emal, pass);

      emit(SuccessAuthState());
    } catch (e) {
      emit(FailureAuthState(message: e.toString()));
    }
  }

  Future<void> logout() async {
    emit(LogoutLoadingState());
    dynamic check = await AuthFirebaseOperation.logout();
    if (check == true) {
      await CacheHelper().removeData(key: 'NewUser');
      emit(LogoutSuccessState());
    } else {
      emit(LogoutFauilreState(message: 'Error in Logout from Account'));
    }
  }
}
