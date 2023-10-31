import 'package:clean_architecture_app/domain/entities/user.dart';
import 'package:clean_architecture_app/domain/repository/user_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_async_notifier.g.dart';

@riverpod
class UserAsyncNotifier extends _$UserAsyncNotifier {
  @override
  FutureOr<void> build() {
    // 値を返す（返り値が void ならば何もしない）
  }

  Future<void> createUser(User user) async {
    List<String> errors = [];

    if (user.firstName.isEmpty) {
      errors.add('名前が入力されていません!');
    }
    if (user.lastName.isEmpty) {
      errors.add('苗字が入力されていません!');
    }
    if (user.age <= 0) {
      // 0以下の場合
      errors.add('年齢が正しく入力されていません!');
    }

    if (errors.isNotEmpty) {
      state = AsyncError<void>(errors.join('\n'), StackTrace.current);
      return;
    }

    final userRef = ref.read(userRepositoryImplProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => userRef.createUser(user));
  }
}
