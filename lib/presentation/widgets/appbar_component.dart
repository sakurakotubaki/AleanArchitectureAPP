import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ApplicationBar extends HookConsumerWidget implements PreferredSizeWidget {
  const ApplicationBar(this.title, this.color, this.titleColor, {Key? key}) : super(key: key);
  final String title;
  final Color titleColor;
  final Color color;

  @override
  Size get preferredSize => const Size.fromHeight(50);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      titleSpacing: 0.0, // タイトルの左右の余白
      title: Text(title, style: TextStyle(color: titleColor)),
      backgroundColor: color,
    );
  }
}
