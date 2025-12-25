import 'package:flutter/foundation.dart';
import '../data/models/message_model.dart';
import '../data/repositories/chat_repository.dart';

class ChatViewModel extends ChangeNotifier {
  final ChatRepository _repo;
  List<MessageModel> messages = [];
  bool loading = false;

  ChatViewModel({ChatRepository? repository})
    : _repo = repository ?? ChatRepository();

  Future<void> loadMessages(String userId) async {
    loading = true;
    notifyListeners();
    messages = await _repo.fetchMessages(userId);
    loading = false;
    notifyListeners();
  }

  Future<void> sendMessage(String userId, MessageModel message) async {
    await _repo.sendMessage(userId, message);
    messages.add(message);
    notifyListeners();
  }
}
