import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_app/core/theme/app_colors.dart';
import 'package:flutter_chat_app/domain/enitities/user_entity.dart';
import 'package:flutter_chat_app/presentation/bloc/user/user_bloc.dart';
import 'package:flutter_chat_app/presentation/bloc/user/user_event.dart';
import 'package:flutter_chat_app/presentation/bloc/user/user_state.dart';
import 'package:flutter_chat_app/presentation/screen/chats/chat_page.dart';
import 'package:flutter_chat_app/presentation/widgets/app_alert.dart';
import 'package:flutter_chat_app/presentation/widgets/app_text.dart';
import 'package:flutter_chat_app/presentation/widgets/utils/build_search_field.dart';
import 'package:flutter_chat_app/presentation/widgets/utils/loaders.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class AllUsersPage extends StatefulWidget {
  const AllUsersPage({super.key});

  @override
  State<AllUsersPage> createState() => _AllUsersPageState();
}

class _AllUsersPageState extends State<AllUsersPage> {
  final _searchTextController = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;

  bool _isSearch = false;

  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    BlocProvider.of<UserBloc>(context).add(GetUsersEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.whiteTextStyle,
        title: _isSearch == false
            ? AppText(
                text: "Chat",
                color: Colors.black,
                fontSize: 30.sp,
                fontWeight: FontWeight.w700,
              )
            : BuildSearchField(
                controller: _searchTextController,
                isSearch: () => _isSearch,
                onChanged: (String value) {
                  setState(() {
                    searchQuery = value;
                  });
                }),
        actions: _isSearch == false
            ? [
                InkWell(
                  onTap: () {
                    setState(
                      () {
                        _isSearch = true;
                      },
                    );
                  },
                  child: const Icon(Icons.search),
                ),
                Gap(11.w),
              ]
            : [
                IconButton(
                  onPressed: () {
                    setState(() {
                      _searchTextController.clear();
                      _isSearch = false;
                    });
                  },
                  icon: const Icon(Icons.clear),
                ),
              ],
      ),
      body: BlocBuilder<UserBloc, UserState>(builder: (context, state) {
        if (state is UserSuccessfulState) {
          List<UserEntity> model = state.users;
          final filteredUsers = _searchTextController.text.isEmpty
              ? model
              : model
                  .where((user) =>
                      user.name
                          .toLowerCase()
                          .contains(_searchTextController.text.toLowerCase()) ||
                      user.email
                          .toLowerCase()
                          .contains(_searchTextController.text.toLowerCase()))
                  .toList();

          final currentUser = auth.currentUser;
          if (currentUser != null) {
            filteredUsers
                .removeWhere((user) => user.email == currentUser.email);
          }
          return ListView.separated(
            itemCount: filteredUsers.length,
            separatorBuilder: (context, index) {
              if (index == filteredUsers.length - 1) {
                return Padding(
                  padding: EdgeInsets.fromLTRB(52.w, 0, 0, 0),
                  child: Divider(
                    height: 10.h,
                  ),
                );
              } else {
                return Padding(
                  padding: EdgeInsets.fromLTRB(100.w, 0, 0, 0),
                  child: const Divider(),
                );
              }
            },
            itemBuilder: (_, index) {
              final user = filteredUsers.elementAt(index);
              return ListTile(
                title: Text(user.name),
                trailing: Text(user.email),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatPage(
                        receiverUserName: user.email,
                        receiverUserID: user.uid,
                      ),
                    ),
                  );
                },
              );
            },
          );
        } else if (state is UserLoadingState) {
          showLoader();
        } else if (state is UserFailureState) {
          hideLoader();
          showErrorDialog(context: context, msg: state.errorMessage);
        }
        return Container();
      }),
    );
  }
}
