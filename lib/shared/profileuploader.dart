import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

class Profileuploader {
  final picker = ImagePicker();

  Future<XFile?> pickImageFromCamera() async {
    final pickedImage = await picker.pickImage(source: ImageSource.camera);
    return pickedImage;
  }

  Future<XFile?> cropSelectedImage(XFile imageFile) async {
    CroppedFile? croppedImage =
        await ImageCropper().cropImage(sourcePath: imageFile.path);
    if (croppedImage == null) {
      return null;
    }
    return XFile(croppedImage.path);
  }
}
