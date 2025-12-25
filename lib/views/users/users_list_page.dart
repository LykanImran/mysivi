import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/users_viewmodel.dart';
import '../../widgets/user_tile.dart';
import '../chats/chat_screen.dart';

class UsersListPage extends StatefulWidget {
  const UsersListPage({Key? key}) : super(key: key);

  @override
  State<UsersListPage> createState() => _UsersListPageState();
}

class _UsersListPageState extends State<UsersListPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UsersViewModel>().loadUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<UsersViewModel>();
    if (vm.loading) return const Center(child: CircularProgressIndicator());

    return ListView.builder(
      itemCount: vm.users.length,
      itemBuilder: (context, index) {
        final u = vm.users[index];
        return UserTile(
          name: u.name,
          id: u.id,
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => ChatScreen(userId: u.id, userName: u.name),
            ),
          ),
        );
      },
    );
  }
}
