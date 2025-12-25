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

  Map<String, MessageModel> conversationSummaries() {
    return _repo.conversationSummaries();
  }

  Future<void> sendMessage(String userId, MessageModel message) async {
    await _repo.sendMessage(userId, message);
    messages.add(message);
    notifyListeners();

    // fetch a remote reply and append
    final reply = await _repo.fetchRemoteReply(userId);
    if (reply != null) {
      messages.add(reply);
      notifyListeners();
    }
  }
}
