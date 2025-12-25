import 'package:flutter/material.dart';
import '../../core/constants/app_strings.dart';
import '../users/users_list_page.dart';
import '../chats/chat_history_page.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.appName),
          bottom: const TabBar(
            tabs: [
              Tab(text: AppStrings.usersTab),
              Tab(text: AppStrings.chatsTab),
            ],
          ),
        ),
        body: const TabBarView(children: [UsersListPage(), ChatHistoryPage()]),
      ),
    );
  }
}
