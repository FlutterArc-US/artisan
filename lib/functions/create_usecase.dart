import 'dart:io';

import 'package:artisan/extensions/clickable_string_console_path.dart';
import 'package:artisan/extensions/color_print_extension.dart';
import 'package:artisan/extensions/naming_conventions_extension.dart';
import 'package:artisan/files/usecase_file.dart';

/// [Make Usecase]
void createUsecase(String usecaseName, String featureName, bool onlyUsecase) {
  final fileAddress = 'lib/features/$featureName/domain/usecases';

  var directory = Directory(fileAddress);
  if (!directory.existsSync()) {
    directory.createSync(recursive: true);
  }

  // Your logic to generate the model file
  var content = onlyUsecase
      ? onlyUsecaseFile(usecaseName, featureName)
      : usecaseFile(usecaseName, featureName);

  // Create the file
  var file = File("$fileAddress/${usecaseName.toSnakeCase}_usecase.dart");
  file.writeAsStringSync(content);

  'Usecase $usecaseName created successfully!'.printBoldGreen();
}
