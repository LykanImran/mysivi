import 'package:flutter/foundation.dart';
import '../data/models/user_model.dart';
import '../data/repositories/user_repository.dart';

class UsersViewModel extends ChangeNotifier {
  final UserRepository _repo;
  List<UserModel> users = [];
  bool loading = false;

  UsersViewModel({UserRepository? repository})
    : _repo = repository ?? UserRepository();

  Future<void> loadUsers() async {
    loading = true;
    notifyListeners();
    users = await _repo.fetchUsers();
    loading = false;
    notifyListeners();
  }

  Future<void> addUser(String name) async {
    final u = await _repo.addUser(name);
    users.insert(0, u);
    notifyListeners();
  }
}
