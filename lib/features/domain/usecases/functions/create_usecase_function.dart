import 'dart:io';

import 'package:artisan/extensions/clickable_string_console_path.dart';
import 'package:artisan/extensions/color_print_extension.dart';
import 'package:artisan/extensions/naming_conventions_extension.dart';
import 'package:artisan/features/create_feature.dart';
import 'package:artisan/features/domain/usecases/files/create_uecase_only_file.dart';
import 'package:artisan/features/domain/usecases/files/create_usecase_file.dart';

void createUsecase(String usecaseName, String featureName, bool onlyUsecase) {
  final fileAddress = 'lib/features/${featureName.toSnakeCase()}/domain/usecases';

  // Ensure the feature directory exists
  if (!Directory(fileAddress).existsSync()) {
    createFeature(featureName);
    'Feature not found. Creating feature: $featureName'.printBoldOrange();
  }

  // Generate the content for the usecase file
  final content = onlyUsecase
      ? onlyUsecaseFile(usecaseName, featureName)
      : usecaseFile(usecaseName, featureName);

  // Define the file path
  final file = File('$fileAddress/${usecaseName.toSnakeCase()}_usecase.dart');

  // Check if the usecase file already exists
  if (file.existsSync()) {
    'Error: Usecase file already exists.'.printBoldRed();
    file.path.printClickablePath();
    return;
  }

  // Write the content to the usecase file
  file.writeAsStringSync(content);

  'Usecase $usecaseName created successfully!'.printBoldGreen();
  file.path.printClickablePath();
}
