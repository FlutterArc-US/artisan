library artisan;

import 'package:artisan/init/init.dart';
import 'package:artisan/make/make.dart';
import 'package:flutter/services.dart';


void main(List<String> arguments) {
  var command = arguments.join(' ');
  if (arguments.isEmpty) {
    print('Please provide a command.');
    return;
  }

  if ((!command.contains(':') || !command.contains('on')) &&
      command != 'init') {
    print('Invalid Command $command');
    return;
  }

  try {
    var commandType = command.split(':').first;
    command = command.split(':').last;

    /// [Command Types]
    if (commandType == 'make') {
      makeFile(command);
    } else if (commandType == 'init') {

      init();
    } else {
      print('Invalid Command $command');
      return;
    }
  } catch (e) {
    print('Invalid Command ${arguments.join()}');
  }
}
