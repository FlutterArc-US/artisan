import 'dart:developer';

import 'package:artisan/functions/create_feature.dart';

void main(List<String> args) {
  if (args.isEmpty) {
    print("No command provided. Use 'make:feature' to create a feature.");
    return;
  }

  final command = args[0];
  final name = args.length > 1 ? args[1] : null;

  switch (command) {
    case 'make:feature':
      if (name != null) {
        createFeature(name);
      } else {
        log("Please provide a feature name.");
      }
      break;
    default:
      log("Invalid Command: $command");
  }
}
