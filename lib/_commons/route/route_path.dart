enum RoutePath {
  start(path: '/', name: 'home'),
  demo(path: '/', name: 'home'); // 最後の箇所には、`;`をつける

  const RoutePath({required this.path, required this.name});
  final String path;
  final String name;
}
