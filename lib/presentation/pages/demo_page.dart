import 'dart:convert';

import 'package:clean_architecture_app/commons/theme.dart';
import 'package:clean_architecture_app/presentation/widgets/appbar_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart';

class DemoPage extends HookConsumerWidget {
  const DemoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final zipCodeController = useTextEditingController();
    final addressController = useTextEditingController();

    return Scaffold(
      appBar: const ApplicationBar(
          '郵便番号を検索', ThemeColor.scarlet, ThemeColor.scarletAccent),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 400,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  hintText: '郵便番号',
                ),
                maxLength: 7,
                onChanged: (value) async {
                  // 入力された文字数が7以外なら終了
                  if (value.length != 7) {
                    return;
                  }
                  final address = await zipCodeToAddress(value);
                  // 返ってきた値がnullなら終了
                  if (address == null) {
                    return;
                  }
                  // 住所が帰ってきたら、addressControllerの中身を上書きする。
                  addressController.text = address;
                },
                controller: zipCodeController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: '住所',
                ),
                controller: addressController,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
// 郵便番号から住所を取得する関数
Future<String?> zipCodeToAddress(String zipCode) async {
  if (zipCode.length != 7) {
    return null;
  }
  final response = await get(
    Uri.parse(
      'https://zipcloud.ibsnet.co.jp/api/search?zipcode=$zipCode',
    ),
  );
  // 正常なステータスコードが返ってきているか
  if (response.statusCode != 200) {
    return null;
  }
  // ヒットした住所はあるか
  final result = jsonDecode(response.body);
  if (result['results'] == null) {
    return null;
  }
  final addressMap =
      (result['results'] as List).first; // 結果が2つ以上のこともあるが、簡易的に最初のひとつを採用することとする。
  final address =
      '${addressMap['address1']} ${addressMap['address2']} ${addressMap['address3']}'; // 住所を連結する。
  return address;
}