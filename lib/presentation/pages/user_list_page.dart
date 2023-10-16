import 'package:clean_architecture_app/commons/route/route_path.dart';
import 'package:clean_architecture_app/commons/theme.dart';
import 'package:clean_architecture_app/domain/provider/user_future_provider.dart';
import 'package:clean_architecture_app/presentation/widgets/appbar_component.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UserListPage extends HookConsumerWidget {
  const UserListPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final users = ref.watch(getUserProvider);
    return Scaffold(
      appBar: const ApplicationBar(
          'APIのデータを表示', ThemeColor.turquoise, ThemeColor.turquoiseAccent),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  context.goNamed(RoutePath.post.path);
                },
                child: const Text('保存ページへ')),
            const SizedBox(height: 10),
            Expanded(
              child: users.when(
                data: (config) {
                  return ListView.builder(
                    itemCount: config.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        child: ListTile(
                          title: Text(config[index].firstName),
                          subtitle: Text(config[index].lastName),
                        ),
                      );
                    },
                  );
                },
                error: (error, stackTrace) =>
                    Center(child: Text(error.toString())),
                loading: () => const Center(child: CircularProgressIndicator()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
