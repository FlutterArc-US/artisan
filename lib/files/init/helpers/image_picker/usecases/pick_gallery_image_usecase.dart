import 'package:injectable/injectable.dart';

import '../../../infrastructure/usecase.dart';
import '../../../infrastructure/usecase_input.dart';
import '../image_picker.dart';

@lazySingleton
class PickGalleryImageUsecase implements Usecase<NoInput, String> {
  final ImagePickerHelper _image;

  PickGalleryImageUsecase({required ImagePickerHelper image}) : _image = image;

  @override
  Future<String> call(NoInput imagePath) async {
    return await _image.galleryImage();
  }
}
