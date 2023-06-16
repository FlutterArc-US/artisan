import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

abstract class ImagePickerHelper {
  Future<String> cameraImage();
  Future<String> galleryImage();
  Future<List<String>> multiGalleryImages();
}

@LazySingleton(as: ImagePickerHelper)
class ImagePickerImagePickerHelper implements ImagePickerHelper {
  final ImagePicker imagePicker = ImagePicker();
  @override
  Future<List<String>> multiGalleryImages() async {
    final imagesList = await imagePicker.pickMultiImage();
    if (imagesList.isEmpty) {
      throw ImageNotSelectedException();
    }
    return imagesList.map((e) => e.path).toList();
  }

  @override
  Future<String> cameraImage() async {
    final image = await imagePicker.pickImage(source: ImageSource.camera);
    if (image == null) {
      throw ImageNotSelectedException();
    }
    return image.path;
  }

  @override
  Future<String> galleryImage() async {
    final image = await imagePicker.pickImage(source: ImageSource.gallery);
    if (image == null) {
      throw ImageNotSelectedException();
    }
    return image.path;
  }
}

class ImageNotSelectedException implements Exception {}
