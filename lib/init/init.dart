import 'package:artisan/functions/add_analysis_option.dart';
import 'package:artisan/functions/add_assets_folder.dart';
import 'package:artisan/functions/add_github_workflow.dart';
import 'package:artisan/functions/add_infrastructure.dart';
import 'package:artisan/functions/add_main.dart';
import 'package:artisan/functions/add_pubspec_yaml.dart';
import 'package:artisan/functions/add_router.dart';
import 'package:artisan/helpers/persistence_helper.dart';

import '../functions/add_di.dart';
import '../helpers/network_call_helper.dart';

Future<void> init() async {
  /// [Add Infrastructure]
  addInfrastructure();

  /// [Add Main]
  addMain();

  /// [Add Pubspec]
  addPubspecYaml();

  /// [Add Assets Folder]
  addAssetsFolder();

  /// [Add Analysis Options]
  addAnalysisOptions();

  /// [Add Common]
  addCommon();

  /// [Add Router]
  addRouter();

  /// [Add persistence Helper]
  addPersistenceHelper();

  /// [Add NetworkCall Helper]
  addNetworkCallHelper();

  /// [Add Di]
  addDi();

  /// [Create GitHub Workflow]
  createGitHubWorkflow();
}
