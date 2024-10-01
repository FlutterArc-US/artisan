import 'dart:developer';
import 'dart:io';

import 'package:artisan/files/analysis_options.yaml.dart';

Future<void> addAnalysisOptions() async {
  log("Adding analysis_options.yaml");
  final analysisOptionsExisting =
      File("${Directory.current.path}/analysis_options.yaml");
  final lines = analysisOptionsExisting.readAsLinesSync();
  final contents = '${lines.first}\n$analysisOptionsFile';
  analysisOptionsExisting.writeAsStringSync(contents);
  log("Added analysis_options.yaml");
}
