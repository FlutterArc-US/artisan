import 'di.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

///[Global Sl]
final sl = GetIt.instance;

@LazySingleton(as: Logger)
class LoggerImp extends Logger {}

@InjectableInit(
  initializerName: 'init', // default
  preferRelativeImports: true, // default
  asExtension: true, // default
)
void configureDependencies() => sl.init();
