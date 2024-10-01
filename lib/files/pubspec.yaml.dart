const pubspecFile = '''
description: A new Flutter project.

publish_to: "none" # Remove this line if you wish to publish to pub.dev

version: 1.0.0+1

environment:
  sdk: ">=3.3.0 <4.0.0"

dependencies:
  flutter:
    sdk: flutter
  flutter_localizations:
    sdk: flutter
    
  intl_utils: ^2.8.7

  cupertino_icons: ^1.0.2
  go_router: ^14.2.7
  freezed_annotation: ^2.2.0
  json_annotation: ^4.8.0
  flutter_screenutil: ^5.7.0

  #Riverpod
  flutter_riverpod: ^2.5.1
  riverpod_annotation: ^2.3.5

  #DI
  get_it: ^7.2.0
  injectable: ^2.1.0

  #Flutter SVG
  flutter_svg: ^2.0.4

  #DB
  hive_flutter: ^1.1.0
  hive_generator: ^2.0.1

  #Network
  http: ^1.2.2

  #Information
  logger: ^2.4.0

  #toast
  fluttertoast: ^8.2.1

  #image
  cached_network_image: ^3.2.3
  shimmer: ^3.0.0
  flutter_keyboard_visibility: ^6.0.0
  pinput: ^5.0.0
  permission_handler: ^11.3.1
  image_picker: ^1.1.2
  easy_date_timeline: ^1.0.3
  geocoding: ^3.0.0
  geolocator: ^13.0.1
  google_maps_flutter: ^2.2.8
  google_places_flutter: ^2.0.9
  url_launcher: ^6.3.0
  fl_chart: ^0.69.0
  flutter_animate: ^4.5.0
  intl: ^0.19.0
  primer_progress_bar: ^0.5.0
  csv: ^6.0.0
  excel: ^4.0.6
  share_plus: ^10.0.0
  file_picker: ^8.0.7
  google_fonts: ^6.2.1
  firebase_core: ^3.6.0
  
  
dev_dependencies:
  flutter_test:
    sdk: flutter

  flutter_lints: ^5.0.0
  build_runner: ^2.4.13
  freezed: ^2.3.2
  riverpod_generator: ^2.4.3
  injectable_generator: ^2.1.4
  json_serializable: ^6.6.1

  artisan:
    git:
      url: https://github.com/Wolfiz-2-0/artisan
      ref: beta

  flutter_gen_runner: ^5.3.2
  custom_lint: ^0.6.2

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
