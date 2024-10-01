import 'dart:developer';

import 'package:artisan/functions/add_github_workflow.dart';
import 'package:artisan/functions/create_feature.dart';
import 'package:artisan/functions/create_view.dart'; // Import the createView function
import 'package:artisan/init/init.dart';

void main(List<String> args) {
  if (args.isEmpty) {
    log("No command provided.");
    return;
  }

  final command = args[0];
  switch (command) {
    case 'init':
      init();
      log("Initializing project...");
      break;
    case 'create:feature':
      if (args.length > 1) {
        createFeature(args[1]);
      } else {
        log("Please provide a feature name.");
      }
      break;

    case 'create:workflow':
      createGitHubWorkflow();
      break;

    case 'create:view':
      if (args.length > 2) {
        createView(args[1], args[2]); // Pass the view name and feature name
      } else {
        log("Please provide a view name and feature name.");
      }
      break;

    default:
      log("Invalid Command: $command");
  }
}
