import 'package:clean_architecture_app/_commons/route/route_path.dart';
import 'package:clean_architecture_app/presentation/pages/user_list_page.dart';
import 'package:clean_architecture_app/presentation/pages/user_post_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'router.g.dart';

// riverpod generateでプロバイダーを生成
@riverpod
GoRouter router(RouterRef ref) {
  return GoRouter(
      routes: [
        GoRoute(
            path: RoutePath.get.path,
            name: RoutePath.get.name,
            builder: (context, state) => const UserListPage(),
            routes: [
              GoRoute(
                path: RoutePath.post.path,
                name: RoutePath.post.name,
                builder: (context, state) => const UserPostPage(),
              ),
            ]),
      ],
      // 404ページを指定
      errorPageBuilder: (context, state) {
        return const MaterialPage(
            child: Scaffold(
          body: Center(
            child: Text('404 Not Found', style: TextStyle(fontSize: 24)),
          ),
        ));
      });
}
