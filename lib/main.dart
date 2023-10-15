import 'package:clean_architecture_app/_commons/route/router.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends HookConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: ref.watch(routerProvider),
      title: 'Flutter Demo',
      theme: ThemeData(
          // テーマを使ってAppBar全体にスタイルを適用する.
          appBarTheme: const AppBarTheme(
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.normal,
        ),
        centerTitle: true,
      )),
    );
  }
}
