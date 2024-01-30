import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_app/domain/enitities/user_entity.dart';
import 'package:flutter_chat_app/domain/use_cases/auth_usecase/sign_up_usecase.dart';
import 'package:flutter_chat_app/domain/use_cases/get_usecase/get_create_current_user_use_case.dart';
import 'package:flutter_chat_app/presentation/bloc/signup/signup_event.dart';
import 'package:flutter_chat_app/presentation/bloc/signup/signup_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final SignUpUseCase signUpUseCase;
  final GetCreateCurrentUserUseCase getCreateCurrentUserUseCase;

  SignUpBloc({required this.signUpUseCase, required this.getCreateCurrentUserUseCase})
      : super(SignUpInitialState()) {
    on<SignUpInitialEvent>((event, emit) async {
      try {
        emit(SignUpLoadingState(isLoading: true));
        await signUpUseCase.call(UserEntity(
            email: event.email,
            password: event.password,
            name: event.name));
        await getCreateCurrentUserUseCase.call(UserEntity(
            email: event.email,
            password: event.password,
            name: event.name));
        emit(SignUpSuccessfulState());
      } on SocketException catch (e) {
        emit(SignUpFailureState(e.toString()));
      } catch (e) {
        emit(SignUpFailureState(e.toString()));
        rethrow;
      }
    });
  }
}
