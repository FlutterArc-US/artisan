import 'dart:developer';

import 'package:artisan/functions/add_github_workflow.dart';
import 'package:artisan/functions/create_feature.dart';

void main(List<String> args) {
  if (args.isEmpty) {
    log("No command provided.");
    return;
  }

  final command = args[0];
  switch (command) {
    case 'make:feature':
      if (args.length > 1) {
        createFeature(args[1]);
      } else {
        log("Please provide a feature name.");
      }
      break;

    case 'make:workflow':
      createGitHubWorkflow();
      break;

    default:
      log("Invalid Command: $command");
  }
}
