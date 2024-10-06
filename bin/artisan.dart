import 'dart:developer';

import 'package:artisan/extensions/color_print_extension.dart';
import 'package:artisan/extensions/naming_conventions_extension.dart';
import 'package:artisan/functions/add_github_workflow.dart';
import 'package:artisan/functions/features_functions/create_feature.dart';
import 'package:artisan/functions/features_functions/presentation_functions/providers/create_future_notifier_provider.dart';
import 'package:artisan/functions/features_functions/presentation_functions/providers/create_future_variable_provider.dart';
import 'package:artisan/functions/features_functions/presentation_functions/providers/create_notifier_provider.dart';
import 'package:artisan/functions/features_functions/presentation_functions/views/create_consumer_stful_view.dart';
import 'package:artisan/functions/features_functions/presentation_functions/providers/create_variable_provider.dart';
import 'package:artisan/functions/features_functions/presentation_functions/views/create_consumer_stless_view.dart';
import 'package:artisan/functions/features_functions/presentation_functions/views/create_stful_view.dart';
import 'package:artisan/functions/features_functions/presentation_functions/views/create_stless_view.dart';
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
        final providerName = args[1];
        final featureName = args[2];
        String providerType = 'default';

        if (args.contains('--vp')) {
          providerType = 'variableProvider';
        } else if (args.contains('--fvp')) {
          providerType = 'futureVariableProvider';
        } else if (args.contains('--np')) {
          providerType = 'notifierProvider';
        } else if (args.contains('--fnp')) {
          providerType = 'futureNotifierProvider';
        } else {
          // Check if any other argument starting with `--` is provided (i.e., an invalid flag)
          bool hasInvalidFlag = args.any((arg) =>
              arg.startsWith('--') &&
              !['--vp', '--fvp', '--np', '--fnp'].contains(arg));

          if (hasInvalidFlag) {
            // Invalid flag detected, print error message
            'Invalid command. Please use one of the following commands:'
                .printRed();
            '''
  dart run artisan create:provider ProviderName MyFeature          (creates variable provider)
  dart run artisan create:provider ProviderName MyFeature --vp (creates variable provider)
  dart run artisan create:provider ProviderName MyFeature --fvp  (creates future variable provider)
  dart run artisan create:provider ProviderName MyFeature --np (creates notifier provider)
  dart run artisan create:provider ProviderName MyFeature --fnp  (creates future notifier provider)
  '''
                .printBoldGreen();
            return;
          }
        }

        switch (providerType) {
          case 'variableProvider':
            createVariableProvider(providerName, featureName);
            'Variable Provider ${providerName.toPascalCase()} created successfully'
                .printBoldGreen();
            break;

          case 'futureVariableProvider':
            createFutureVariableProvider(providerName, featureName);
            'Future Variable Provider ${providerName.toPascalCase()} created successfully'
                .printBoldGreen();
            break;
          case 'notifierProvider':
            createNotifierProvider(providerName, featureName);
            'Notifier Provider ${providerName.toPascalCase()} created successfully'
                .printBoldGreen();
            break;
          case 'futureNotifierProvider':
            createFutureNotifierProvider(providerName, featureName);
            'Future Notifier Provider ${providerName.toPascalCase()} created successfully'
                .printBoldGreen();
            break;
          default:
            createVariableProvider(providerName, featureName);
            'Variable Provider ${providerName.toPascalCase()} created successfully'
                .printBoldGreen();
            break;
        }
      } else {
        'Please provide a valid provider name and feature name.'.printBoldRed();
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
