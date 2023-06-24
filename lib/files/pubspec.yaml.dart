const pubspecFile = '''
description: A new Flutter project.

publish_to: "none" # Remove this line if you wish to publish to pub.dev

version: 1.0.0+1

environment:
  sdk: ">=2.19.6 <3.0.0"

dependencies:
  flutter:
    sdk: flutter

  cupertino_icons: ^1.0.2
  go_router: ^6.2.0
  freezed_annotation: ^2.2.0
  json_annotation: ^4.8.0
  flutter_screenutil: ^5.7.0

  #Riverpod
  flutter_riverpod: ^2.3.2

  #DI
  get_it: ^7.2.0
  injectable: ^2.1.0
  flutter_svg: ^2.0.4

  #DB
  hive_flutter: ^1.1.0

  #Network
  http: ^0.13.5

  #Information
  logger: ^1.3.0
  intl: ^0.18.0

  #toast
  fluttertoast: ^8.2.1

  #image
  cached_network_image: ^3.2.3

dev_dependencies:
  flutter_test:
    sdk: flutter

  flutter_lints: ^2.0.0
  build_runner: ^2.3.3
  freezed: ^2.3.2
  injectable_generator: ^2.1.4
  json_serializable: ^6.6.1

  artisan:
    git:
      url: https://github.com/Wolfiz-2-0/artisan

flutter:
  uses-material-design: true
''';
