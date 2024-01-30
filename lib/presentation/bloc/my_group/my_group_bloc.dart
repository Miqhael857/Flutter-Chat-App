import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_app/domain/use_cases/join_usecase/join_chat_message_usecase.dart';
import 'package:flutter_chat_app/domain/use_cases/update_usecase/update_data_firestore_use_case.dart';
import 'package:flutter_chat_app/presentation/bloc/my_group/my_group_event.dart';
import 'package:flutter_chat_app/presentation/bloc/my_group/my_group_state.dart';

class MyGroupBloc extends Bloc<MyGroupEvent, MyGroupState> {
  final JoinChatMessageUseCase joinChatMessageUseCase;
  final UpdateDataFirestoreUseCase updateDataFirestoreUseCase;

  MyGroupBloc({
    required this.joinChatMessageUseCase,
    required this.updateDataFirestoreUseCase,
  }) : super(MyGroupInitialState()) {
    on<JoinMyGroupEvent>((event, emit) async {
      try {
        emit(MyGroupLoadingState(isLoading: true));
        await joinChatMessageUseCase.call(event.groupChatId);
        // emit(MyGroupSuccessfulState(chatMessages: MyGroups));
      } on SocketException catch (e) {
        emit(MyGroupFailureState(e.toString()));
      } catch (e) {
        emit(MyGroupFailureState(e.toString()));
        rethrow;
      }
    });
    on<UpdateDataFirestoreEvent>((event, emit) async {
      try {
        emit(MyGroupLoadingState(isLoading: true));
        await updateDataFirestoreUseCase.call(
          event.collectionPath,
          event.docPath,
          event.dataNeedUpdate,
        );
        // emit(MyGroupSuccessfulState(MyGroups: MyGroups));
      } on SocketException catch (e) {
        emit(MyGroupFailureState(e.toString()));
      } catch (e) {
        emit(MyGroupFailureState(e.toString()));
        rethrow;
      }
    });
  }
}
