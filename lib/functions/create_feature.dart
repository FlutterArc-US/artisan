import 'dart:developer';
import 'dart:io';

import 'package:artisan/functions/create_data_layer.dart';
import 'package:artisan/functions/create_domain_layer.dart';
import 'package:artisan/functions/create_presentation_layer.dart';

/// Function to create a feature with the specified structure.
void createFeature(String featureName) {
  log("Creating feature: $featureName");

  final featureDir = Directory('lib/features/$featureName');
  if (!featureDir.existsSync()) {
    featureDir.createSync(recursive: true);
    log('Feature folder created at lib/features/$featureName');

    createDataLayer(featureName);
    createDomainLayer(featureName);
    createPresentationLayer(featureName);

    log('Feature $featureName created successfully.');
  } else {
    log('Feature folder already exists.');
  }
}
