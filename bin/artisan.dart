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
      // Handle make:feature
      if (command.startsWith('feature')) {
        final featureName = command.split(' ').last.trim();
        newFeature(featureName);
        return;
      }

      // Handle make:model
      if (command.startsWith('model')) {
        final parts = command.split('on');
        final modelName = parts.first.split(' ').last.trim();
        final featureName = parts.last.trim();
        newModel(modelName, featureName);
        return;
      }

      // Handle make:usecase with optional flags --remote or --local
      if (command.startsWith('usecase')) {
        final parts = command.split('on');
        final useCaseName = parts.first.split(' ').last.trim();
        final featureAndFlags = parts.last.trim();

        final featureName = featureAndFlags.split(' ').first;
        final flags = featureAndFlags.split(' ').skip(1).toList();

        bool isRemote = flags.contains('--remote');
        bool isLocal = flags.contains('--local');

        newUseCase(useCaseName, featureName, isRemote, isLocal);
        return;
      }

      // Fallback to makeFile for other cases
      makeFile(command);
    }
  } catch (e) {
    print('Invalid Command ${arguments.join()}');
  }
}
