library artisan;

import 'package:artisan/add/color.dart';
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

  if (command.startsWith('add')) {
    final addRunes = command.split(':').last.trim();

    final addItem = addRunes.split(' ').first;

    if (addItem == 'color') {
      try {
        final colorAndCode = addRunes.split(' ');
        addColor(colorAndCode[1], colorAndCode.last);
        return;
      } catch (e) {
        print('Invalid Command $command');
        return;
      }
    } else {
      print('Invalid Command $command');
      return;
    }
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
