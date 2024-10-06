import 'package:artisan/extensions/naming_conventions_extension.dart';

String statefulViewFile(String viewName, String featureName) {
  final viewContent = '''
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ${viewName.toPascalCase()}View extends StatefulWidget {
  const ${viewName.toPascalCase()}View({super.key});

  @override
  State<${viewName.toPascalCase()}View> createState() => _${viewName.toPascalCase()}ViewState();
}

class _${viewName.toPascalCase()}ViewState extends State<${viewName.toPascalCase()}View> {
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
