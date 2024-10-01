import 'dart:developer';
import 'dart:io';

import 'package:artisan/files/main.yaml.dart';

/// Function to create the GitHub Workflow in the .github/workflows folder.
void createGitHubWorkflow() {
  gitHubWorkflowFile;

  final workflowDir = Directory('.github/workflows');
  if (!workflowDir.existsSync()) {
    workflowDir.createSync(recursive: true);
    print('.github/workflows directory created.');
  } else {
    print('.github/workflows directory already exists.');
  }

  final workflowFile = File('.github/workflows/main.yaml');
  workflowFile.writeAsStringSync(gitHubWorkflowFile);
  log('GitHub workflow file created at .github/workflows/main.yaml');
}
