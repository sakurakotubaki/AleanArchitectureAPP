import 'package:clean_architecture_app/domain/entities/user.dart';
import 'package:clean_architecture_app/domain/repository/user_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_future_provider.g.dart';

@riverpod
Future<List<User>> getUser(GetUserRef ref) async {
  final userRef = ref.read(userRepositoryImplProvider);
  return await userRef.getUsers();
}
