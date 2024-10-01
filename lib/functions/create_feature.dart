import 'dart:developer';
import 'dart:io';

import 'package:artisan/extensions/color_print_extension.dart';
import 'package:artisan/functions/create_data_layer.dart';
import 'package:artisan/functions/create_domain_layer.dart';
import 'package:artisan/functions/create_presentation_layer.dart';

/// Function to create a feature with the specified structure.
void createFeature(String featureName) {
  "Creating feature: $featureName".printGreen();

  final featureDir = Directory('lib/features/$featureName');
  if (!featureDir.existsSync()) {
    featureDir.createSync(recursive: true);
    'Feature folder created at lib/features/$featureName'.printGreen();

    createDataLayer(featureName);
    createDomainLayer(featureName);
    createPresentationLayer(featureName);

    'Feature $featureName created successfully.'.printGreen();
  } else {
    'Feature folder already exists.'.printRed();
  }
}
