import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class PickProfilePicController extends GetxController {
  XFile? _selectedImage;

  XFile? get selectedImage => _selectedImage;


  Future<void> picProfilePicture() async {
    final imagePicker = ImagePicker();
    final result = await imagePicker.pickImage(source: ImageSource.camera);

    if(result != null) {
      _selectedImage = result;
      update();
    }
  }

}