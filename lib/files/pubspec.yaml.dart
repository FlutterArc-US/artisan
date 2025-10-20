const pubspecFile = '''
name: artisan_project
description: Flutter project initialized with Artisan (updated).
publish_to: "none"

version: 1.0.0+1

environment:
  sdk: ">=3.3.0 <4.0.0"

dependencies:
  flutter:
    sdk: flutter
  flutter_localizations:
    sdk: flutter

  # Core & UI
  cupertino_icons: ^1.0.8
  flutter_screenutil: ^5.9.3
  shimmer: ^3.0.0
  flutter_svg: ^2.0.4
  lottie: ^3.1.2
  font_awesome_flutter: ^10.8.0
  animated_flip_counter: ^0.3.4
  pinput: ^5.0.0
  google_fonts: ^6.2.1

  # Router
  go_router: ^16.2.1

  # Riverpod
  flutter_riverpod: ^3.0.2
  riverpod_annotation: ^3.0.2

  # Dependency Injection
  get_it: ^8.0.2
  injectable: ^2.1.0

  # Database / Storage
  hive_flutter: ^1.1.0
  shared_preferences: ^2.5.1

  # Networking
  http: ^1.2.2
  connectivity_plus: ^7.0.0

  # Firebase
  firebase_core: ^4.1.0
  firebase_remote_config: ^6.0.1

  # Permissions & Device
  permission_handler: ^12.0.0+1
  device_info_plus: ^12.1.0
  path_provider: ^2.1.4
  open_file: ^3.5.10
  flutter_image_compress: ^2.3.0

  # Utilities
  intl: ^0.20.2
  intl_utils: ^2.8.7
  url_launcher: ^6.3.0
  cached_network_image: ^3.4.1
  fluttertoast: ^9.0.0
  logger: ^2.4.0
  flutter_keyboard_visibility: ^6.0.0
  add_2_calendar: ^3.0.1
  share_plus: ^12.0.0
  flutter_local_notifications: ^19.2.1

dev_dependencies:
  flutter_test:
    sdk: flutter

  flutter_lints: ^6.0.0
  build_runner: ^2.5.4
  riverpod_generator: ^3.0.2
  injectable_generator: ^2.7.0
  flutter_gen_runner: ^5.3.2

  # Artisan Integration
  artisan:
    git:
      url: https://github.com/Wolfiz-2-0/artisan
      ref: Artisan_Beta

flutter_gen:
  output: lib/gen/
  line_length: 80
  integrations:
    flutter_svg: true

flutter:
  uses-material-design: true
  assets:
    - assets/svgs/
    - assets/pngs/
    - assets/lottie/
    - assets/fonts/

  fonts:
    - family: Montserrat
      fonts:
        - asset: assets/fonts/Montserrat-Regular.ttf
        - asset: assets/fonts/Montserrat-Medium.ttf
          weight: 500
        - asset: assets/fonts/Montserrat-SemiBold.ttf
          weight: 600
        - asset: assets/fonts/Montserrat-Bold.ttf
          weight: 700
''';