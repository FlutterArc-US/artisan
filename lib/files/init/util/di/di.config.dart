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
import 'package:logger/logger.dart' as _i8;

import '../../helpers/biometric_auth/biometric_auth.dart' as _i3;
import '../../helpers/biometric_auth/local_auth_biometric_helper.dart' as _i4;
import '../../helpers/google_auth/google_auth.dart' as _i5;
import '../../helpers/google_auth/google_auth_helper.dart' as _i6;
import '../../helpers/image_picker/image_picker.dart' as _i7;
import '../../helpers/image_picker/usecases/pick_camera_image_usecase.dart'
    as _i14;
import '../../helpers/image_picker/usecases/pick_gallery_image_usecase.dart'
    as _i15;
import '../../helpers/image_picker/usecases/pick_multi_images_usecase.dart'
    as _i16;
import '../../helpers/network_call_helper/http_network_call_helper_impl.dart'
    as _i11;
import '../../helpers/network_call_helper/network_call_helper.dart' as _i10;
import '../../helpers/persistance/persistance_helper.dart' as _i12;
import '../../helpers/persistance/persistance_helper_imp.dart' as _i13;
import 'di.dart' as _i9;

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
    gh.lazySingleton<_i3.BiometricAuth>(() => _i4.LocalAuthBiometricHelper());
    gh.lazySingleton<_i5.GoogleAuth>(() => _i6.GoogleAuthHelper());
    gh.lazySingleton<_i7.ImagePickerHelper>(
        () => _i7.ImagePickerImagePickerHelper());
    gh.lazySingleton<_i8.Logger>(() => _i9.LoggerImp());
    gh.lazySingleton<_i10.NetworkCallHelper>(
        () => _i11.HttpNetworkCallHelperImpl(logger: gh<_i8.Logger>()));
    gh.singleton<_i12.PersistanceHelper>(_i13.PersistanceHelperImpl());
    gh.lazySingleton<_i14.PickCameraImageUsecase>(
        () => _i14.PickCameraImageUsecase(image: gh<_i7.ImagePickerHelper>()));
    gh.lazySingleton<_i15.PickGalleryImageUsecase>(
        () => _i15.PickGalleryImageUsecase(image: gh<_i7.ImagePickerHelper>()));
    gh.lazySingleton<_i16.PickMultiGalleryImagesUsecase>(() =>
        _i16.PickMultiGalleryImagesUsecase(image: gh<_i7.ImagePickerHelper>()));
    return this;
  }
}
