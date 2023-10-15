import 'package:logger/logger.dart';
// この中に書いてあるプロパティは、ログの出力方法を設定するためのものです。
final logger = Logger(
  printer: PrettyPrinter(
    methodCount: 0,// メソッドの呼び出し履歴を出力する際のメソッドの数
    errorMethodCount: 8,// エラー時のメソッドの数
    lineLength: 120,// 1行の最大文字数
    colors: true,// ログの色付け
    printEmojis: true,// 絵文字の使用
    printTime: false,// 時間の表示
  ),
);