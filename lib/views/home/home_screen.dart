import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sivi_chat/views/home/top_tab_switcher.dart';
import '../../core/constants/app_strings.dart';
import '../users/users_list_page.dart';
import '../chats/chat_history_page.dart';
import '../../viewmodels/users_viewmodel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);
    _controller.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _showAddUserDialog() async {
    final ctrl = TextEditingController();
    final res = await showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add user'),
          content: TextField(
            controller: ctrl,
            decoration: const InputDecoration(hintText: 'Name'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, ctrl.text.trim()),
              child: const Text('Add'),
            ),
          ],
        );
      },
    );

    if (res != null && res.isNotEmpty) {
      if (!mounted) return;
      await context.read<UsersViewModel>().addUser(res);
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('User added: $res')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              title: const Text(AppStrings.appName),
              centerTitle: true,
              floating: true,
              snap: true,
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(30),
                child: Container(
                  color: Colors.white,
                  alignment: Alignment.center,
                  child: TopTabSwitcher(controller: _controller),
                ),
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _controller,
          children: const [UsersListPage(), ChatHistoryPage()],
        ),
      ),
      floatingActionButton: _controller.index == 0
          ? FloatingActionButton(
              onPressed: _showAddUserDialog,
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}
