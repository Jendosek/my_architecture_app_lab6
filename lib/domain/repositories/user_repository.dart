import '../entities/user.dart';

abstract class UserRepository {
  Future<User> getUser(int id);

  Future<User> login(String email, String password);
}