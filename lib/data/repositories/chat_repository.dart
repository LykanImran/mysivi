import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/message_model.dart';

class ChatRepository {
  final Map<String, List<MessageModel>> _conversations = {};

  Future<List<MessageModel>> fetchMessages(String userId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return _conversations[userId] ?? _generateSample(userId);
  }

  /// Fetches a remote reply from an open API and returns it as a MessageModel.
  Future<MessageModel?> fetchRemoteReply(String userId) async {
    try {
      final res = await http.get(
        Uri.parse('https://jsonplaceholder.typicode.com/comments?postId=1'),
      );
      if (res.statusCode == 200) {
        final list = jsonDecode(res.body) as List<dynamic>;
        if (list.isNotEmpty) {
          final idx = DateTime.now().millisecondsSinceEpoch % list.length;
          final item = list[idx] as Map<String, dynamic>;
          final text = (item['body'] as String?) ?? '...';
          final msg = MessageModel(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            senderId: userId,
            content: text,
            timestamp: DateTime.now(),
            isMe: false,
          );
          final conv = _conversations.putIfAbsent(
            userId,
            () => <MessageModel>[],
          );
          conv.add(msg);
          return msg;
        }
      }
    } catch (_) {
      // ignore network errors for now
    }
    return null;
  }

  /// Returns a map of userId to last message for chat history.
  Map<String, MessageModel> conversationSummaries() {
    final Map<String, MessageModel> out = {};
    _conversations.forEach((k, v) {
      if (v.isNotEmpty) out[k] = v.last;
    });
    return out;
  }

  Future<void> sendMessage(String userId, MessageModel message) async {
    final conv = _conversations.putIfAbsent(userId, () => <MessageModel>[]);
    conv.add(message);
    await Future.delayed(const Duration(milliseconds: 50));
  }

  List<MessageModel> _generateSample(String userId) {
    final now = DateTime.now();
    final sample = [
      MessageModel(
        id: 'm1',
        senderId: userId,
        content: 'Hello from $userId!',
        timestamp: now.subtract(const Duration(minutes: 5)),
      ),
      MessageModel(
        id: 'm2',
        senderId: 'me',
        content: 'Hi there!',
        timestamp: now.subtract(const Duration(minutes: 4)),
        isMe: true,
      ),
    ];
    _conversations[userId] = sample;
    return sample;
  }
}
