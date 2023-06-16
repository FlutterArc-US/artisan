import 'package:injectable/injectable.dart';

import '../../../infrastructure/usecase.dart';
import '../../../infrastructure/usecase_input.dart';
import '../image_picker.dart';

@lazySingleton
class PickMultiGalleryImagesUsecase implements Usecase<NoInput, List<String>> {
  final ImagePickerHelper _image;

  PickMultiGalleryImagesUsecase({required ImagePickerHelper image})
      : _image = image;

  @override
  Future<List<String>> call(NoInput input) async {
    return await _image.multiGalleryImages();
  }
}
