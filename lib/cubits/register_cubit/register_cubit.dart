import 'package:chat_app/cubits/register_cubit/register_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterCubit extends Cubit<RegisterState>{
  RegisterCubit():super(RegisterInitial());

  Future<void> registerUser({required String email,required String password}) async {
    emit(RegisterLoading());
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email ,password: password
      );
      emit(RegisterSuccess());

    } on FirebaseAuthException catch(e)
    {
      if (e.code == 'weak-password') {
        emit(RegisterFailure('Weak password'));

      } else if (e.code == 'email-already-in-use') {
        emit(RegisterFailure('Email is used'));

      }
    }
    on Exception catch (e) {
      emit(RegisterFailure("something went wrong"));

    }
  }

}