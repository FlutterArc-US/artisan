import 'dart:io';

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
  var file = File("$fileAddress/$usecaseName.dart");
  file.writeAsStringSync(content);

  print('Usecase $usecaseName created successfully!');
}
