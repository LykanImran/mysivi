import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../viewmodels/chat_viewmodel.dart';
import '../../widgets/chat_bubble.dart';
import '../../data/models/message_model.dart';

class ChatScreen extends StatefulWidget {
  final String userId;
  final String userName;

  const ChatScreen({Key? key, required this.userId, required this.userName})
    : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ChatViewModel>().loadMessages(widget.userId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ChatViewModel>();
    return Scaffold(
      appBar: AppBar(title: Text(widget.userName)),
      body: Column(
        children: [
          Expanded(
            child: vm.loading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    reverse: false,
                    itemCount: vm.messages.length,
                    itemBuilder: (context, index) {
                      final m = vm.messages[index];
                      final avatar = m.isMe
                          ? 'M'
                          : (widget.userName.isNotEmpty
                                ? widget.userName[0]
                                : '?');
                      return ChatBubble(
                        text: m.content,
                        isMe: m.isMe,
                        avatarInitial: avatar,
                        onLongPress: () => _showDefinition(context, m.content),
                      );
                    },
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Type a message...',
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () async {
                    final text = _controller.text.trim();
                    if (text.isEmpty) return;
                    final msg = MessageModel(
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      senderId: 'me',
                      content: text,
                      timestamp: DateTime.now(),
                      isMe: true,
                    );
                    _controller.clear();
                    await vm.sendMessage(widget.userId, msg);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showDefinition(BuildContext context, String message) async {
    final word = message
        .split(RegExp(r"\s+"))[0]
        .replaceAll(RegExp(r"[^a-zA-Z]"), '')
        .toLowerCase();
    final bc = context;
    if (word.isEmpty) {
      showModalBottomSheet(
        context: bc,
        builder: (_) => const Padding(
          padding: EdgeInsets.all(16),
          child: Text('No word found'),
        ),
      );
      return;
    }

    // call dictionaryapi.dev
    final uri = Uri.parse(
      'https://api.dictionaryapi.dev/api/v2/entries/en/$word',
    );
    String result = 'No definition found for "$word"';
    try {
      final res = await http.get(uri);
      if (res.statusCode == 200) {
        final list = jsonDecode(res.body) as List<dynamic>;
        final first = list.first as Map<String, dynamic>;
        final meanings = first['meanings'] as List<dynamic>;
        if (meanings.isNotEmpty) {
          final defs = meanings.first['definitions'] as List<dynamic>;
          if (defs.isNotEmpty) {
            result = defs.first['definition'] as String? ?? result;
          }
        }
      }
    } catch (_) {}

    if (!mounted) return;
    showModalBottomSheet(
      context: bc,
      builder: (_) =>
          Padding(padding: const EdgeInsets.all(16), child: Text(result)),
    );
  }
}
