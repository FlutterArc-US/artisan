import 'dart:io';

import 'package:flutter/services.dart';

init() async {
  final a = await rootBundle.load('lib');
  print(a.toString());
}
