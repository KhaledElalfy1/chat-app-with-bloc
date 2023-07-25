import 'package:chat_app/cubits/login_cubit/login_states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState>{
  LoginCubit():super(LoginInitial());

  Future<void> userSignin({required String email,required String password}) async {
    emit(LoginLoading());
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email ,password: password
      );
      emit(LoginSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(LoginFailure('User not found'));
      } else if (e.code == 'wrong-password') {
        emit(LoginFailure('wrong password'));
      }
    }
    on Exception catch (e) {
      emit(LoginFailure('Something went wrong'));
    }
  }

}