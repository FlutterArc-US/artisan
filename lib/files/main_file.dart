const mainFile = '''
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import './common/extensions/num.dart';
import './util/router/router.dart';
import './helpers/persistence/persistence_helper.dart';
import './util/di/di.dart';

final navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  await sl<PersistenceHelper>().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      //Add device pixel ratio here
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return const ProviderApp();
      },
    );
  }
}

class ProviderApp extends StatefulWidget {
  const ProviderApp({Key? key}) : super(key: key);

  @override
  State<ProviderApp> createState() => _ProviderAppState();
}

class _ProviderAppState extends State<ProviderApp> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setPadding(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        // You can use the library anywhere in the app even in theme
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: "Inter",
        ),

        routerDelegate: router.routerDelegate,
        routeInformationParser: router.routeInformationParser,
        backButtonDispatcher: router.backButtonDispatcher,
      ),
    );
  }
}

// dart run artisan init
// dart run build_runner watch --delete-conflicting-outputs
// dart run artisan make:model user on auth
// dart run artisan make:usecase login on auth --remote
// dart run artisan make:usecase save_token on auth --local
// dart run artisan assets
// dart run custom_lint

''';
