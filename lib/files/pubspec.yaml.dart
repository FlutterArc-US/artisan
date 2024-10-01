const pubspecFile = '''
description: Flutter project with Artisan.

publish_to: "none" # Remove this line if you wish to publish to pub.dev

version: 1.0.0+1

environment:
  sdk: ">=3.3.0 <4.0.0"

dependencies:
  flutter:
    sdk: flutter
    
  flutter_localizations:
    sdk: flutter
 
  cupertino_icons: ^1.0.2
  
  #Router
  go_router: ^14.2.7
  
  #UI
  flutter_screenutil: ^5.7.0
  shimmer: ^3.0.0

  #Riverpod
  flutter_riverpod: ^2.5.1
  riverpod_annotation: ^2.3.5

  #DI
  get_it: ^7.2.0
  injectable: ^2.1.0

  #DB
  hive_flutter: ^1.1.0
  hive_generator: ^2.0.1

  #Network
  http: ^1.2.2
  
  #Firebase
  firebase_core: ^3.6.0

  #Information
  logger: ^2.4.0

  #toast
  fluttertoast: ^8.2.1

  #image
  cached_network_image: ^3.2.3
  image_picker: ^1.1.2
  flutter_svg: ^2.0.4
  
  #Intl Date Formatter
  intl: ^0.19.0
  
  #URL Launcher
  url_launcher: ^6.3.0

  #Permission Handler
  permission_handler: ^11.3.1

  #Google Fonts
  google_fonts: ^6.2.1
  
  #Other Dependencies
  freezed_annotation: ^2.2.0
  flutter_keyboard_visibility: ^6.0.0
  
dev_dependencies:
  flutter_test:
    sdk: flutter

  flutter_lints: ^5.0.0
  build_runner: ^2.4.13
  freezed: ^2.3.2
  riverpod_generator: ^2.4.3
  injectable_generator: ^2.1.4
  json_serializable: ^6.6.1
  flutter_gen_runner: ^5.3.2
  custom_lint: ^0.6.2

  #Artisan Integration
  artisan:
    git:
      url: https://github.com/Wolfiz-2-0/artisan
      ref: beta

flutter_gen:
  output: lib/gen/ # Optional (default: lib/gen/)
  line_length: 80 # Optional (default: 80)

  integrations:
    flutter_svg: true
    
flutter:
  uses-material-design: true
  assets:
    - assets/svgs/
    - assets/pngs/
''';
