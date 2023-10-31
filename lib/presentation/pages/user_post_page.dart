import 'package:clean_architecture_app/commons/theme.dart';
import 'package:clean_architecture_app/domain/entities/user.dart';
import 'package:clean_architecture_app/domain/provider/user_future_provider.dart';
import 'package:clean_architecture_app/domain/usecase/user_async_notifier.dart';
import 'package:clean_architecture_app/presentation/widgets/appbar_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UserPostPage extends HookConsumerWidget {
  const UserPostPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final firstNameController = useTextEditingController();
    final lastNameController = useTextEditingController();
    final ageController = useTextEditingController();
    ref.listen<AsyncValue<void>>(userAsyncNotifierProvider, (pref, next) {
      if (next is AsyncError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: ThemeColor.scarlet,
            content: Text(next.error.toString()),
          ),
        );
      }
    });
    return Scaffold(
        appBar: const ApplicationBar(
            'APIのデータを表示', ThemeColor.turquoise, ThemeColor.turquoiseAccent),
        body: Center(
          child: Column(
            children: [
              TextFormField(
                controller: lastNameController,
                decoration: const InputDecoration(
                  hintText: '苗字を入力してください',
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: firstNameController,
                decoration: const InputDecoration(
                  hintText: '名前を入力してください',
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: ageController,
                decoration: const InputDecoration(
                  hintText: '年齢を入力してください',
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  try {
                    final user = User(
                      firstName: firstNameController.text,
                      lastName: lastNameController.text,
                      age: int.parse(ageController.text),
                    );
                    await ref
                        .read(userAsyncNotifierProvider.notifier)
                        .createUser(user);
                    ref.invalidate(getUserProvider);
                  } catch (e) {
                    if (e is FormatException) {
                      // ageController.textが正しい整数として解析できない場合の処理
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('年齢が正しく入力されていません！'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    } else {
                      // 他の予期しない例外の処理
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('エラーが発生しました: $e'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  }
                },
                child: const Text(('送信')),
              ),
            ],
          ),
        ));
  }
}
