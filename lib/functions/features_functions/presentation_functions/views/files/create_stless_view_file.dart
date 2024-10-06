import 'package:artisan/extensions/naming_conventions_extension.dart';

String statelessViewFile(String viewName, String featureName) {
  final viewContent = '''
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ${viewName.toPascalCase()}View extends StatelessWidget {
  const ${viewName.toPascalCase()}View({super.key});

  @override
  Widget build(BuildContext context) {
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
