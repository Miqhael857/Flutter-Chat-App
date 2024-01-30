import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_app/data/datasources/firebase_remote_data_source_impl.dart';
import 'package:flutter_chat_app/firebase_options.dart';
import 'package:flutter_chat_app/presentation/bloc/chat/chat_bloc.dart';
import 'package:flutter_chat_app/presentation/bloc/signin/signin_bloc.dart';
import 'package:flutter_chat_app/presentation/bloc/signout/sign_out_bloc.dart';
import 'package:flutter_chat_app/presentation/bloc/signup/signup_bloc.dart';
import 'package:flutter_chat_app/presentation/bloc/user/user_bloc.dart';
import 'package:flutter_chat_app/presentation/screen/signup/sign_up_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'locator_service.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) =>
          FirebaseRemoteDataSourceImpl(sl.call(), sl.call(), sl.call()),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<SignUpBloc>(
            create: (_) => sl<SignUpBloc>(),
          ),
          BlocProvider<SignInBloc>(
            create: (_) => sl<SignInBloc>(),
          ),
          BlocProvider<UserBloc>(
            create: (_) => sl<UserBloc>(),
          ),
          BlocProvider<ChatBloc>(
            create: (_) => sl<ChatBloc>(),
          ),
          BlocProvider<SignOutBloc>(
            create: (_) => sl<SignOutBloc>(),
          ),
        ],
        child: ScreenUtilInit(
          designSize: const Size(390, 844),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: '/',
            title: 'Flutter Demo',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            home: const SignUpPage(),
          ),
        ),
      ),
    );
  }
}
