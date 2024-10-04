import 'dart:developer';

import 'package:artisan/functions/add_github_workflow.dart';
import 'package:artisan/functions/features_functions/create_feature.dart';
import 'package:artisan/functions/features_functions/presentation_functions/create_provider.dart';
import 'package:artisan/functions/features_functions/presentation_functions/create_stful_view.dart';
import 'package:artisan/functions/features_functions/presentation_functions/create_stless_view.dart'; // Import the createView function
import 'package:artisan/functions/features_functions/presentation_functions/create_widget.dart';
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

    ///[Create Page View]
    case 'create:view':
      if (args.length > 2) {
        final viewName = args[1];
        final featureName = args[2];

        // Check for optional parameter for Stateful/Stateless
        if (args.contains('--stful')) {
          createStatefulView(viewName, featureName); // Create Stateful Widget
        } else {
          // Default case for Stateless widget or if --stls is passed
          createStatelessView(viewName, featureName); // Create Stateless Widget
        }
      } else {
        log("Please provide a view name and feature name.");
      }
      break;

    case 'create:widget':
      if (args.length > 2) {
        createWidget(args[1], args[2]); // Pass the view name and feature name
      } else {
        log("Please provide a widget name and feature name.");
      }
      break;

    case 'create:provider':
      if (args.length > 2) {
        createProvider(args[1], args[2]); // Pass the view name and feature name
      } else {
        log("Please provide a provider name and feature name.");
      }
      break;

    default:
      log("Invalid Command: $command");
  }
}


