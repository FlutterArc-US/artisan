import 'package:artisan/extensions/naming_conventions_extension.dart';

String createWidgetFile(String widgetName) {
  final widgetContent = '''
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class ${widgetName.toPascalCase()}Widget extends StatelessWidget {
  const ${widgetName.toPascalCase()}Widget({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      height: 1.sh,
      color: Colors.indigoAccent,
      child: const Placeholder(),
    );
  }
}
''';
  return widgetContent;
}
