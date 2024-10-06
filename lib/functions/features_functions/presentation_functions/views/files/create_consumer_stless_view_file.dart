import 'package:artisan/extensions/naming_conventions_extension.dart';

String consumerStlessViewFile(String viewName, String featureName) {
  final viewContent = '''
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ${viewName.toPascalCase()}View extends ConsumerWidget {
  const ${viewName.toPascalCase()}View({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Container(
        width: 1.sw,
        height: 1.sh,
        color: Colors.indigoAccent,
        child: const Placeholder(),
      ),
    );
  }
}
''';

  return viewContent;
}
