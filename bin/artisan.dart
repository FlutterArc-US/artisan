import 'dart:developer';

import 'package:artisan/extensions/color_print_extension.dart';
import 'package:artisan/functions/add_github_workflow.dart';
import 'package:artisan/functions/features_functions/create_feature.dart';
import 'package:artisan/functions/features_functions/presentation_functions/create_consumer_stful_view.dart';
import 'package:artisan/functions/features_functions/presentation_functions/create_consumer_stless_view.dart';
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

    /// [Create Page View]
    case 'create:view':
      if (args.length > 2) {
        final viewName = args[1];
        final featureName = args[2];

        // Check for specific commands and execute appropriate function
        if (args.contains('--stful')) {
          createStatefulView(viewName, featureName); // Creates Stateful Widget
          'Stateful view created successfully for $viewName.'.printBoldGreen();
        } else if (args.contains('--stless')) {
          createStatelessView(
              viewName, featureName); // Creates Stateless Widget
          'Stateless view created successfully for $viewName.'.printBoldGreen();
        } else if (args.contains('--cstful')) {
          createConsumerStatefulView(
              viewName, featureName); // Creates Consumer Stateful Widget
          'Consumer stateful view created successfully for $viewName.'
              .printBoldGreen();
        } else if (args.contains('--cstless')) {
          createConsumerStatelessView(
              viewName, featureName); // Creates Consumer Stateless Widget
          'Consumer stateless view created successfully for $viewName.'
              .printBoldGreen();
        } else {
          // Default to Stateless Widget if no option is provided
          createStatelessView(viewName, featureName);
          'Stateless view created successfully for $viewName (default).'
              .printBoldGreen();
        }
      } else {
        // Show error message if insufficient arguments are provided
        'Error: Please provide both a view name and feature name.'.printRed();
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
      // Handle invalid commands and show available options
      'Invalid command. Please use one of the following commands:'.printRed();
      '''
  dart run artisan create:view MyView MyFeature          (creates default stateless view)
  dart run artisan create:view MyView MyFeature --stless (creates stateless view)
  dart run artisan create:view MyView MyFeature --stful  (creates stateful view)
  dart run artisan create:view MyView MyFeature --cstless (creates consumer stateless view)
  dart run artisan create:view MyView MyFeature --cstful  (creates consumer stateful view)
  '''
          .printBoldGreen();
      break;
  }
}
