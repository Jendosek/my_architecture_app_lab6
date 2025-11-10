import '../../domain/repositories/user_repository.dart';
import '../../domain/entities/user.dart';
import '../datasources/local/mock_db.dart';

class MockUserRepositoryImpl implements UserRepository {
  
  @override
  Future<User> login(String email, String password) async {
    await Future.delayed(Duration(seconds: 1));

    try {
      final user = mockUsers.firstWhere(
        (user) => user.email == email,
      );
      if (password == '123456') {
        return user; 
      } else {
        throw Exception('Wrong password');
      }
    } catch (e) {
      throw Exception('User not found');
    }
  }

  @override
  Future<User> getUser(int id) async {
    await Future.delayed(Duration(seconds: 1));

    try {
      final user = mockUsers.firstWhere(
        (user) => user.id == id.toString(),
      );
      return user;
    } catch (e) {
      throw Exception('User not found for id: $id');
    }
  }
}