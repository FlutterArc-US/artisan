const diConfigFileContent = '''
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:logger/logger.dart' as _i20;

import '../../helpers/network_call_helper/http_network_call_helper_impl.dart'
    as _i25;
import '../../helpers/network_call_helper/network_call_helper.dart' as _i24;
import '../../helpers/persistence/persistence_helper.dart' as _i26;
import '../../helpers/persistence/persistence_helper_imp.dart' as _i27;
import 'di.dart' as _i21;

extension GetItInjectableX on _i1.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.lazySingleton<_i20.Logger>(() => _i21.LoggerImp());
    gh.lazySingleton<_i24.NetworkCallHelper>(
        () => _i25.HttpNetworkCallHelperImpl(logger: gh<_i20.Logger>()));
    gh.singleton<_i26.PersistenceHelper>(_i27.PersistenceHelperImpl());
    return this;
  }
}
''';
