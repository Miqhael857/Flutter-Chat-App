import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_app/domain/enitities/user_entity.dart';
import 'package:flutter_chat_app/domain/use_cases/auth_usecase/export.dart';
import 'package:flutter_chat_app/presentation/bloc/signin/signin_event.dart';
import 'package:flutter_chat_app/presentation/bloc/signin/signin_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final SignInUseCase signInUseCase;

  SignInBloc({required this.signInUseCase}) : super(SignInInitialState()) {
    on<SignInInitialEvent>((event, emit) async {
      try {
        emit(SignInLoadingState(isLoading: true));
        await signInUseCase.call(UserEntity(
          email: event.email,
          password: event.password,
        ));
        emit(SignInSuccessfulState());
      } on SocketException catch (e) {
        emit(SignInFailureState(e.toString()));
      } catch (e) {
        emit(SignInFailureState(e.toString()));
        rethrow;
      }
    });
  }
}
