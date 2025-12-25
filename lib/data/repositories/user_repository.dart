import '../models/user_model.dart';

class UserRepository {
  // In-memory sample data; replace with network calls as needed.
  final List<UserModel> _users = [
    UserModel(id: '1', name: 'Alice', avatarUrl: null),
    UserModel(id: '2', name: 'Bob', avatarUrl: null),
    UserModel(id: '3', name: 'Charlie', avatarUrl: null),
  ];

  Future<List<UserModel>> fetchUsers() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return List<UserModel>.from(_users);
  }
}
