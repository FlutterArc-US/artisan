import 'dart:developer';
import 'dart:io';

Future<void> addRouter() async {
  final pathsFile =
      File("${Directory.current.path}/lib/util/router/paths.dart");
  final routerFile =
      File("${Directory.current.path}/lib/util/router/router.dart");

  if (!pathsFile.existsSync()) {
    pathsFile.createSync(recursive: true);
  }

  if (!routerFile.existsSync()) {
    routerFile.createSync(recursive: true);
  }

  const pathsContent = '''
class RoutePaths {
  RoutePaths._();
}
  ''';

  const routerContents = '''
import 'package:go_router/go_router.dart';

final router = GoRouter(
  routes: [],
);
''';

  pathsFile.writeAsStringSync(pathsContent);

  routerFile.writeAsStringSync(routerContents);
  log('Router files created.');
}
