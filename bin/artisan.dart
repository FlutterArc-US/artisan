import 'dart:developer';

import 'package:artisan/extensions/color_print_extension.dart';
import 'package:artisan/functions/add_github_workflow.dart';
import 'package:artisan/functions/features_functions/create_feature.dart';
import 'package:artisan/functions/features_functions/presentation_functions/views/create_consumer_stful_view.dart';
import 'package:artisan/functions/features_functions/presentation_functions/create_consumer_stless_view.dart';
import 'package:artisan/functions/features_functions/presentation_functions/providers/create_provider.dart';
import 'package:artisan/functions/features_functions/presentation_functions/views/create_stful_view.dart';
import 'package:artisan/functions/features_functions/presentation_functions/create_stless_view.dart'; // Import the createView function
import 'package:artisan/functions/features_functions/presentation_functions/widgets/create_widget.dart';
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

    /// [Create Page View]
    case 'create:view':
      if (args.length > 2) {
        final viewName = args[1];
        final featureName = args[2];
        String viewType = 'default'; // Default to stateless view

        // Check for optional parameters for the type of view to create
        if (args.contains('--stful')) {
          viewType = 'stateful';
        } else if (args.contains('--stless')) {
          viewType = 'stateless';
        } else if (args.contains('--cstful')) {
          viewType = 'consumer_stateful';
        } else if (args.contains('--cstless')) {
          viewType = 'consumer_stateless';
        } else {
          // Check if any other argument starting with `--` is provided (i.e., an invalid flag)
          bool hasInvalidFlag = args.any((arg) =>
              arg.startsWith('--') &&
              !['--stful', '--stless', '--cstful', '--cstless'].contains(arg));

          if (hasInvalidFlag) {
            // Invalid flag detected, print error message
            'Invalid command. Please use one of the following commands:'
                .printRed();
            '''
  dart run artisan create:view MyView MyFeature          (creates default stateless view)
  dart run artisan create:view MyView MyFeature --stless (creates stateless view)
  dart run artisan create:view MyView MyFeature --stful  (creates stateful view)
  dart run artisan create:view MyView MyFeature --cstless (creates consumer stateless view)
  dart run artisan create:view MyView MyFeature --cstful  (creates consumer stateful view)
  '''
                .printBoldGreen();
            return;
          }
        }

        // Switch case to handle different view types
        switch (viewType) {
          case 'stateful':
            createStatefulView(viewName, featureName);
            'Stateful view created successfully for $viewName.'
                .printBoldGreen();
            break;

          case 'stateless':
            createStatelessView(viewName, featureName);
            'Stateless view created successfully for $viewName.'
                .printBoldGreen();
            break;

          case 'consumer_stateful':
            createConsumerStatefulView(viewName, featureName);
            'Consumer stateful view created successfully for $viewName.'
                .printBoldGreen();
            break;

          case 'consumer_stateless':
            createConsumerStatelessView(viewName, featureName);
            'Consumer stateless view created successfully for $viewName.'
                .printBoldGreen();
            break;

          default:
            createStatelessView(
                viewName, featureName); // Default to stateless view
            'Stateless view created successfully for $viewName (default).'
                .printBoldGreen();
            break;
        }
      } else {
        // Show error message if insufficient arguments are provided
        'Error: Please provide both a view name and feature name.'.printRed();
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
