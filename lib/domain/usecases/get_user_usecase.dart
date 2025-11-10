import '../repositories/user_repository.dart';
import '../entities/user.dart';

class GetUserUseCase {
  final UserRepository repository;

  GetUserUseCase(this.repository);

  Future<User> call(int id) async {
    return await repository.getUser(id);
  }
}