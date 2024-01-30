


import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_app/domain/use_cases/auth_usecase/sign_out_usecase.dart';
import 'package:flutter_chat_app/presentation/bloc/signout/sign_out_event.dart';
import 'package:flutter_chat_app/presentation/bloc/signout/sign_out_state.dart';

class SignOutBloc extends Bloc<SignOutEvent, SignOutState> {
  final SignOutUseCase signOutUseCase;

  SignOutBloc({required this.signOutUseCase}) : super(SignOutInitialState()) {
    on<SignOutInitialEvent>((event, emit) async {
      try {
        emit(SignOutLoadingState(isLoading: true));
        await signOutUseCase.call();
        emit(SignOutSuccessfulState());
      } on SocketException catch (e) {
        emit(SignOutFailureState(e.toString()));
      } catch (e) {
        emit(SignOutFailureState(e.toString()));
      }
    });
  }
}
