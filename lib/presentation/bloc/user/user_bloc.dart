import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_app/domain/use_cases/delete_usecase/delete_usecase.dart';
import 'package:flutter_chat_app/domain/use_cases/get_usecase/get_all_users_usecase.dart';
import 'package:flutter_chat_app/domain/use_cases/get_usecase/get_update_user_usecase.dart';
import 'package:flutter_chat_app/presentation/bloc/user/user_event.dart';
import 'package:flutter_chat_app/presentation/bloc/user/user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final GetAllUsersUseCase getAllUsersUsecase;
  final GetUpdateUserUseCase getUpdateUserUseCase;
  final DeleteUserUseCase getDeleteUserUseCase;

  UserBloc(
      {required this.getAllUsersUsecase,
      required this.getUpdateUserUseCase,
      required this.getDeleteUserUseCase})
      : super(UserInitialState()) {
    on<GetUsersEvent>((event, emit) async {
      try {
        emit(UserLoadingState(isLoading: true));
        final streamResponse = getAllUsersUsecase.call();
        await for (final users in streamResponse) {
          emit(UserSuccessfulState(users: users));
        }
      } on SocketException catch (e) {
        emit(UserFailureState(e.toString()));
      } catch (e) {
        emit(UserFailureState(e.toString()));
        rethrow;
      }
    });
    on<UpdateUserEvent>((event, emit) async {
      try {
        emit(UserLoadingState(isLoading: true));
        await getUpdateUserUseCase.call(event.user);
        // emit(UserSuccessfulState(users: users));
      } on SocketException catch (e) {
        emit(UserFailureState(e.toString()));
      } catch (e) {
        emit(UserFailureState(e.toString()));
        rethrow;
      }
    });
    on<DeleteUserEvent>((event, emit) async {
      try {
        emit(UserLoadingState(isLoading: true));
        await getDeleteUserUseCase.call(event.uid);
        // emit(UserSuccessfulState(users: users));
      } on SocketException catch (e) {
        emit(UserFailureState(e.toString()));
      } catch (e) {
        emit(UserFailureState(e.toString()));
        rethrow;
      }
    });
  }
}
