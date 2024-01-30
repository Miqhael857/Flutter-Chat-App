import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_app/domain/use_cases/get_usecase/get_messages_usecase.dart';
import 'package:flutter_chat_app/domain/use_cases/send_text_message.dart';
import 'package:flutter_chat_app/presentation/bloc/chat/chat_event.dart';
import 'package:flutter_chat_app/presentation/bloc/chat/chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final SendTextMessageUseCase sendTextMessageUseCase;
  final GetMessageUseCase getMessageUseCase;

  ChatBloc(
      {required this.sendTextMessageUseCase, required this.getMessageUseCase})
      : super(ChatInitialState()) {
    on<SendMessageEvent>((event, emit) async {
      try {
        emit(ChatLoadingState(isLoading: true));
        await sendTextMessageUseCase.call(event.receiverUserId, event.message);
        // emit(ChatSuccessfulState());
      } on SocketException catch (e) {
        emit(ChatFailureState(e.toString()));
      } catch (e) {
        emit(ChatFailureState(e.toString()));
        rethrow;
      }
    });
    on<GetMessageEvent>((event, emit) async {
      try {
        emit(ChatLoadingState(isLoading: true));
        final streamResponse =
            getMessageUseCase.call(event.userId, event.otherUserId);
        await for (final users in streamResponse) {
          emit(ChatSuccessfulState(users));
        }
      } on SocketException catch (e) {
        emit(ChatFailureState(e.toString()));
      } catch (e) {
        emit(ChatFailureState(e.toString()));
        rethrow;
      }
    });
  }
}
