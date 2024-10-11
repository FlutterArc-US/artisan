import 'package:artisan/extensions/color_print_extension.dart';
import 'package:artisan/extensions/naming_conventions_extension.dart';
import 'package:artisan/features/create_feature.dart';
import 'package:artisan/features/data/datasources/function/create_data_source_impl_function.dart';
import 'package:artisan/features/data/models/functions/create_model_function.dart';
import 'package:artisan/features/data/repositories/functions/create_repository_impl_function.dart';
import 'package:artisan/features/domain/data/function/create_data_source_function.dart';
import 'package:artisan/features/domain/entities/functions/create_entity_function.dart';
import 'package:artisan/features/domain/repositories/functions/create_repository_function.dart';
import 'package:artisan/features/domain/usecases/functions/create_usecase_function.dart';
import 'package:artisan/features/presentation/providers/functions/create_future_notifier_provider_function.dart';
import 'package:artisan/features/presentation/providers/functions/create_future_variable_provider_function.dart';
import 'package:artisan/features/presentation/providers/functions/create_notifier_provider_function.dart';
import 'package:artisan/features/presentation/providers/functions/create_variable_provider_function.dart';
import 'package:artisan/features/presentation/views/functions/create_consumer_stful_view_function.dart';
import 'package:artisan/features/presentation/views/functions/create_consumer_stless_view_function.dart';
import 'package:artisan/features/presentation/views/functions/create_stful_view_function.dart';
import 'package:artisan/features/presentation/views/functions/create_stless_view_function.dart';
import 'package:artisan/features/presentation/widgets/function/create_widget_function.dart';
import 'package:artisan/init/init.dart';
import 'package:artisan/utils/functions/add_github_workflow.dart';

void main(List<String> args) {
  if (args.isEmpty) {
    "No command provided.".printBoldRed();
    return;
  }

  final command = args[0];
  switch (command) {
    case 'init':
      init();
      "Initializing project...".printBoldGreen();
      break;
    case 'create:feature':
      if (args.length > 1) {
        createFeature(args[1]);
        "Feature ${args[1]} created successfully.".printBoldGreen();
      } else {
        "Please provide a feature name.".printBoldRed();
      }
      break;

    case 'create:workflow':
      createGitHubWorkflow();
      "GitHub workflow created successfully.".printBoldGreen();
      break;

    case 'create:widget':
      if (args.length > 2) {
        createWidget(args[1], args[2]);
        "Widget ${args[1]} created successfully for feature ${args[2]}."
            .printBoldGreen();
      } else {
        "Please provide a widget name and feature name.".printBoldRed();
      }
      break;

    case 'create:usecase':
      if (args.length > 2) {
        final usecaseName = args[1];
        final featureName = args[2];
        String datasourceType = 'default'; // Default to local repository

        // Check for optional parameters
        if (args.contains('--local')) {
          datasourceType = 'local';
        } else if (args.contains('--remote')) {
          datasourceType = 'remote';
        } else if (args.contains('--both')) {
          datasourceType = 'both';
        }

        switch (datasourceType) {
          case 'local':
            createUsecase(usecaseName, featureName, true);
            createRepository(
                usecaseName: usecaseName,
                featureName: featureName,
                datasourceName: featureName);
            createRepositoryImpl(
                usecaseName: usecaseName,
                featureName: featureName,
                datasourceName: featureName);
            createDatasource(
                usecaseName: usecaseName,
                featureName: featureName,
                datasourceName: featureName);
            createDatasourceImp(
                usecaseName: usecaseName,
                featureName: featureName,
                datasourceName: featureName);
            'Local use case $usecaseName created successfully for $featureName.'
                .printBoldGreen();
            break;

          case 'remote':
            createUsecase(usecaseName, featureName, false);
            createRepository(
                usecaseName: usecaseName,
                featureName: featureName,
                datasourceName: 'RemoteDatasource');
            createRepositoryImpl(
                usecaseName: usecaseName,
                featureName: featureName,
                datasourceName: 'RemoteDatasource');
            createDatasource(
                usecaseName: usecaseName,
                featureName: featureName,
                datasourceName: 'RemoteDatasource');
            createDatasourceImp(
                usecaseName: usecaseName,
                featureName: featureName,
                datasourceName: 'RemoteDatasource');
            'Remote use case $usecaseName created successfully for $featureName.'
                .printBoldGreen();
            break;

          default:
            createUsecase(usecaseName, featureName, true); // Default to local
            createRepository(
                usecaseName: usecaseName,
                featureName: featureName,
                datasourceName: featureName);
            createRepositoryImpl(
                usecaseName: usecaseName,
                featureName: featureName,
                datasourceName: featureName);
            createDatasource(
                usecaseName: usecaseName,
                featureName: featureName,
                datasourceName: featureName);
            createDatasourceImp(
                usecaseName: usecaseName,
                featureName: featureName,
                datasourceName: featureName);
            'Use case $usecaseName created successfully for $featureName (default to local).'
                .printBoldGreen();
            break;
        }
      } else {
        "Please provide a use case name and feature name.".printBoldRed();
      }
      break;

    case 'create:model':
      if (args.length > 2) {
        createModel(args[1], args[2]);
        createEntity(args[1], args[2]);
        "Model ${args[1]} created successfully for feature ${args[2]}."
            .printBoldGreen();
      } else {
        "Please provide a valid model name and feature name.".printBoldRed();
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
          bool hasInvalidFlag = args.any((arg) =>
              arg.startsWith('--') &&
              !['--vp', '--fvp', '--np', '--fnp'].contains(arg));

          if (hasInvalidFlag) {
            'Invalid command. Please use one of the following commands:'
                .printRed();
            '''
  dart run artisan create:provider ProviderName MyFeature   (creates variable provider)
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
            createStatelessView(viewName, featureName);
            'Stateless view created successfully for $viewName (default).'
                .printBoldGreen();
            break;
        }
      } else {
        "Please provide a valid view name and feature name.".printBoldRed();
      }
      break;

    default:
      "Invalid command: $command.".printBoldRed();
  }
}
