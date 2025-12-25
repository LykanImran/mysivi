import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sivi_chat/data/models/user_model.dart';
import '../../viewmodels/chat_viewmodel.dart';
import '../../viewmodels/users_viewmodel.dart';
// user model imported via relative path below
import '../chats/chat_screen.dart';
import '../../core/utils/date_utils.dart';

class ChatHistoryPage extends StatefulWidget {
  const ChatHistoryPage({super.key});

  @override
  State<ChatHistoryPage> createState() => _ChatHistoryPageState();
}

class _ChatHistoryPageState extends State<ChatHistoryPage>
    with AutomaticKeepAliveClientMixin<ChatHistoryPage> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final chatVm = context.watch<ChatViewModel>();
    final usersVm = context.watch<UsersViewModel>();
    final summaries = chatVm.conversationSummaries();

    if (summaries.isEmpty) return const Center(child: Text('No chats yet'));

    final entries = summaries.entries.toList();

    return ListView.builder(
      key: const PageStorageKey('chat_history'),
      itemCount: entries.length,
      itemBuilder: (context, index) {
        final userId = entries[index].key;
        final last = entries[index].value;
        final user = usersVm.users.firstWhere(
          (u) => u.id == userId,
          orElse: () => UserModel(id: userId, name: userId),
        );
        final name = user.name;

        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            leading: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [Color(0xFF00A1FF), Color(0xFF7B61FF)],
                ),
              ),
              child: Center(
                child: Text(
                  name.isNotEmpty ? name[0] : '?',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
            title: Text(
              name,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: Text(
              last.content,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  DateUtilsExt.formatTime(last.timestamp),
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(height: 6),
                const CircleAvatar(
                  radius: 10,
                  child: Text('1', style: TextStyle(fontSize: 12)),
                ),
              ],
            ),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => ChatScreen(userId: userId, userName: name),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
