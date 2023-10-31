import 'dart:convert';

import 'package:clean_architecture_app/_commons/logger.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:clean_architecture_app/domain/entities/user.dart';

abstract class UserRepository {
  Future<void> createUser(User user);
  Future<List<User>> getUsers(); // getUserから変更し、引数を削除
}

class UserRepositoryImpl implements UserRepository {
  @override
  Future<void> createUser(User user) async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost:3000/users/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(user.toJson()), // 'user'ラッパーを削除
      );
      logger.i('レスポンスコード: ${response.statusCode}');
    } catch (e) {
      logger.e('例外処理が発生: $e');
    }
  }

  @override
  Future<List<User>> getUsers() async { // getUserから変更し、引数を削除
    try {
      final response = await http.get(Uri.parse('http://localhost:3000/users/'));
      logger.i('レスポンスコード: ${response.statusCode}');
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((element) => User.fromJson(element)).toList();
    } catch (e) {
      logger.e('例外処理が発生: $e');
      throw Exception('データの取得中にエラーが発生しました: $e');
    }
  }
}

final userRepositoryImplProvider = Provider((ref) => UserRepositoryImpl());