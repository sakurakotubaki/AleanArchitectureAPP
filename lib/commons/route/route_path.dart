enum RoutePath {
  // demo(path: '/', name: 'home'),
  post(path: 'post', name: 'post'),
  get(path: '/', name: 'get'); // 最後の箇所には、`;`をつける

  const RoutePath({required this.path, required this.name});
  final String path;
  final String name;
}
