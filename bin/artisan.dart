library artisan;

import 'package:artisan/assets/assets.dart';
import 'package:artisan/init/init.dart';
import 'package:artisan/make/make.dart';

void main(List<String> arguments) {
  var command = arguments.join(' ');

  if (arguments.isEmpty) {
    print('Please provide a command.');
    return;
  }

  if (command == 'init') {
    init();
    return;
  }

  if (command == 'assets') {
    assets();
    return;
  }

  if (!command.contains(':') || !command.contains('on')) {
    print('Invalid Command $command');
    return;
  }

  try {
    var commandType = command.split(':').first;
    command = command.split(':').last;

    /// [Command Types]
    if (commandType == 'make') {
      makeFile(command);
    }
  } catch (e) {
    print('Invalid Command ${arguments.join()}');
  }
}
