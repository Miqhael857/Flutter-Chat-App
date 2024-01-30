import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_chat_app/data/datasources/firebase_remote_data_source_impl.dart';
import 'package:flutter_chat_app/data/datasources/firebase_remote_datasource.dart';
import 'package:flutter_chat_app/data/repositories/auth_repository_impl.dart';
import 'package:flutter_chat_app/domain/enitities/user_entity.dart';
import 'package:flutter_chat_app/domain/repositories/firebase_repository.dart';
import 'package:flutter_chat_app/domain/use_cases/auth_usecase/export.dart';
import 'package:flutter_chat_app/domain/use_cases/delete_usecase/delete_usecase.dart';
import 'package:flutter_chat_app/domain/use_cases/get_usecase/get_all_users_usecase.dart';
import 'package:flutter_chat_app/domain/use_cases/get_usecase/get_messages_usecase.dart';
import 'package:flutter_chat_app/domain/use_cases/get_usecase/get_update_user_usecase.dart';
import 'package:flutter_chat_app/domain/use_cases/send_text_message.dart';
import 'package:flutter_chat_app/presentation/bloc/chat/chat_bloc.dart';
import 'package:flutter_chat_app/presentation/bloc/signin/signin_bloc.dart';
import 'package:flutter_chat_app/presentation/bloc/signout/sign_out_bloc.dart';
import 'package:flutter_chat_app/presentation/bloc/signup/signup_bloc.dart';
import 'package:flutter_chat_app/presentation/bloc/user/user_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'domain/use_cases/get_usecase/get_create_current_user_use_case.dart';
import 'domain/use_cases/get_usecase/get_current_uid_usecase.dart';

final sl = GetIt.instance;
Future<void> init() async {
  //Bloc
  sl.registerFactory<SignUpBloc>(() => SignUpBloc(
        signUpUseCase: sl.call(),
        getCreateCurrentUserUseCase: sl.call(),
      ));
  sl.registerFactory<SignInBloc>(() => SignInBloc(
        signInUseCase: sl.call(),
      ));

  sl.registerFactory<UserBloc>(() => UserBloc(
        getAllUsersUsecase: sl.call(),
        getDeleteUserUseCase: sl.call(),
        getUpdateUserUseCase: sl.call(),
      ));
  sl.registerFactory<ChatBloc>(() => ChatBloc(
        getMessageUseCase: sl.call(),
        sendTextMessageUseCase: sl.call(),
      ));

  sl.registerFactory<SignOutBloc>(() => SignOutBloc(
        signOutUseCase: sl.call(),
      ));


  // UseCases
  sl.registerLazySingleton<GoogleSignInUseCase>(
      () => GoogleSignInUseCase(repository: sl.call()));
  sl.registerLazySingleton<ForgotPasswordUseCase>(
      () => ForgotPasswordUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetCreateCurrentUserUseCase>(
      () => GetCreateCurrentUserUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetCurrentUIDUseCase>(
      () => GetCurrentUIDUseCase(repository: sl.call()));
  // sl.registerLazySingleton<IsSignInUseCase>(
  //     () => IsSignInUseCase(repository: sl.call()));
  sl.registerLazySingleton<SignInUseCase>(
      () => SignInUseCase(repository: sl.call()));
  sl.registerLazySingleton<SignUpUseCase>(
      () => SignUpUseCase(repository: sl.call()));
  sl.registerLazySingleton<SignOutUseCase>(
      () => SignOutUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetAllUsersUseCase>(
      () => GetAllUsersUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetUpdateUserUseCase>(
      () => GetUpdateUserUseCase(repository: sl.call()));
  sl.registerLazySingleton<DeleteUserUseCase>(
      () => DeleteUserUseCase(repository: sl.call()));
  sl.registerLazySingleton<SendTextMessageUseCase>(
      () => SendTextMessageUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetMessageUseCase>(
      () => GetMessageUseCase(repository: sl.call()));

  // Repository
  sl.registerLazySingleton<FirebaseRepository>(
      () => AuthRepositoryImpl(remoteDataSource: sl.call()));

  // Remote Datasource
  sl.registerLazySingleton<FirebaseRemoteDataSource>(
      () => FirebaseRemoteDataSourceImpl(sl.call(), sl.call(), sl.call()));

  // External
  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  const UserEntity users = UserEntity();

  sl.registerLazySingleton(() => auth);
  sl.registerLazySingleton(() => firestore);
  sl.registerLazySingleton(() => googleSignIn);
  sl.registerLazySingleton(() => users);
}
