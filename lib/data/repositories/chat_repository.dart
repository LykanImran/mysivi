import '../models/message_model.dart';

class ChatRepository {
  final Map<String, List<MessageModel>> _conversations = {};

  Future<List<MessageModel>> fetchMessages(String userId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return _conversations[userId] ?? _generateSample(userId);
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
