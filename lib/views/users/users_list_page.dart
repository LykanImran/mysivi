import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/users_viewmodel.dart';
import '../../widgets/user_tile.dart';
import '../chats/chat_screen.dart';

class UsersListPage extends StatefulWidget {
  const UsersListPage({super.key});

  @override
  State<UsersListPage> createState() => _UsersListPageState();
}

class _UsersListPageState extends State<UsersListPage>
    with AutomaticKeepAliveClientMixin<UsersListPage> {
  String? _selectedUserId;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UsersViewModel>().loadUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final vm = context.watch<UsersViewModel>();
    if (vm.loading) return const Center(child: CircularProgressIndicator());

    return ListView.builder(
      key: const PageStorageKey('users_list'),
      itemCount: vm.users.length,
      itemBuilder: (context, index) {
        final u = vm.users[index];
        final isOnline = index % 3 == 0; // demo online status
        final subtitle = isOnline ? 'Online' : '${(index + 2) * 2} min ago';
        final selected = _selectedUserId == u.id;
        return UserTile(
          name: u.name,
          id: u.id,
          isOnline: isOnline,
          subtitle: subtitle,
          selected: selected,
          onTap: () {
            setState(() => _selectedUserId = u.id);
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => ChatScreen(userId: u.id, userName: u.name),
              ),
            );
          },
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
